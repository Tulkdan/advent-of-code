import day_09
import simplifile

pub fn read_file_test() {
  assert "7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3"
    |> day_09.format_input
    == [
      #(7, 1),
      #(11, 1),
      #(11, 7),
      #(9, 7),
      #(9, 5),
      #(2, 5),
      #(2, 3),
      #(7, 3),
    ]
}

pub fn calculate_area_test() {
  assert "7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3"
    |> day_09.format_input
    |> day_09.calculate_area
    == 50
}

pub fn calculate_distances_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_09")

  assert file
    |> day_09.format_input
    |> day_09.calculate_area
    == 4_758_121_828
}
