
library(command)
library(dplyr, warn.conflicts = FALSE)
library(tidyr)
library(purrr)

cmd_assign(all_data = "out/all_data.rds",
           propn_remote = "out/propn_remote.rds",
           .out = "out/popn.rds")

popn_totals <- all_data |>
  filter(measure == "Population") |>
  count(sex, indig, state, time, wt = value, name = "total")

popn_distn <- all_data |>
  filter(measure == "Population") |>
  arrange(midpoint) |>
  mutate(value = value / width,
         value = log(value)) |>
  select(-c(measure, age, width)) |>
  nest(data = c(midpoint, value)) |>
  mutate(sp = map(data, function(df) {
    midpoint <- c(df$midpoint, 100)
    value <- c(df$value, 0)
    splinefun(x = midpoint, y = value)
  })) |>
  mutate(interp = map(sp, function(fun) tibble(age = 0:100, value = fun(0:100)))) |>
  select(sex, indig, state, time, interp) |>
  unnest(interp) |>
  mutate(value = exp(value)) |>
  group_by(sex, indig, state, time) |>
  mutate(propn = value / sum(value),
         value = NULL) |>
  ungroup()

popn <- popn_distn |>
  inner_join(popn_totals, by = c("sex", "indig", "state", "time")) |>
  mutate(popn = propn * total) |>
  select(age, sex, indig, state, time, popn) |>
  inner_join(propn_remote, by = "state") |>
  mutate(MC = popn * MC,
         IR = popn * IR,
         OR = popn * OR,
         R = popn * R,
         VR = popn * VR) |>
  select(-popn) |>
  pivot_longer(c(MC, IR, OR, R, VR),
               names_to = "remote",
               values_to = "popn")

act <- popn |>
  filter(state == "NSW") |>
  mutate(state = "ACT") |>
  mutate(popn = 0.04 * popn)

tas <- popn |>
  filter(state == "NSW") |>
  mutate(state = "Tas") |>
  mutate(popn = 0.06 * popn)

vic <- popn |>
  filter(state == "NSW") |>
  mutate(state = "Vic") |>
  mutate(popn = 0.82 * popn)

popn <- bind_rows(popn, act, tas, vic)

saveRDS(popn, file = .out)


                  
