import day_07
import gleam/list
import gleeunit
import gleeunit/should
import simplifile

pub fn main() {
  gleeunit.main()
}

pub fn parse_input_test() {
  [
    "190: 10 19", "3267: 81 40 27", "83: 17 5", "156: 15 6", "7290: 6 8 6 15",
    "161011: 16 10 13", "192: 17 8 14", "21037: 9 7 18 13", "292: 11 6 16 20",
  ]
  |> list.fold("", fn(a, b) { b <> "\n" <> a })
  |> day_07.parse_input
  |> should.equal([
    #(292, [11, 6, 16, 20]),
    #(21_037, [9, 7, 18, 13]),
    #(192, [17, 8, 14]),
    #(161_011, [16, 10, 13]),
    #(7290, [6, 8, 6, 15]),
    #(156, [15, 6]),
    #(83, [17, 5]),
    #(3267, [81, 40, 27]),
    #(190, [10, 19]),
  ])
}

pub fn filter_valid_calibration_test() {
  [
    "190: 10 19", "3267: 81 40 27", "83: 17 5", "156: 15 6", "7290: 6 8 6 15",
    "161011: 16 10 13", "192: 17 8 14", "21037: 9 7 18 13", "292: 11 6 16 20",
  ]
  |> list.fold("", fn(a, b) { b <> "\n" <> a })
  |> day_07.parse_input
  |> day_07.filter_valid_calibration
  |> should.equal([
    #(292, [11, 6, 16, 20]),
    #(3267, [81, 40, 27]),
    #(190, [10, 19]),
  ])
}

pub fn filter_valid_calibration_v2_test() {
  [
    "190: 10 19", "3267: 81 40 27", "83: 17 5", "156: 15 6", "7290: 6 8 6 15",
    "161011: 16 10 13", "192: 17 8 14", "21037: 9 7 18 13", "292: 11 6 16 20",
  ]
  |> list.fold("", fn(a, b) { b <> "\n" <> a })
  |> day_07.parse_input
  |> day_07.filter_valid_calibration_v2
  |> should.equal([
    #(292, [11, 6, 16, 20]),
    #(192, [17, 8, 14]),
    #(7290, [6, 8, 6, 15]),
    #(156, [15, 6]),
    #(3267, [81, 40, 27]),
    #(190, [10, 19]),
  ])
}

pub fn sum_calibration_test() {
  [
    "190: 10 19", "3267: 81 40 27", "83: 17 5", "156: 15 6", "7290: 6 8 6 15",
    "161011: 16 10 13", "192: 17 8 14", "21037: 9 7 18 13", "292: 11 6 16 20",
  ]
  |> list.fold("", fn(a, b) { b <> "\n" <> a })
  |> day_07.parse_input
  |> day_07.filter_valid_calibration
  |> day_07.sum_calibration
  |> should.equal(3749)
}

pub fn sum_calibration_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_07")

  file
  |> day_07.parse_input
  |> day_07.filter_valid_calibration
  |> day_07.sum_calibration
  |> should.equal(66_343_330_034_722)
}

pub fn sum_calibration_v2_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_07")

  file
  |> day_07.parse_input
  |> day_07.filter_valid_calibration_v2
  |> day_07.sum_calibration
  |> should.equal(637_696_070_419_031)
}
