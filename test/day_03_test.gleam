import day_03
import gleeunit
import gleeunit/should
import simplifile

pub fn main() {
  gleeunit.main()
}

pub fn regex_extraction_test() {
  "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
  |> day_03.extract_numbers
  |> should.equal([[8, 5], [11, 8], [5, 5], [2, 4]])
}

pub fn calculate_result_test() {
  "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
  |> day_03.extract_numbers
  |> day_03.calculate_result
  |> should.equal(161)
}

pub fn calculate_result_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_03")

  file
  |> day_03.extract_numbers
  |> day_03.calculate_result
  |> should.equal(167_650_499)
}

pub fn regex_extraction_with_do_and_dont_test() {
  "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
  |> day_03.extract_numbers_with_do_and_dont
  |> should.equal([[8, 5], [2, 4]])
}

pub fn calculate_result_with_do_and_dont_test() {
  "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
  |> day_03.extract_numbers_with_do_and_dont
  |> day_03.calculate_result
  |> should.equal(48)
}

pub fn calculate_result_with_do_and_dont_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_03")

  file
  |> day_03.extract_numbers_with_do_and_dont
  |> day_03.calculate_result
  |> should.equal(95_846_796)
}
