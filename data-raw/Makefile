
MULT_MC=0.9
MULT_RVR=1.1
TIME_MIN=2016

.PHONY: all
all: ../data/synmort.rda

out/age_groups.rds: src/age_groups.R
	Rscript $^ $@

out/propn_remote.rds: src/propn_remote.R
	Rscript $^ $@

out/all_data.rds: src/all_data.R \
  data/ABS_DEATHS_INDIGENOUS_1.0.0.csv.gz \
  out/age_groups.rds
	Rscript $^ $@

out/rate.rds: src/rate.R \
  out/all_data.rds
	Rscript $^ $@ --mult_mc=$(MULT_MC) --mult_rvr=$(MULT_RVR)

out/popn.rds: src/popn.R \
  out/all_data.rds \
  out/propn_remote.rds
	Rscript $^ $@

out/deaths.rds: src/deaths.R \
  out/rate.rds \
  out/popn.rds
	Rscript $^ $@

../data/synmort.rda: src/synmort.R \
  out/deaths.rds \
  out/popn.rds \
  out/propn_remote.rds
	Rscript $^ $@ --time_min=$(TIME_MIN)



## Clean ----------------------------------------------------------------------

.PHONY: clean
clean:
	rm -rf out
	mkdir out
