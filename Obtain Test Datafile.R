library(robumeta)
library(tidyverse)
library(metafor)
library(meta)
library(rio)
library(here)
library(readxl)


## Code to trim depression prevention overview anxiety data 


## Import data and trim the dataset from https://osf.io/c7nyz/

anxiety_symptoms <- read_excel("data/Depression_Overview_Meta_Analysis_Data.xlsx", 
                               sheet = "Anxiety")

## Trim data to obtain sample with sufficient heterogeneity for tutorial

anxiety_symptoms <- anxiety_symptoms %>%
  distinct(study, .keep_all = TRUE)

anxiety_symptoms <- anxiety_symptoms %>%
  filter(yi <=0)

## create  "comparator_f" noderator, which is a three level factor 

anxiety_symptoms <- anxiety_symptoms %>%
  mutate(comparator_f = case_when(comparison == "Standard Curriculum" ~ "Tx as usual",
                                  comparison == "Educational Brochure Control" ~ "Active",
                                  comparison == "lifeSTYLE" ~ "Active",
                                  comparison == "Waitlist Control" ~ "Control",
                                  comparison ==  "Control Group" ~ "Control",
                                  comparison == "No Treatment" ~ "Tx as usual", # control
                                  comparison == "Attention Control" ~ "Tx as usual", 
                                  comparison == "Business as Usual" ~ "Tx as usual"),
         comparator_f = fct_relevel(comparator_f, c("Tx as usual", "Control", "Active")))


### You should have 16 observations/studies remaining and 32 variables



