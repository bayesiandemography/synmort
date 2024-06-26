
library(command)
library(dplyr, warn.conflicts = FALSE)
library(poputils)
library(tidyr)

cmd_assign(deaths = "out/deaths.rds",
           popn = "out/popn.rds",
           propn_remote = "out/propn_remote.rds",
           time_min = 2016,
           .out = "out/synmort.rda")

keep <- propn_remote %>%
  pivot_longer(-state, names_to = "remote", values_to = "keep") %>%
  mutate(keep = keep > 0)

synmort <- inner_join(deaths, popn,
                      by = c("age", "sex", "indig", "state", "remote", "time")) %>%
  arrange(state, remote, indig, time, sex, age) %>%
  mutate(age = ifelse(age == 100, "100+", age),
         age = set_age_open(age, lower = 85),
         age = combine_age(age, to = "lt"),
         age = reformat_age(age)) %>%
  group_by(age, sex, indig, state, remote, time) %>%
  summarise(deaths = sum(deaths), popn = sum(popn),
            .groups = "drop") %>%
  inner_join(keep, by = c("state", "remote")) %>%
  mutate(state = factor(state,
                        levels = c("New South Wales",
                                   "Queensland",
                                   "South Australia",
                                   "Western Australia",
                                   "Northern Territory"),
                        labels = c("NSW", "QLD", "SA", "WA", "NT"))) %>%
  mutate(remote = factor(remote, levels = c("MC", "IPOR", "RVR"))) %>%
  filter(keep) %>%
  select(-keep) %>%
  filter(time >= time_min)

save(synmort, file = .out)


                  
