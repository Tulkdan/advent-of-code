import gleam/int
import gleam/list
import gleam/string

fn create_lists(
  inputs: List(String),
  acc: #(List(Int), List(Int)),
) -> #(List(Int), List(Int)) {
  case inputs {
    [] | [""] -> acc
    [input, ..rest] -> {
      let assert Ok(#(first, second)) = string.split_once(input, "   ")
      let #(left_list, right_list) = acc
      let assert Ok(left_num) = int.parse(first)
      let assert Ok(right_num) = int.parse(second)

      create_lists(rest, #([left_num, ..left_list], [right_num, ..right_list]))
    }
  }
}

pub fn format_input_into_lists(input: String) -> #(List(Int), List(Int)) {
  input
  |> string.split("\n")
  |> create_lists(#([], []))
}

fn calculate_distance_between_lists(
  acc: Int,
  left: List(Int),
  right: List(Int),
) -> Int {
  case left, right {
    [l, ..l_rest], [r, ..r_rest] ->
      int.absolute_value(l - r)
      |> int.add(acc)
      |> calculate_distance_between_lists(l_rest, r_rest)
    _, _ -> acc
  }
}

pub fn calculate_distances(inputs: #(List(Int), List(Int))) -> Int {
  let #(left_list, right_list) = inputs
  let left = list.sort(left_list, int.compare)
  let right = list.sort(right_list, int.compare)

  0
  |> calculate_distance_between_lists(left, right)
}

fn find_numbers_appears_in_list(
  acc: List(#(Int, Int)),
  input: Int,
) -> List(#(Int, Int)) {
  case acc {
    [#(idx_num, times), ..rest] if idx_num == input -> [
      #(idx_num, times + 1),
      ..rest
    ]
    [first, ..rest] -> [first, ..find_numbers_appears_in_list(rest, input)]
    _ -> [#(input, 1), ..acc]
  }
}

pub fn calculate_similarity(inputs: #(List(Int), List(Int))) -> Int {
  let #(left_list, right_list) = inputs

  let number_times_in_right =
    right_list
    |> list.fold([], find_numbers_appears_in_list)

  left_list
  |> list.map(fn(input) {
    case
      list.find(number_times_in_right, fn(x) {
        let #(idx, _) = x
        idx == input
      })
    {
      Ok(#(_, qtt)) -> input * qtt
      _ -> 0
    }
  })
  |> int.sum
}
