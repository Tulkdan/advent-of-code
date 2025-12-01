import gleam/bool
import gleam/int
import gleam/list
import gleam/string

pub type Command {
  Command(operation: String, value: Int)
}

fn parse_input_into_commands(
  inputs: List(String),
  acc: List(Command),
) -> List(Command) {
  case inputs {
    [] | [""] -> acc
    [input, ..rest] -> {
      let assert Ok(#(operation, str_value)) = string.pop_grapheme(input)
      let assert Ok(value) = int.parse(str_value)

      [
        Command(operation: operation, value: value),
        ..acc
      ]
      |> parse_input_into_commands(rest, _)
    }
  }
}

pub fn format_input(input: String) -> List(Command) {
  input
  |> string.split("\n")
  |> parse_input_into_commands([])
  |> list.reverse
}

fn calculate_commands(commands: List(Command), position: Int, acc: Int) -> Int {
  case commands {
    [] -> acc
    [command, ..rest] -> {
      let assert Ok(new_value) = case command {
        Command(operation: "R", value: v) -> position + v
        Command(operation: _, value: v) -> {
          let calc = position - v

          use <- bool.guard(when: calc < 0, return: 100 + calc)

          calc
        }
      }
      |> int.modulo(100)

      let new_acc = case new_value {
        0 -> acc + 1
        _ -> acc
      }

      calculate_commands(rest, new_value, new_acc)
    }
  }
}

pub fn calculate_distances(commands: List(Command)) -> Int {
  commands
  |> calculate_commands(50, 0)
}
