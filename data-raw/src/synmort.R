
library(command)
library(dplyr)

cmd_assign(deaths = "out/deaths.rds",
           popn = "out/popn.rds",
           .out = "out/synmort.rda")

synmort <- inner_join(deaths, popn,
                      by = c("age", "sex", "indig", "region", "time")) %>%
  arrange(region, indig, time, sex, age) %>%
  mutate(popn = round(popn)) %>%
  mutate(age = ifelse(age == 100, "100+", age)) %>%
as.data.frame()

save(synmort, file = .out)


                  
