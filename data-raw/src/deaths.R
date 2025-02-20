
library(command)
library(dplyr, warn.conflicts = FALSE)

set.seed(0)

cmd_assign(rate = "out/rate.rds",
           popn = "out/popn.rds",
           .out = "out/deaths.rds")

deaths <- inner_join(rate, popn,
                     by = c("age", "sex", "indig", "state", "remote",  "time")) |>
    mutate(lambda = rate * popn) |>
    mutate(deaths = rpois(n = n(), lambda = lambda)) |>
    select(age, sex, indig, state, remote, time, deaths)

saveRDS(deaths, file = .out)


                  
