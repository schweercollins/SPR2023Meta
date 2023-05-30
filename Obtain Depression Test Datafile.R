
library(robumeta)
library(tidyverse)
library(metafor)
library(meta)
library(rio)
library(here)
library(readxl)


## Code to trim depression prevention overview 


## Import data and trim the dataset from https://osf.io/c7nyz/

depression_symptoms <- read_excel("data/Depression_Overview_Meta_Analysis_Data.xlsx", 
                               sheet = "Depression")

## Trim data to obtain sample with sufficient heterogeneity for tutorial


depression_symptoms <- depression_symptoms %>%
  distinct(study, .keep_all = TRUE) %>%
  filter(yi <= .02) %>%
  mutate(                                          # computing measure moderator
    measure_f = case_when(
      str_detect(outcome_measure, "(CDI)") ~ "CDI",
      str_detect(outcome_measure,  "(CES-D)") ~ "CES-D",
      str_detect(outcome_measure, "DASS-21") ~ "other",
      str_detect(outcome_measure, "MFQ") ~ "other",
      str_detect(outcome_measure, "RADS") ~ "other",
      str_detect(outcome_measure, "SMFQ") ~ "other",
      str_detect(outcome_measure, "PHQ") ~ "other",
      str_detect(outcome_measure, "BDI") ~ "BDI"),
    measure_f = fct_relevel(measure_f, c("other", "CES-D", "CDI", "BDI")))

export(depression_symptoms, "depression_symptoms.csv") # exporting to a .csv