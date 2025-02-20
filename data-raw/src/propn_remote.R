
library(tibble)
library(dplyr, warn.conflicts = FALSE)
library(command)

cmd_assign(.out = "out/propn_remote.rds")

propn_remote <- tribble(~state,               ~MC,  ~IR,  ~OR, ~R,   ~VR,
                        "New South Wales",    0.6,  0.2,  0.2, 0,    0,
                        "Northern Territory", 0,    0.2,  0.2, 0.2,  0.3,
                        "Queensland",         0.4,  0.3,  0.2, 0.04, 0.01,
                        "South Australia",    0.35, 0.35, 0.2, 0.05, 0.05,
                        "Western Australia",  0.4,  0.1,  0.1, 0.3,  0.1)

saveRDS(propn_remote, file = .out)


  
