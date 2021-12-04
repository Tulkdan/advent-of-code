fn binary_to_decimal(bin: &str) -> u64 {
    let bytes = bin.as_bytes();
    let mut value = 0;

    for (i, &letter) in bytes.into_iter().enumerate() {
        value += match letter {
            b'1' => u64::pow(2, (bin.len() - 1 - i) as u32),
            _ => 0
        }
    }

   value
}

fn flip_bytes_from_binary(bin: &str) -> String {
    let mut inverted_bin = String::with_capacity(bin.len());

    for binary in bin.as_bytes().into_iter() {
        let help = match binary {
            b'1' => '0',
            _ => '1',
        };
        inverted_bin.push(help);
    }

    inverted_bin
}

fn find_bit_that_is_average_each_column(reports: &Vec<String>) -> String {
    let report_output_size = reports.first().unwrap().len();
    let mut gamma_rate_as_binary = String::new();

    for column in 0..report_output_size {
        let mut qtd_of_1 = 0;
        let mut qtd_of_0 = 0;

        for report in reports.iter() {
            match report.as_bytes()[column] {
                b'1' => qtd_of_1 += 1,
                _ => qtd_of_0 += 1,
            }
        }

        if qtd_of_1 > qtd_of_0 {
            gamma_rate_as_binary.push('1')
        } else {
            gamma_rate_as_binary.push('0')
        }
    }

    gamma_rate_as_binary
}

pub fn diagnost_power_consumption(reports: &Vec<String>) -> u64 {
    let gamma_rate_as_binary = find_bit_that_is_average_each_column(reports);

    let gamma_rate = binary_to_decimal(gamma_rate_as_binary.as_str());

    let epsilon_rate_as_binary = flip_bytes_from_binary(gamma_rate_as_binary.as_str());
    let epsilon_rate = binary_to_decimal(epsilon_rate_as_binary.as_str());

    gamma_rate * epsilon_rate
}

#[cfg(test)]
mod tests {
    use super::{
        binary_to_decimal,
        flip_bytes_from_binary,
        find_bit_that_is_average_each_column,
        diagnost_power_consumption,
    };
    use std::fs::File;
    use std::io::{BufReader, BufRead};

    fn get_sample_input() -> Vec<String> {
        vec![
            "00100".to_owned(),
            "11110".to_owned(),
            "10110".to_owned(),
            "10111".to_owned(),
            "10101".to_owned(),
            "01111".to_owned(),
            "00111".to_owned(),
            "11100".to_owned(),
            "10000".to_owned(),
            "11001".to_owned(),
            "00010".to_owned(),
            "01010".to_owned(),
        ]
    }

    fn open_test_file() -> Vec<String> {
        let input = File::open("input/day_03").unwrap();
        let buffered = BufReader::new(input);

        let content: Vec<String> = buffered.lines()
            .into_iter()
            .filter_map(Result::ok)
            .collect();

        content
    }

    #[test]
    fn test_binary_to_decimal() {
        assert_eq!(22, binary_to_decimal("10110"));
        assert_eq!(9,  binary_to_decimal("01001"));
    }

    #[test]
    fn test_fliping_binaries() {
        assert_eq!("01001", flip_bytes_from_binary("10110"));
    }

    #[test]
    fn test_find_bit_average() {
        let sample_input = get_sample_input();
        assert_eq!("10110", find_bit_that_is_average_each_column(&sample_input));
    }

    #[test]
    fn sample_input_first_callenge() {
        let sample_input = get_sample_input();

        let values = diagnost_power_consumption(&sample_input);

        assert_eq!(198, values);
    }

    #[test]
    fn first_callenge() {
        let sample_input = open_test_file();

        let values = diagnost_power_consumption(&sample_input);

        assert_eq!(4174964, values);
    }
}
