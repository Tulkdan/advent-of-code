import day_01.{Command}
import simplifile

pub fn read_file_test() {
  assert "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82"
    |> day_01.format_input
    == [
      Command(operation: "L", value: 68),
      Command(operation: "L", value: 30),
      Command(operation: "R", value: 48),
      Command(operation: "L", value: 5),
      Command(operation: "R", value: 60),
      Command(operation: "L", value: 55),
      Command(operation: "L", value: 1),
      Command(operation: "L", value: 99),
      Command(operation: "R", value: 14),
      Command(operation: "L", value: 82),
    ]
}

pub fn calculate_distances_test() {
  assert "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82"
    |> day_01.format_input
    |> day_01.calculate_distances
    == 3
}

pub fn calculate_distances_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_01")

  assert file
    |> day_01.format_input
    |> day_01.calculate_distances
    == 1105
}
