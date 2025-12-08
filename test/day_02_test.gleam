import simplifile
import day_02.{Range}

pub fn read_input_test() {
  assert "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
    |> day_02.format_input
    == [
      Range(min: 11, max: 22),
      Range(min: 95, max: 115),
      Range(min: 998, max: 1012),
      Range(min: 1188511880, max: 1188511890),
      Range(min: 222220, max: 222224),
      Range(min: 1698522, max: 1698528),
      Range(min: 446443, max: 446449),
      Range(min: 38593856, max: 38593862),
      Range(min: 565653, max: 565659),
      Range(min: 824824821, max: 824824827),
      Range(min: 2121212118, max: 2121212124),
    ]
}

pub fn calculate_duplicates_test() {
  assert "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
    |> day_02.format_input
    |> day_02.calculate_duplicates
    == 1227775554
}

pub fn calculate_duplicates_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_02")

  assert file
    |> day_02.format_input
    |> day_02.calculate_duplicates
    == 18595663903
}
