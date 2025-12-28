import gleam/bool
import gleam/int
import gleam/list
import gleam/string

pub type Operation {
  Operation(op: String, numbers: List(Int))
}

pub fn format_input(input: String) -> List(Operation) {
  input
  |> string.split("\n")
  |> list.filter_map(fn(line) {
    use <- bool.guard(when: line == "", return: Error(""))

    line
    |> string.split(" ")
    |> list.filter(fn(i) { i != "" })
    |> Ok
  })
  |> list.transpose
  |> list.map(fn(data) {
    data
    |> list.fold_right(Operation(op: "", numbers: []), fn(acc, a) {
      case a {
        "*" | "+" -> Operation(op: a, numbers: [])
        _ -> {
          let assert Ok(i) = int.parse(a)
          Operation(op: acc.op, numbers: [i, ..acc.numbers])
        }
      }
    })
  })
}

fn multiply_list(numbers: List(Int)) -> Int {
  numbers
  |> list.fold(1, fn(acc, number) { acc * number })
}

fn sum_list(numbers: List(Int)) -> Int {
  numbers
  |> list.fold(0, fn(acc, number) { acc + number })
}

pub fn calculate_worksheet(operations: List(Operation)) -> Int {
  operations
  |> list.fold(0, fn(acc, operation) {
    let calc = case operation {
      Operation(op: "*", numbers: numbers) -> multiply_list(numbers)
      Operation(op: _, numbers: numbers) -> sum_list(numbers)
    }

    acc + calc
  })
}
