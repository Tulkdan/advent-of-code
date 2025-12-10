import gleam/bool
import gleam/list
import gleam/set
import gleam/string

type Coord {
  Coord(x: Int, y: Int)
}

pub fn format_input(input: String) -> List(List(String)) {
  input
  |> string.split("\n")
  |> list.filter_map(fn(x) {
    use <- bool.guard(when: x == "", return: Error(""))

    x
    |> string.split("")
    |> Ok
  })
}

fn neighbours(coordinate: Coord) -> set.Set(Coord) {
  let Coord(x:, y:) = coordinate

  [
    Coord(x: x - 1, y: y - 1),
    Coord(x: x - 1, y: y + 1),
    Coord(x: x + 1, y: y - 1),
    Coord(x: x + 1, y: y + 1),
    Coord(x:, y: y - 1),
    Coord(x:, y: y + 1),
    Coord(x: x - 1, y:),
    Coord(x: x + 1, y:),
  ]
  |> set.from_list
}

fn transform_into_coord(data: List(List(String))) -> set.Set(Coord) {
  use acc, row, y_idx <- list.index_fold(data, set.new())
  use acc2, item, x_idx <- list.index_fold(row, acc)

  case item {
    "@" ->
      acc2
      |> set.insert(Coord(x: x_idx, y: y_idx))
    _ -> acc2
  }
}

pub fn sum_rolls(input: List(List(String))) -> Int {
  let set_coordinates = input |> transform_into_coord

  set_coordinates
  |> set.to_list
  |> list.fold(0, fn(acc, coord) {
    let qtt =
      coord
      |> neighbours
      |> set.intersection(set_coordinates)
      |> set.size

    use <- bool.guard(when: qtt < 4, return: acc + 1)

    acc
  })
}
