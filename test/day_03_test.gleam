import day_03
import simplifile

pub fn read_input_test() {
  assert "987654321111111\n811111111111119\n234234234234278\n818181911112111"
    |> day_03.format_input
    == [
      [9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 1, 1, 1, 1, 1],
      [8, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 9],
      [2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 3, 4, 2, 7, 8],
      [8, 1, 8, 1, 8, 1, 9, 1, 1, 1, 1, 2, 1, 1, 1],
    ]
}

pub fn calculate_jolts_test() {
  assert "987654321111111\n811111111111119\n234234234234278\n818181911112111"
    |> day_03.format_input
    |> day_03.calculate_highest_jolts
    == 357
}

pub fn calculate_jolts_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_03")

  assert file
    |> day_03.format_input
    |> day_03.calculate_highest_jolts
    == 17_311
}
