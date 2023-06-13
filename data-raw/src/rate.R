
library(command)
library(dplyr)
library(tidyr)
library(purrr)

cmd_assign(all_data = "out/all_data.rds",
           .out = "out/rate.rds")

rate <- all_data %>%
    filter(measure == "Age-specific death rate") %>%
    select(-c(measure, age)) %>%
    arrange(midpoint) %>%
    mutate(value = pmax(value, min(value[value > 0])),
           value = log(value/100000)) %>%
    nest(data = c(midpoint, width, value)) %>%
    mutate(sp = map(data, function(df)
        splinefun(x = df$midpoint,
                  y = df$value,
                  method = "natural"))) %>%
    mutate(interp = map(sp, function(fun) tibble(age = 0:100, value = fun(0:100)))) %>%
    select(sex, indig, region, time, interp) %>%
    unnest(interp) %>%
    mutate(rate = exp(value),
           value = NULL)
    
saveRDS(rate, file = .out)


                  
