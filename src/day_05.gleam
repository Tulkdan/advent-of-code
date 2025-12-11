import gleam/int
import gleam/list
import gleam/set
import gleam/string

pub fn format_input(input: String) -> #(List(#(Int, Int)), List(Int)) {
  let assert [fresh_input, available_input] = input |> string.split("\n\n")

  let fresh =
    fresh_input
    |> string.split("\n")
    |> list.map(fn(i) {
      let assert Ok([start, stop]) =
        i
        |> string.split("-")
        |> list.try_map(int.parse)

      #(start, stop)
    })

  let assert Ok(available) =
    available_input
    |> string.split("\n")
    |> list.filter(fn(a) { a != "" })
    |> list.try_map(int.parse)

  #(fresh, available)
}

pub fn get_freshness_quantity(data: #(List(#(Int, Int)), List(Int))) -> Int {
  let #(fresh, available) = data

  use acc, a <- list.fold(available, 0)

  let exists = {
    use #(start, stop) <- list.find(fresh)
    start <= a && a <= stop
  }

  case exists {
    Ok(_) -> acc + 1
    _ -> acc
  }
}
