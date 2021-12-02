pub fn example_of_function(_inputs: &Vec<u64>) -> bool {
    true
}

#[cfg(test)]
mod tests {
    use super::{example_of_function};
    use std::fs::File;
    use std::io::{BufReader, BufRead};

    fn open_test_file() -> Vec<u64> {
        let input = File::open("input/day_01").unwrap();
        let buffered = BufReader::new(input);

        let content: Vec<u64> = buffered.lines()
            .into_iter()
            .filter_map(Result::ok)
            .map(|number| number.parse::<u64>().unwrap())
            .collect();

        content
    }

    #[test]
    fn sample_input_first_challenge() {
        let sample_input = vec![299, 366, 675, 979, 1456, 1721];

        let values =  example_of_function(&sample_input);

        assert_eq!(true, values);
    }

    #[test]
    fn first_challenge() {
        let input = open_test_file();

        let values =  example_of_function(&input);

        assert_eq!(true, values);
    }
}
