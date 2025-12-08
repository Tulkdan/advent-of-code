import gleam/bool
import gleam/erlang/process
import gleam/int
import gleam/list
import gleam/otp/actor
import gleam/string

pub type Range {
  Range(min: Int, max: Int)
}

pub fn format_input(input: String) -> List(Range) {
  input
  |> string.split(",")
  |> list.map(fn(range) {
    let assert [min, max] =
      range
      |> string.replace(each: "\n", with: "")
      |> string.split("-")
    let assert Ok(min_int) = int.parse(min)
    let assert Ok(max_int) = int.parse(max)

    Range(min: min_int, max: max_int)
  })
}

fn is_repeated(number: String) -> Bool {
  let number_length = string.length(number)

  use <- bool.guard(when: number_length % 2 != 0, return: False)

  number
  |> string.slice(at_index: number_length / 2, length: number_length)
  |> string.starts_with(number, _)
}

fn find_duplicates(range: Range, acc: List(Int)) -> List(Int) {
  let Range(min: min, max: max) = range

  use <- bool.guard(when: min > max, return: acc)

  let new_acc = case min |> int.to_string |> is_repeated {
    True -> [min, ..acc]
    False -> acc
  }

  Range(min: min + 1, max: max)
  |> find_duplicates(new_acc)
}

pub fn calculate_duplicates(ranges: List(Range)) -> Int {
  let assert Ok(actor) =
    actor.new([])
    |> actor.on_message(handle_message)
    |> actor.start

  ranges
  |> list.each(fn(range) { process.send(actor.data, FindDuplicates(range)) })

  actor.data
  |> process.call(1000, GetValue)
  |> list.fold(0, fn(a, b) { a + b })
}

type Message {
  FindDuplicates(Range)
  GetValue(process.Subject(List(Int)))
}

fn handle_message(state: List(Int), message: Message) {
  case message {
    FindDuplicates(range) -> {
      range
      |> find_duplicates([])
      |> list.append(state)
      |> actor.continue
    }
    GetValue(reply) -> {
      process.send(reply, state)
      actor.stop()
    }
  }
}
