extern crate regex;

use regex::Regex;

pub fn password_validator(passwords: &Vec<String>) -> usize {
    let re = Regex::new(r"(\d+)-(\d+) (\w): (.*)").unwrap();
    let mut valid_count = 0;

    for password in passwords {
        let cap = re.captures(password).unwrap();
        let min = cap[1].parse::<usize>().unwrap();
        let max = cap[2].parse::<usize>().unwrap();
        let character = cap[3].chars().collect::<Vec<char>>()[0];
        let pass = &cap[4];

        let mut count = 0;
        for pw_character in pass.bytes() {
            if character as u8 == pw_character {
                count += 1;
            }
        }

        if count >= min && count <= max {
            valid_count += 1;
        }
    }

    valid_count
}

#[cfg(test)]
mod tests {
    use super::{password_validator};
    use std::fs::File;
    use std::io::{BufReader, BufRead};

    fn open_test_file() -> Vec<String> {
        let input = File::open("input/day_02").unwrap();
        let buffered = BufReader::new(input);

        let mut content: Vec<String> = buffered.lines()
            .into_iter()
            .filter_map(Result::ok)
            .collect();

        content.sort();

        content
    }

    #[test]
    fn sample_input_first_challenge() {
        let sample_input = vec![
            "1-3 a: abcde".to_owned(),
            "1-3 b: cdefg".to_owned(),
            "2-9 c: ccccccccc".to_owned()
        ];

        let values = password_validator(&sample_input);

        assert_eq!(2, values);
    }

    #[test]
    fn first_challenge() {
        let input = open_test_file();

        let values = password_validator(&input);

        assert_eq!(467, values);
    }
}
