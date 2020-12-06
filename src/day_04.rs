extern crate regex;

use regex::Regex;

pub fn validate_passports(input: &str) -> usize {
    let passport_fields = parse_input(input);

    let required = vec![Fields::BirthYear, Fields::IssueYear, Fields::ExpirationYear, Fields::Height, Fields::HairColor, Fields::EyeColor, Fields::PassportID];

    let mut valids = 0;

    for passport in passport_fields.into_iter() {
        let fields_count = passport.into_iter()
            .filter(|field| required.contains(field))
            .count();

        if fields_count > 6 {
            valids += 1
        }
    }

    valids
}

#[derive(Debug, Clone, PartialEq)]
pub enum Fields {
    BirthYear,
    IssueYear,
    ExpirationYear,
    Height,
    HairColor,
    EyeColor,
    PassportID,
    CountryID,
}

fn parse_input(input: &str) -> Vec<Vec<Fields>> {
    let mut out = vec![];
    let re = Regex::new(r"(\w{3}):(\S*)").unwrap();

    let mut data: Vec<Fields> = vec![];
    for row in input.lines() {
        if row == "" {
            out.push(data.to_vec());
            data = vec![];
            continue;
        }

        for cap in re.captures_iter(row) {
            let field = match &cap[1] {
                "byr" => Fields::BirthYear,
                "iyr" => Fields::IssueYear,
                "eyr" => Fields::ExpirationYear,
                "hgt" => Fields::Height,
                "hcl" => Fields::HairColor,
                "ecl" => Fields::EyeColor,
                "pid" => Fields::PassportID,
                "cid" => Fields::CountryID,
                _ => { continue; }
            };

            data.push(field);
        }
    }
    out.push(data.to_vec());

    out
}

#[cfg(test)]
mod tests {
    use super::{validate_passports};
    use std::fs::read_to_string;

    fn get_sample_input() -> String {
        read_to_string("input/day_04_sample").unwrap()
    }

    fn get_input() -> String {
        read_to_string("input/day_04").unwrap()
    }

    #[test]
    fn sample() {
        assert_eq!(2, validate_passports(&get_sample_input()));
    }

    #[test]
    fn first_challenge() {
        assert_eq!(210, validate_passports(&get_input()));
    }
}
