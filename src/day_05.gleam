import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/result
import gleam/string

type DictRules =
  Dict(String, List(String))

type Cases =
  List(List(String))

fn parse_rules(rules: List(String), acc_dict: DictRules) -> DictRules {
  case rules {
    [] -> acc_dict
    [rule, ..rest] -> {
      let assert Ok(#(key, value)) = string.split_once(rule, on: "|")

      let new_list_rules = case dict.get(acc_dict, key) {
        Ok(allowed) -> [value, ..allowed]
        Error(_) -> [value]
      }

      acc_dict
      |> dict.insert(key, new_list_rules)
      |> parse_rules(rest, _)
    }
  }
}

pub fn parse_input(input: String) -> #(DictRules, Cases) {
  let assert Ok(#(rules, cases)) = string.split_once(input, on: "\n\n")

  let parsed_rules =
    rules
    |> string.split(on: "\n")
    |> parse_rules(dict.new())

  let parsed_cases =
    cases
    |> string.split(on: "\n")
    |> list.filter_map(with: fn(data) {
      case string.split(data, on: ",") {
        [""] -> Error("")
        splitted -> Ok(splitted)
      }
    })

  #(parsed_rules, parsed_cases)
}

fn is_number_in_every_list(number: String, check_numbers: Cases) -> Bool {
  check_numbers
  |> list.all(fn(a) { a |> list.contains(number) })
}

fn validate_case_with_rules(
  input: List(String),
  allowed_numbers: List(List(String)),
  rules: DictRules,
  acc: Bool,
) -> Bool {
  case acc, input {
    False, _ -> acc
    _, [] -> acc
    _, [n, ..rest] -> {
      let actual_number_rules =
        dict.get(rules, n)
        |> result.unwrap([])

      case allowed_numbers {
        [] -> validate_case_with_rules(rest, [actual_number_rules], rules, acc)
        check_numbers -> {
          case is_number_in_every_list(n, check_numbers) {
            False -> False
            _ ->
              validate_case_with_rules(
                rest,
                [actual_number_rules, ..check_numbers],
                rules,
                acc,
              )
          }
        }
      }
    }
  }
}

pub fn filter_cases(cases: Cases, rules: DictRules) -> Cases {
  cases
  |> list.filter(fn(c) { validate_case_with_rules(c, [], rules, True) })
}

pub fn calculate_middle_number(cases: Cases) -> Int {
  cases
  |> list.map(fn(c) {
    let idx_middle = list.length(c) / 2

    let assert Ok(i) =
      c
      |> list.take(idx_middle + 1)
      |> list.last
      |> result.unwrap("0")
      |> int.parse
    i
  })
  |> list.fold(0, int.add)
}
