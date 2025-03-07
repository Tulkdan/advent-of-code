import day_01
import gleeunit
import gleeunit/should
import simplifile

pub fn main() {
  gleeunit.main()
}

pub fn read_file_test() {
  "3   4\n4   3\n2   5\n1   3\n3   9\n3   3\n"
  |> day_01.format_input_into_lists
  |> should.equal(#([3, 3, 1, 2, 4, 3], [3, 9, 3, 5, 3, 4]))
}

pub fn calculate_distances_test() {
  "3   4\n4   3\n2   5\n1   3\n3   9\n3   3\n"
  |> day_01.format_input_into_lists
  |> day_01.calculate_distances
  |> should.equal(11)
}

pub fn calculate_distances_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_01")

  file
  |> day_01.format_input_into_lists
  |> day_01.calculate_distances
  |> should.equal(2_904_518)
}

pub fn calculate_similarity_test() {
  "3   4\n4   3\n2   5\n1   3\n3   9\n3   3\n"
  |> day_01.format_input_into_lists
  |> day_01.calculate_similarity
  |> should.equal(31)
}

pub fn calculate_similarity_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_01")

  file
  |> day_01.format_input_into_lists
  |> day_01.calculate_similarity
  |> should.equal(18_650_129)
}
