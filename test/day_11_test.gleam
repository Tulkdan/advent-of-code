import day_11
import gleam/dict
import simplifile

pub fn read_file_test() {
  assert "aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out
"
    |> day_11.format_input
    |> dict.to_list
    == [
      #("aaa", ["you", "hhh"]),
      #("bbb", ["ddd", "eee"]),
      #("ccc", ["ddd", "eee", "fff"]),
      #("ddd", ["ggg"]),
      #("eee", ["out"]),
      #("fff", ["out"]),
      #("ggg", ["out"]),
      #("hhh", ["ccc", "fff", "iii"]),
      #("iii", ["out"]),
      #("you", ["bbb", "ccc"]),
    ]
}

pub fn calculate_area_test() {
  assert "aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out
"
    |> day_11.format_input
    |> day_11.check_connections
    == 5
}

pub fn calculate_distances_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_11")

  assert file
    |> day_11.format_input
    |> day_11.check_connections
    == 566
}
