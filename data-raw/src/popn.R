
library(command)
library(dplyr)
library(tidyr)
library(purrr)

cmd_assign(all_data = "out/all_data.rds",
           .out = "out/popn.rds")

popn_totals <- all_data %>%
    filter(measure == "Population") %>%
    count(sex, indig, region, time, wt = value, name = "total")

popn_distn <- all_data %>%
    filter(measure == "Population") %>%
    arrange(midpoint) %>%
    mutate(value = value / width,
           value = log(value)) %>%
    select(-c(measure, age, width)) %>%
    nest(data = c(midpoint, value)) %>%
    mutate(sp = map(data, function(df) {
        midpoint <- c(df$midpoint, 100)
        value <- c(df$value, 0)
        splinefun(x = midpoint, y = value)
    })) %>%
    mutate(interp = map(sp, function(fun) tibble(age = 0:100, value = fun(0:100)))) %>%
    select(sex, indig, region, time, interp) %>%
    unnest(interp) %>%
    mutate(value = exp(value)) %>%
    group_by(sex, indig, region, time) %>%
    mutate(propn = value / sum(value),
           value = NULL) %>%
    ungroup()

popn <- popn_distn %>%
    inner_join(popn_totals, by = c("sex", "indig", "region", "time")) %>%
    mutate(popn = propn * total) %>%
    select(age, sex, indig, region, time, popn)

saveRDS(popn, file = .out)


                  
