import gleam/bool
import gleam/int
import gleam/list
import gleam/pair
import gleam/string

pub type Command {
  Command(operation: String, value: Int)
}

pub fn format_input(input: String) -> List(Command) {
  input
  |> string.split("\n")
  |> list.filter_map(fn(input) {
    use <- bool.guard(when: input == "", return: Error(""))

    let assert Ok(#(operation, str_value)) = string.pop_grapheme(input)
    let assert Ok(value) = int.parse(str_value)

    Command(operation: operation, value: value)
    |> Ok
  })
}

fn calculate_commands(acc: #(Int, Int), command: Command) -> #(Int, Int) {
  let #(position, total) = acc

  let assert Ok(new_value) =
    case command {
      Command(operation: "R", value: v) -> position + v
      Command(operation: _, value: v) -> {
        let calc = position - v

        use <- bool.guard(when: calc < 0, return: 100 + calc)

        calc
      }
    }
    |> int.modulo(100)

  let new_total = case new_value {
    0 -> total + 1
    _ -> total
  }

  #(new_value, new_total)
}

pub fn calculate_distances(commands: List(Command)) -> Int {
  commands
  |> list.fold(#(50, 0), calculate_commands)
  |> pair.second
}
