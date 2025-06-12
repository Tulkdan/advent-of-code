import day_01
import simplifile

pub fn read_file_test() {
  assert "3   4\n4   3\n2   5\n1   3\n3   9\n3   3\n"
    |> day_01.format_input_into_lists
    == #([3, 3, 1, 2, 4, 3], [3, 9, 3, 5, 3, 4])
}

pub fn calculate_distances_test() {
  assert "3   4\n4   3\n2   5\n1   3\n3   9\n3   3\n"
    |> day_01.format_input_into_lists
    |> day_01.calculate_distances
    == 11
}

pub fn calculate_distances_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_01")

  assert file
    |> day_01.format_input_into_lists
    |> day_01.calculate_distances
    == 2_904_518
}

pub fn calculate_similarity_test() {
  assert "3   4\n4   3\n2   5\n1   3\n3   9\n3   3\n"
    |> day_01.format_input_into_lists
    |> day_01.calculate_similarity
    == 31
}

pub fn calculate_similarity_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_01")

  assert file
    |> day_01.format_input_into_lists
    |> day_01.calculate_similarity
    == 18_650_129
}
