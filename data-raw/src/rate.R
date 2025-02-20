
library(command)
library(dplyr, warn.conflicts = FALSE)
library(tidyr)
library(purrr)

cmd_assign(all_data = "out/all_data.rds",
           .out = "out/rate.rds",
           mult_mc = 0.9,
           mult_r = 1.1,
           mult_vr = 1.2)

rate <- all_data |>
  filter(measure == "Age-specific death rate") |>
  select(-c(measure, age)) |>
  arrange(midpoint) |>
  mutate(value = pmax(value, min(value[value > 0])),
         value = log(value/100000)) |>
  nest(data = c(midpoint, width, value)) |>
  mutate(sp = map(data, function(df)
    splinefun(x = df$midpoint,
              y = df$value,
              method = "natural"))) |>
  mutate(interp = map(sp, function(fun) tibble(age = 0:100, value = fun(0:100)))) |>
  select(sex, indig, state, time, interp) |>
  unnest(interp) |>
  mutate(IR = exp(value),
         OR = exp(value),
         value = NULL) |>
  mutate(MC = mult_mc * IR,
         R = mult_r * IR,
         VR = mult_vr * IR) |>
  pivot_longer(c(MC, IR, OR, R, VR),
               names_to = "remote",
               values_to = "rate")
    
saveRDS(rate, file = .out)


                  
