
library(command)
library(dplyr, warn.conflicts = FALSE)
library(readr)

cmd_assign(.abs = "data/ABS_DEATHS_INDIGENOUS_1.0.0.csv.gz",
           age_groups = "out/age_groups.rds",
           .out = "out/all_data.rds")

all_data <- read_csv(.abs,
                     skip = 1,
                     col_names = c("measure", "sex", "age",
                                   "indig", "state", "time",
                                   "value"),
                     col_types = "-ccccc-id---") %>%
  filter(measure %in% c("1: Population", "12: Age-specific death rate"),
         sex %in% c("1: Males", "2: Females"),
         !(age %in% c("TOT: All ages", "A04: 0-4", "999: Not stated")),
         indig %in% c("4: Indigenous", "1: Non-Indigenous"),
         state != "50: 5 State/territory") %>%
  mutate(measure = sub("^.*: ", "", measure),
         sex = substring(sex, first = 4),
         sex = sub("s$", "", sex),
         age = sub("^.*: (.*)$", "\\1", age),
         age = sub(" years$", "", age),
         age = factor(age, levels = age_groups$age),
         indig = substring(indig, first = 4),
         state = substring(state, first = 4)) %>%
  mutate(indig = factor(indig,
                        levels = c("Indigenous", "Non-Indigenous"),
                        labels = c("First Nations", "Non-Indigenous"))) %>%
  left_join(age_groups, by = "age")

saveRDS(all_data, file = .out)


                  
