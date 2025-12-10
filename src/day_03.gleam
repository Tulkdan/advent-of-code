import gleam/bool
import gleam/erlang/process
import gleam/int
import gleam/list
import gleam/otp/actor
import gleam/string

pub fn format_input(input: String) -> List(List(Int)) {
  input
  |> string.split("\n")
  |> list.filter_map(fn(line) {
    use <- bool.guard(when: line == "", return: Error(""))

    line
    |> string.split("")
    |> list.map(fn(b) {
      let assert Ok(b) = int.parse(b)
      b
    })
    |> Ok
  })
}

fn get_highest_numbers(bank: List(Int), acc: #(Int, Int)) -> #(Int, Int) {
  case bank {
    [] -> acc
    [jolt] -> #(jolt, acc.0)
    [jolt, ..rest] -> {
      let #(prev_jolt, prev_acc) = get_highest_numbers(rest, acc)
      let actual_acc = jolt * 10 + prev_jolt

      case jolt > prev_jolt, actual_acc > prev_acc {
        True, True -> #(jolt, actual_acc)
        False, True -> #(prev_jolt, actual_acc)
        True, False -> #(jolt, prev_acc)
        False, False -> #(prev_jolt, prev_acc)
      }
    }
  }
}

pub fn calculate_highest_jolts(banks: List(List(Int))) -> Int {
  let assert Ok(actor) =
    actor.new(0)
    |> actor.on_message(handle_message)
    |> actor.start

  banks
  |> list.each(fn(bank) { process.send(actor.data, FindHighest(bank)) })

  actor.data
  |> process.call(100, GetValue)
}

type Message {
  FindHighest(List(Int))
  GetValue(process.Subject(Int))
}

fn handle_message(state: Int, message: Message) {
  case message {
    FindHighest(bank) -> {
      let #(_, v) = get_highest_numbers(bank, #(0, 0))
      actor.continue(v + state)
    }
    GetValue(reply) -> {
      process.send(reply, state)
      actor.stop()
    }
  }
}
