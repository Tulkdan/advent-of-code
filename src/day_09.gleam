import gleam/bool
import gleam/int
import gleam/list
import gleam/pair
import gleam/string

type Coordinates =
  List(#(Int, Int))

pub fn format_input(input: String) -> Coordinates {
  use line <- list.filter_map(input |> string.split("\n"))

  use <- bool.guard(when: line == "", return: Error(""))

  let assert [x, y] = line |> string.split(",")
  let assert Ok(new_x) = int.parse(x)
  let assert Ok(new_y) = int.parse(y)

  Ok(#(new_x, new_y))
}

fn calculate_axis_distance(first: #(Int, Int), second: #(Int, Int)) {
  fn(abs_function: fn(#(Int, Int)) -> Int) -> Int {
    let pf = abs_function(first)
    let ps = abs_function(second)

    case pf > ps {
      True -> pf - ps + 1
      _ -> ps - pf + 1
    }
  }
}

fn calculate_distance(first: #(Int, Int), second: #(Int, Int)) -> Int {
  let calculate_with_axis = calculate_axis_distance(first, second)

  calculate_with_axis(pair.first) * calculate_with_axis(pair.second)
}

pub fn calculate_area(coordinates: Coordinates) -> Int {
  coordinates
  |> list.combination_pairs
  |> list.fold(0, fn(acc, values) {
    let #(first, second) = values

    let value = calculate_distance(first, second)

    case value > acc {
      True -> value
      _ -> acc
    }
  })
}
