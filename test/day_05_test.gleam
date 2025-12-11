import day_05
import simplifile

pub fn read_file_test() {
  assert "3-5
10-14
16-20
12-18

1
5
8
11
17
32
"
    |> day_05.format_input
    == #([#(3, 5), #(10, 14), #(16, 20), #(12, 18)], [1, 5, 8, 11, 17, 32])
}

pub fn get_freshness_quantity_test() {
  assert "3-5
10-14
16-20
12-18

1
5
8
11
17
32
"
    |> day_05.format_input
    |> day_05.get_freshness_quantity
    == 3
}

pub fn get_freshness_quantity_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_05")

  assert file
    |> day_05.format_input
    |> day_05.get_freshness_quantity
    == 525
}
