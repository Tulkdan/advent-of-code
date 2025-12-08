import day_02.{Range}
import simplifile

pub fn read_input_test() {
  assert "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
    |> day_02.format_input
    == [
      Range(min: 11, max: 22),
      Range(min: 95, max: 115),
      Range(min: 998, max: 1012),
      Range(min: 1_188_511_880, max: 1_188_511_890),
      Range(min: 222_220, max: 222_224),
      Range(min: 1_698_522, max: 1_698_528),
      Range(min: 446_443, max: 446_449),
      Range(min: 38_593_856, max: 38_593_862),
      Range(min: 565_653, max: 565_659),
      Range(min: 824_824_821, max: 824_824_827),
      Range(min: 2_121_212_118, max: 2_121_212_124),
    ]
}

pub fn calculate_duplicates_test() {
  assert "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"
    |> day_02.format_input
    |> day_02.calculate_duplicates
    == 1_227_775_554
}

pub fn calculate_duplicates_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_02")

  assert file
    |> day_02.format_input
    |> day_02.calculate_duplicates
    == 18_595_663_903
}
