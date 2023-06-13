
library(command)
library(tibble)

cmd_assign(.out = "out/age_groups.rds")

age_groups <- tribble(
    ~age,    ~midpoint, ~width,
    "0",     0.5,       1,
    "1-4",   3,         4,
    "5-14",  10,        10,
    "15-24", 20,        10,
    "25-34", 30,        10,
    "35-44", 40,        10,
    "45-54", 50,        10,
    "55-64", 60,        10,
    "65-74", 70,        10,
    "75+",   80,        20
)

saveRDS(age_groups, file = .out)
