import gleam/int
import gleam/list
import gleam/option
import gleam/regexp

fn transform_regex_values_to_int(
  submatches: List(option.Option(String)),
) -> List(Int) {
  submatches
  |> option.values
  |> list.map(fn(x) {
    let assert Ok(i) = int.parse(x)
    i
  })
}

fn extract_matches_regex(
  reg: List(regexp.Match),
  acc: List(List(Int)),
) -> List(List(Int)) {
  case reg {
    [regexp.Match(submatches: subs, ..), ..rest] -> {
      let values = transform_regex_values_to_int(subs)

      extract_matches_regex(rest, [values, ..acc])
    }
    _ -> acc
  }
}

pub fn extract_numbers(input: String) -> List(List(Int)) {
  let assert Ok(re) = regexp.from_string("mul\\((\\d+),(\\d+)\\)")

  regexp.scan(with: re, content: input)
  |> extract_matches_regex([])
}

fn multiply_values(input: List(List(Int)), acc: List(Int)) -> List(Int) {
  case input {
    [[first, second], ..rest] -> multiply_values(rest, [first * second, ..acc])
    _ -> acc
  }
}

pub fn calculate_result(inputs: List(List(Int))) -> Int {
  inputs
  |> multiply_values([])
  |> int.sum
}

fn extract_matches_regex_optionally(
  reg: List(regexp.Match),
  should_add: Bool,
  acc: List(List(Int)),
) -> List(List(Int)) {
  case should_add, reg {
    True, [regexp.Match(submatches: [option.None, ..subs], ..), ..rest] -> {
      let values = transform_regex_values_to_int(subs)

      extract_matches_regex_optionally(rest, should_add, [values, ..acc])
    }
    False, [regexp.Match(submatches: [option.None, ..], ..), ..rest] ->
      extract_matches_regex_optionally(rest, should_add, acc)
    _, [regexp.Match(submatches: [option.Some("do()")], ..), ..rest] ->
      extract_matches_regex_optionally(rest, True, acc)
    _, [regexp.Match(submatches: [option.Some("don't()")], ..), ..rest] ->
      extract_matches_regex_optionally(rest, False, acc)
    _, _ -> acc
  }
}

pub fn extract_numbers_with_do_and_dont(input: String) -> List(List(Int)) {
  let assert Ok(re) =
    regexp.from_string("(don't\\(\\)|do\\(\\))|mul\\((\\d+),(\\d+)\\)")

  regexp.scan(with: re, content: input)
  |> extract_matches_regex_optionally(True, [])
}
