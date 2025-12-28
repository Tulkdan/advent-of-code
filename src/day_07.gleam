import gleam/bool
import gleam/list
import gleam/pair
import gleam/set
import gleam/string

fn fold_line(
  acc: #(Int, set.Set(Int)),
  item: String,
  idx: Int,
) -> #(Int, set.Set(Int)) {
  case item {
    "S" ->
      acc
      |> pair.map_second(fn(a) { a |> set.insert(idx) })
    "^" -> {
      use <- bool.guard(when: !set.contains(acc.1, idx), return: acc)

      acc
      |> pair.map_first(fn(a) { a + 1 })
      |> pair.map_second(fn(a) {
        a
        |> set.delete(idx)
        |> set.insert(idx - 1)
        |> set.insert(idx + 1)
      })
    }
    _ -> acc
  }
}

fn calculate_split(lines: List(List(String)), acc: #(Int, set.Set(Int))) -> Int {
  case lines {
    [] | [[]] -> pair.first(acc)
    [line, ..rest] -> {
      line
      |> list.index_fold(acc, fold_line)
      |> calculate_split(rest, _)
    }
  }
}

pub fn check_beam_split(input: String) -> Int {
  input
  |> string.split("\n")
  |> list.map(fn(i) { string.split(i, "") })
  |> calculate_split(#(0, set.new()))
}
