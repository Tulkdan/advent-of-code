import gleam/int
import gleam/list
import gleam/order
import gleam/string

pub fn format_input_into_lists(input: String) -> List(List(Int)) {
  input
  |> string.split("\n")
  |> list.filter(fn(x) { x != "" })
  |> list.map(fn(a) {
    string.split(a, " ")
    |> list.map(fn(b) {
      let assert Ok(value) = int.parse(b)
      value
    })
  })
}

fn list_is_safe(input: List(Int), is_increase: order.Order) -> Bool {
  case input {
    [a, b, ..rest] -> {
      case int.compare(a, b), is_increase {
        order.Lt, order.Lt ->
          case a - b {
            -1 | -2 | -3 -> list_is_safe([b, ..rest], order.Lt)
            _ -> False
          }
        order.Gt, order.Gt ->
          case a - b {
            1 | 2 | 3 -> list_is_safe([b, ..rest], order.Gt)
            _ -> False
          }
        _, _ -> False
      }
    }
    _ -> True
  }
}

pub fn calculate_list_is_safe(inputs: List(List(Int))) -> Int {
  inputs
  |> list.fold(0, fn(acc, input) {
    let is_safe = case input {
      [a, b, ..rest] -> {
        case a - b {
          v if v < 0 && v > -4 -> list_is_safe([b, ..rest], order.Lt)
          v if v > 0 && v < 4 -> list_is_safe([b, ..rest], order.Gt)
          _ -> False
        }
      }
      _ -> False
    }

    case is_safe {
      True -> acc + 1
      _ -> acc
    }
  })
}

fn list_is_safe_with_errors(
  input: List(Int),
  is_increase: order.Order,
  has_error: Bool,
) -> Bool {
  case input {
    [a, b, ..rest] -> {
      case int.compare(a, b), is_increase {
        order.Lt, order.Lt ->
          case a - b {
            -1 | -2 | -3 ->
              list_is_safe_with_errors([b, ..rest], order.Lt, has_error)
            _ ->
              case has_error {
                True -> False
                _ -> list_is_safe_with_errors([a, ..rest], order.Lt, True)
              }
          }
        order.Gt, order.Gt ->
          case a - b {
            1 | 2 | 3 ->
              list_is_safe_with_errors([b, ..rest], order.Gt, has_error)
            _ ->
              case has_error {
                True -> False
                _ -> list_is_safe_with_errors([a, ..rest], order.Gt, True)
              }
          }
        _, _ ->
          case has_error {
            True -> False
            _ -> list_is_safe_with_errors([a, ..rest], is_increase, True)
          }
      }
    }
    _ -> True
  }
}

pub fn calculate_list_is_safe_with_unsafe(inputs: List(List(Int))) -> Int {
  inputs
  |> list.fold(0, fn(acc, input) {
    let is_safe = case input {
      [a, b, ..rest] -> {
        case a - b {
          v if v < 0 && v > -4 ->
            list_is_safe_with_errors([b, ..rest], order.Lt, False)
          v if v < 0 -> list_is_safe_with_errors([a, ..rest], order.Lt, True)
          v if v > 0 && v < 4 ->
            list_is_safe_with_errors([b, ..rest], order.Gt, False)
          v if v > 0 -> list_is_safe_with_errors([a, ..rest], order.Gt, True)
          0 -> list_is_safe_with_errors([a, ..rest], order.Eq, True)
          _ -> True
        }
      }
      _ -> True
    }

    case is_safe {
      True -> acc + 1
      _ -> acc
    }
  })
}
