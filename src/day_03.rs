pub fn count_trees(input: &str, slope_right: usize, slope_down: usize) -> usize {
    let map = parse_input(input);

    let mut tree_collision = 0;
    let mut position = 0;

    for row in map.iter().step_by(slope_down).skip(1) {
        position += slope_right;
        position %= row.len();

        if row[position] == Space::Tree {
            tree_collision += 1;
        }
    }

    tree_collision
}

#[derive(Debug, PartialEq)]
pub enum Space {
    Open,
    Tree,
}

fn parse_input(input: &str) -> Vec<Vec<Space>> {
    let mut out = vec![];
    let width = input.lines().next().unwrap().len();

    for raw_row in input.lines() {
        let mut row = Vec::with_capacity(width);
        for byte in raw_row.bytes() {
            let space = match byte {
                b'.' => Space::Open,
                b'#' => Space::Tree,
                _ => { continue; }
            };

            row.push(space);
        }

        out.push(row);
    }

    out
}

#[cfg(test)]
mod tests {
    use super::{count_trees};
    use std::fs::read_to_string;

    fn get_sample_input() -> String {
        read_to_string("input/day_03_sample").unwrap()
    }

    fn get_test_input() -> String {
        read_to_string("input/day_03").unwrap()
    }

    #[test]
    fn sample() {
        assert_eq!(7, count_trees(&get_sample_input(), 3, 1));
    }

    #[test]
    fn first_challenge() {
        assert_eq!(205, count_trees(&get_test_input(), 3, 1));
    }

    #[test]
    fn second_challenge() {
        let trees = get_test_input();

        let tests = vec![(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)];

        let mut result = 1;
        for (slope_right, slope_down) in tests {
            result *= count_trees(&trees, slope_right, slope_down);
        }

        assert_eq!(3952146825, result);
    }
}
