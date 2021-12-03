extern crate regex;

use regex::Regex;

pub fn calculate_position(commands: &Vec<String>) -> u64 {
    let mut depth: u64 = 0;
    let mut horizontal: u64 = 0;

    for command in commands.into_iter() {
        let re = Regex::new(r"(\w+) (\d+)").unwrap();

        let cap = re.captures(command).unwrap();

        let action = &cap[1];
        let value = cap[2].parse::<u64>().unwrap();

        match action {
            "forward" => { horizontal += value; },
            "down" => { depth += value; },
            "up" => { depth -= value; },
            _ => {}
        };
    }

    depth * horizontal
}

pub fn calculate_position_with_aim(commands: &Vec<String>) -> u64 {
    let mut depth: u64 = 0;
    let mut horizontal: u64 = 0;
    let mut aim: u64 = 0;

    for command in commands.into_iter() {
        let re = Regex::new(r"(\w+) (\d+)").unwrap();

        let cap = re.captures(command).unwrap();

        let action = &cap[1];
        let value = cap[2].parse::<u64>().unwrap();

        match action {
            "forward" => {
                horizontal += value;

                if aim > 0 {
                    depth += aim * value;
                }
            },
            "down" => {
                aim += value;
            },
            "up" => {
                aim -= value;
            },
            _ => {}
        };
    }

    depth * horizontal
}

#[cfg(test)]
mod tests {
    use super::{calculate_position, calculate_position_with_aim};
    use std::fs::File;
    use std::io::{BufReader, BufRead};

    fn get_sample_input() -> Vec<String> {
        vec![
            "forward 5".to_owned(),
            "down 5".to_owned(),
            "forward 8".to_owned(),
            "up 3".to_owned(),
            "down 8".to_owned(),
            "forward 2".to_owned()
        ]
    }

    fn open_test_file() -> Vec<String> {
        let input = File::open("input/day_02").unwrap();
        let buffered = BufReader::new(input);

        let content: Vec<String> = buffered.lines()
            .into_iter()
            .filter_map(Result::ok)
            .collect();

        content
    }

    #[test]
    fn sample_input_first_challenge() {
        let sample_input = get_sample_input();

        let values = calculate_position(&sample_input);

        assert_eq!(150, values);
    }

    #[test]
    fn first_challenge() {
        let input = open_test_file();

        let values = calculate_position(&input);

        assert_eq!(1654760, values);
    }

    #[test]
    fn sample_input_second_challenge() {
        let sample_input = get_sample_input();

        let values = calculate_position_with_aim(&sample_input);

        assert_eq!(900, values);
    }

    #[test]
    fn second_challenge() {
        let input = open_test_file();

        let values = calculate_position_with_aim(&input);

        assert_eq!(1956047400, values);
    }
}
