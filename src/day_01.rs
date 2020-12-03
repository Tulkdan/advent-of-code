pub fn find_two_values_that_sum_to_n(inputs: &Vec<u64>, n: u64) -> (u64, u64) {
    let mut initial = 0;
    let mut end = inputs.len() - 1;

    let values = loop {
        let sum = inputs[initial] + inputs[end];
        if sum > n {
            end -= 1;
        } else if sum < n {
            initial += 1;
        } else {
            break (inputs[initial], inputs[end]);
        }
    };

    values
}

pub fn find_three_values_that_sum_to_n(inputs: &Vec<u64>, n: u64) -> Option<(u64, u64, u64)> {
    for first_item in 0..inputs.len() {
        for second_item in (first_item + 1)..inputs.len() {
            let sum = inputs[first_item] + inputs[second_item];

            if sum >= n {
                break;
            }

            let val3 = n - sum;

            if inputs[second_item + 1..]
                .binary_search(&val3)
                .is_ok()
            {
                return Some((inputs[first_item], val3, inputs[second_item]));
            }
        }
    }

    None
}

#[cfg(test)]
mod tests {
    use super::{find_two_values_that_sum_to_n, find_three_values_that_sum_to_n};
    use std::fs::File;
    use std::io::{BufReader, BufRead};

    fn open_test_file() -> Vec<u64> {
        let input = File::open("input/day_01").unwrap();
        let buffered = BufReader::new(input);

        let mut content: Vec<u64> = buffered.lines()
            .into_iter()
            .filter_map(Result::ok)
            .map(|number| number.parse::<u64>().unwrap())
            .collect();

        content.sort();

        content
    }

    #[test]
    fn sample_input_first_challenge() {
        let sample_input = vec![299, 366, 675, 979, 1456, 1721];

        let values =  find_two_values_that_sum_to_n(&sample_input, 2020);

        assert_eq!((299, 1721), values);
    }

    #[test]
    fn first_challenge() {
        let input = open_test_file();

        let values =  find_two_values_that_sum_to_n(&input, 2020);

        assert_eq!((337, 1683), values);
        assert_eq!(567171, values.0 * values.1);
    }

    #[test]
    fn sample_input_second_challenge() {
        let sample_input = vec![299, 366, 675, 979, 1456, 1721];

        let values =  find_three_values_that_sum_to_n(&sample_input, 2020).unwrap();

        assert_eq!((366, 979, 675), values);
    }

    #[test]
    fn second_challenge() {
        let input = open_test_file();

        let values =  find_three_values_that_sum_to_n(&input, 2020).unwrap();

        assert_eq!((281, 877, 862), values);
        assert_eq!(212428694, values.0 * values.1 * values.2);
    }
}
