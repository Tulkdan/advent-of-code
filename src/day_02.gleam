import gleam/bool
import gleam/int
import gleam/list
import gleam/string

pub type Range {
  Range(min: Int, max: Int)
}

pub fn format_input(input: String) -> List(Range) {
  input
  |> string.split(",")
  |> list.map(fn (range) {
    let assert [min, max] = 
      range
      |> string.replace(each: "\n", with: "")
      |> string.split("-")
    let assert Ok(min_int) = int.parse(min)
    let assert Ok(max_int) = int.parse(max)

    Range(min: min_int, max: max_int)
  })
}

fn is_repeated(number: String) -> Bool {
  let number_length = string.length(number)

  use <- bool.guard(when: number_length % 2 != 0, return: False)

  number
  |> string.slice(at_index: number_length / 2, length: number_length)
  |> string.starts_with(number, _)
}

fn find_duplicates(range: Range, acc: List(Int)) -> List(Int) {
  let Range(min: min, max: max) = range

  use <- bool.guard(when: min > max, return: acc)

  case min |> int.to_string |> is_repeated {
    True -> find_duplicates(
      Range(min: min + 1, max: max),
      [min, ..acc]
    )
    False -> find_duplicates(
      Range(min: min + 1, max: max),
      acc
    )
  }
}

pub fn calculate_duplicates(ranges: List(Range)) -> Int {
  ranges
  |> list.fold(0, fn (acc, range) {
    let arr = range
    |> find_duplicates([])
    |> list.fold(0, fn (a, b) { a + b })

    acc + arr
  })
}
