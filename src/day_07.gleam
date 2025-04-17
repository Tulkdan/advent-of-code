import gleam/bool
import gleam/int
import gleam/list
import gleam/result
import gleam/string

type Calibration =
  #(Int, List(Int))

fn parse_line(line: String) -> Calibration {
  let assert Ok(#(key, values)) = line |> string.split_once(on: ": ")

  let value_key = key |> int.parse |> result.unwrap(0)

  let int_values =
    values
    |> string.split(on: " ")
    |> list.map(fn(v) { v |> int.parse |> result.unwrap(0) })

  #(value_key, int_values)
}

pub fn parse_input(input: String) -> List(Calibration) {
  input
  |> string.split(on: "\n")
  |> list.filter_map(fn(i) {
    case i {
      "" -> Error("")
      a -> Ok(parse_line(a))
    }
  })
}

fn validate_calibration(
  numbers_to_operate: List(Int),
  target: Int,
  acc_number: Int,
  acc: Bool,
) -> Bool {
  case numbers_to_operate {
    [] -> acc_number == target
    [number, ..rest] -> {
      let sum = validate_calibration(rest, target, acc_number + number, acc)
      use <- bool.guard(when: sum, return: sum)

      case acc_number {
        0 -> validate_calibration(rest, target, number, acc)
        n -> validate_calibration(rest, target, n * number, acc)
      }
    }
  }
}

pub fn filter_valid_calibration(
  calibrations: List(Calibration),
) -> List(Calibration) {
  calibrations
  |> list.filter(fn(calibration) {
    let #(target, numbers_to_operate) = calibration
    validate_calibration(numbers_to_operate, target, 0, False)
  })
}

pub fn sum_calibration(calibrations: List(Calibration)) -> Int {
  calibrations
  |> list.fold(0, fn(acc, calibration) {
    let #(v, _) = calibration
    acc + v
  })
}

fn validate_calibration_v2(
  numbers_to_operate: List(Int),
  target: Int,
  acc_number: Int,
  acc: Bool,
) -> Bool {
  case numbers_to_operate {
    [] -> acc_number == target
    [number, ..rest] -> {
      let sum = validate_calibration_v2(rest, target, acc_number + number, acc)
      use <- bool.guard(when: sum, return: sum)

      let mul = case acc_number {
        0 -> validate_calibration_v2(rest, target, number, acc)
        n -> validate_calibration_v2(rest, target, n * number, acc)
      }
      use <- bool.guard(when: mul, return: mul)

      case acc_number {
        0 -> validate_calibration_v2(rest, target, number, acc)
        n -> {
          let concat =
            { int.to_string(n) <> int.to_string(number) }
            |> int.parse
            |> result.unwrap(0)

          validate_calibration_v2(rest, target, concat, acc)
        }
      }
    }
  }
}

pub fn filter_valid_calibration_v2(
  calibrations: List(Calibration),
) -> List(Calibration) {
  calibrations
  |> list.filter(fn(calibration) {
    let #(target, numbers_to_operate) = calibration
    validate_calibration_v2(numbers_to_operate, target, 0, False)
  })
}
