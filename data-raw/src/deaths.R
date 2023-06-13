
library(command)
library(dplyr)

set.seed(0)

cmd_assign(rate = "out/rate.rds",
           popn = "out/popn.rds",
           .out = "out/deaths.rds")

deaths <- inner_join(rate, popn,
                     by = c("age", "sex", "indig", "region", "time")) %>%
    mutate(lambda = rate * popn) %>%
    mutate(deaths = rpois(n = n(), lambda = lambda)) %>%
    select(age, sex, indig, region, time, deaths)

saveRDS(deaths, file = .out)


                  
