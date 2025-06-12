import day_05
import gleam/dict
import simplifile

pub fn parse_input_test() {
  let assert Ok(file) = simplifile.read("input/day_05.test")

  let dict_of_rules =
    dict.from_list([
      #("29", ["13"]),
      #("47", ["29", "61", "13", "53"]),
      #("53", ["13", "29"]),
      #("61", ["29", "53", "13"]),
      #("75", ["13", "61", "47", "53", "29"]),
      #("97", ["75", "53", "29", "47", "61", "13"]),
    ])

  let list_of_cases = [
    ["75", "47", "61", "53", "29"],
    ["97", "61", "53", "29", "13"],
    ["75", "29", "13"],
    ["75", "97", "47", "61", "53"],
    ["61", "13", "29"],
    ["97", "13", "75", "29", "47"],
  ]

  let #(rules, cases) =
    file
    |> day_05.parse_input

  assert rules == dict_of_rules
  assert cases == list_of_cases
}

pub fn filter_correct_cases_test() {
  let assert Ok(file) = simplifile.read("input/day_05.test")

  let #(rules, cases) =
    file
    |> day_05.parse_input

  assert cases
    |> day_05.filter_cases(rules)
    == [
      ["75", "47", "61", "53", "29"],
      ["97", "61", "53", "29", "13"],
      ["75", "29", "13"],
    ]
}

pub fn calculate_middle_number_of_cases_test() {
  let assert Ok(file) = simplifile.read("input/day_05.test")

  let #(rules, cases) =
    file
    |> day_05.parse_input

  assert cases
    |> day_05.filter_cases(rules)
    |> day_05.calculate_middle_number
    == 143
}

pub fn calculate_middle_number_of_cases_for_real_test() {
  let assert Ok(file) = simplifile.read("input/day_05")

  let #(rules, cases) =
    file
    |> day_05.parse_input

  assert cases
    |> day_05.filter_cases(rules)
    |> day_05.calculate_middle_number
    == 5374
}
