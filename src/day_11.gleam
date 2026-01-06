import gleam/bool
import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn format_input(input: String) -> Dict(String, List(String)) {
  use acc, line <- list.fold(input |> string.split("\n"), dict.new())

  use <- bool.guard(when: line == "", return: acc)

  let assert [key, line_values] = string.split(line, ": ")
  let values = string.split(line_values, " ")

  acc
  |> dict.insert(key, values)
}

fn recursive_graph(
  connections: Dict(String, List(String)),
  values: List(String),
  acc: Int,
) -> Int {
  case values {
    [] -> acc
    ["out"] -> acc + 1
    [head, ..tail] -> {
      let assert Ok(new_values) = connections |> dict.get(head)

      let new_acc = recursive_graph(connections, new_values, acc)

      recursive_graph(connections, tail, new_acc)
    }
  }
}

pub fn check_connections(connections: Dict(String, List(String))) -> Int {
  let assert Ok(root) = connections |> dict.get("you")

  connections
  |> recursive_graph(root, 0)
}
