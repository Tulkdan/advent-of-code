pub fn depth_increased_times(inputs: &Vec<u64>) -> u64 {
    let mut times: u64 = 0;
    let mut previous_value = inputs.first().unwrap();

    for depth in inputs.into_iter() {
        if depth > previous_value {
            times += 1;
        }

        previous_value = depth;
    }

    times
}

pub fn depth_window_increse_times(inputs: &Vec<u64>) -> u64 {
    let mut times: u64 = 0;
    let mut previous_value = inputs.iter()
        .take(3)
        .cloned()
        .reduce(|acc, v| acc + v);

    for i in 1..inputs.len() {
        let scan_group = inputs.iter()
            .skip(i)
            .take(3);

        if scan_group.len() < 3 {
            break;
        }

        let actual_scan = scan_group.cloned()
            .reduce(|acc, v| acc + v);

        if actual_scan > previous_value {
            times += 1;
        }

        previous_value = actual_scan;
    }

    times
}

#[cfg(test)]
mod tests {
    use super::{depth_increased_times, depth_window_increse_times};
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
        let sample_input = vec![199, 200, 208, 210, 200, 207, 240, 269, 260, 263];

        let value =  depth_increased_times(&sample_input);

        assert_eq!(7, value);
    }

    #[test]
    fn first_challenge() {
        let input = open_test_file();

        let value =  depth_increased_times(&input);

        assert_eq!(1400, value);
    }

    #[test]
    fn sample_input_second_challenge() {
        let sample_input = vec![199, 200, 208, 210, 200, 207, 240, 269, 260, 263];

        let values =  depth_window_increse_times(&sample_input);

        assert_eq!(5, values);
    }

    #[test]
    fn second_challenge() {
        let input = open_test_file();

        let values =  depth_window_increse_times(&input);

        assert_eq!(1429, values);
    }
}
