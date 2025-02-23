
library(tibble)
library(dplyr, warn.conflicts = FALSE)
library(command)

cmd_assign(.out = "out/propn_remote.rds")

propn_remote <- tribble(~state,  ~MC,  ~IR,  ~OR,  ~R,   ~VR,
                        "NSW",   0.6,  0.2,  0.2,  0,    0,
                        "Vic",   0.6,  0.2,  0.2,  0,    0,
                        "QLD",   0.4,  0.3,  0.2,  0.04, 0.01,
                        "SA",    0.35, 0.35, 0.2,  0.05, 0.05,
                        "Tas",   0,    0.6,  0.4,  0,    0,
                        "WA",    0.4,  0.1,  0.1,  0.3,  0.1,
                        "NT",    0,    0.2,  0.2,  0.2,  0.3,
                        "ACT",   0,    0.95, 0.05, 0,    0)

saveRDS(propn_remote, file = .out)


  
