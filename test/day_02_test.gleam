import day_02
import simplifile

pub fn read_file_test() {
  assert "7 6 4 2 1\n1 2 7 8 9\n9 7 6 2 1\n1 3 2 4 5\n8 6 4 4 1\n1 3 6 7 9"
    |> day_02.format_input_into_lists
    == [
      [7, 6, 4, 2, 1],
      [1, 2, 7, 8, 9],
      [9, 7, 6, 2, 1],
      [1, 3, 2, 4, 5],
      [8, 6, 4, 4, 1],
      [1, 3, 6, 7, 9],
    ]
}

pub fn calculate_list_is_safe_test() {
  assert "7 6 4 2 1\n1 2 7 8 9\n9 7 6 2 1\n1 3 2 4 5\n8 6 4 4 1\n1 3 6 7 9"
    |> day_02.format_input_into_lists
    |> day_02.calculate_list_is_safe
    == 2
}

pub fn calculate_list_is_safe_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_02")

  assert file
    |> day_02.format_input_into_lists
    |> day_02.calculate_list_is_safe
    == 220
}

pub fn calculate_list_is_safe_with_unsafe_item_test() {
  assert "7 6 4 2 1\n1 2 7 8 9\n9 7 6 2 1\n1 3 2 4 5\n8 6 4 4 1\n1 3 6 7 9"
    |> day_02.format_input_into_lists
    |> day_02.calculate_list_is_safe_with_unsafe
    == 4
}

pub fn calculate_list_is_safe_with_unsafe_item_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_02")

  assert file
    |> day_02.format_input_into_lists
    |> day_02.calculate_list_is_safe_with_unsafe
    == 268
}
