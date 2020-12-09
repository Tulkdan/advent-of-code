#[derive(Debug, Clone, PartialEq)]
pub enum Actions {
    Upper,
    Lower,
}

const ROWS: u16 = 127;
const COLUMNS: u16 = 7;

pub fn translate_seat(input: &str) -> (u16, u16) {
    let actions: Vec<Actions> = input
        .chars()
        .map(|c| match c {
            'F' | 'L' => Actions::Lower,
            'B' | 'R' | _ => Actions::Upper,
        }).collect();

    let rows = actions[0..7].to_vec();
    let columns = actions[7..].to_vec();

    let row_num = calculate(&rows, &ROWS);
    let column_num = calculate(&columns, &COLUMNS);

    (row_num, column_num)
}

fn calculate(rows: &Vec<Actions>, limit: &u16) -> u16 {
    let mut initial: u16 = 0;
    let mut end = *limit;

    for action in rows.into_iter() {
        println!("({} - {}) / 2", end, initial);
        let middle: u16 = (end - initial) / 2;
        println!("{}, {:?}", middle, action);

        if *action == Actions::Upper {
            initial += middle + 1;
        } else if *action == Actions::Lower {
            end = initial + middle;
        }
    }

    initial 
}

#[cfg(test)]
mod tests {
    use super::{translate_seat};
    use std::fs::read_to_string;

    fn get_input() -> String {
        read_to_string("input/day_05").unwrap()
    }

    fn calculate_result(result: &(u16, u16)) -> u16 {
        result.0 * 8 + result.1
    }

    #[test]
    fn sample() {
        let mut result = translate_seat("FBFBBFFRLR");
        assert_eq!(357, calculate_result(&result));

        result = translate_seat("BFFFBBFRRR");
        assert_eq!(567, calculate_result(&result));

        result = translate_seat("FFFBBBFRRR");
        assert_eq!(119, calculate_result(&result));

        result = translate_seat("BBFFBBFRLL");
        assert_eq!(820, calculate_result(&result));
    }

    #[test]
    fn first_challenge() {
        let inputs = get_input();

        let mut bigger = 0;

        for input in inputs.lines() {
            let result = calculate_result(&translate_seat(input));
            if result > bigger {
                bigger = result
            }
        }

        assert_eq!(974, bigger);
    }
}
