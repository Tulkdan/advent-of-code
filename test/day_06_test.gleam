import day_06
import simplifile

pub fn read_file_test() {
  assert "123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +
"
    |> day_06.format_input
    == [
      day_06.Operation(op: "*", numbers: [123, 45, 6]),
      day_06.Operation(op: "+", numbers: [328, 64, 98]),
      day_06.Operation(op: "*", numbers: [51, 387, 215]),
      day_06.Operation(op: "+", numbers: [64, 23, 314]),
    ]
}

pub fn calculate_worksheet_test() {
  assert "123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +
"
    |> day_06.format_input
    |> day_06.calculate_worksheet
    == 4_277_556
}

pub fn get_freshness_quantity_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_06")

  assert file
    |> day_06.format_input
    |> day_06.calculate_worksheet
    == 5_784_380_717_354
}
