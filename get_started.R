remove.packages("vaccineff")
pak::pak("epiverse-trace/vaccineff@make-vaccineff-data")

library(vaccineff)

# Load example data
data("cohortdata")

# Create `vaccineff_data`
vaccineff_data <- make_vaccineff_data(data_set = cohortdata,
                                      outcome_date_col = "death_date",
                                      censoring_date_col = "death_other_causes",
                                      vacc_date_col = "vaccine_date_2",
                                      vaccinated_status = "v",
                                      unvaccinated_status = "u",
                                      immunization_delay = 15,
                                      start_cohort = as.Date("2044-01-01"),
                                      end_cohort = as.Date("2044-12-31"),
                                      match = TRUE,
                                      exact = c("age", "sex"),
                                      nearest = NULL
)

# Print summary of the object
summary(vaccineff_data)

# Plot cohort coverage
plot_coverage(vaccineff_data = vaccineff_data,
              unit = "day",
              cumulative = FALSE)

# Estimate the Vaccine Effectiveness (VE) at the end of the study
ve <- effectiveness(vaccineff_data)
# Print summary of VE
summary(ve)
# Loglog plot to check proportional hazards
plot(ve, type = "loglog")
# Survival plot
plot(ve, type = "surv", percentage = FALSE, cumulative = FALSE)

# Estimate the Vaccine Effectiveness at 90 days
ve90 <- effectiveness(vaccineff_data, at = 90)
# Print summary of VE
summary(ve90)
# Loglog plot to check proportional hazards
plot(ve90, type = "loglog")
# Survival plot
plot(ve90, type = "surv", percentage = FALSE, cumulative = FALSE)

