
library(tibble)
library(dplyr, warn.conflicts = FALSE)
library(command)

cmd_assign(.out = "out/propn_remote.rds")

propn_remote <- tribble(~state,               ~MC, ~IPOR, ~RVR,
                        "New South Wales",    0.6, 0.4,   0,
                        "Northern Territory", 0,   0.5,   0.5,
                        "Queensland",         0.4, 0.5,   0.1,
                        "South Australia",    0.35,0.55,  0.1,
                        "Western Australia",  0.4, 0.2,   0.4)


saveRDS(propn_remote, file = .out)


  
