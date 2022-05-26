################################################################################
#                   Data Analytics Exam Random Generator                       #
################################################################################
# libraries --------------------------------------------------------------------
library(here)
library(tidyverse)
library(janitor)
library(glue)
library(mailR)

# test emails ------------------------------------------------------------------
list_email_students <- data.frame(
  Firstname = c("Damien", "Test 1", "Test 2"),
  Email = c("damien.dupre@dcu.ie", "test_1@gmail.com", "test_1@gmail.com"),
  stringsAsFactors = FALSE
) # check in email sent box if they have been successfully sent 

# student emails ---------------------------------------------------------------
list_email_students <- file.choose() %>% 
  read_csv()

gmail_dcu <- config::get("gmail_dcu")

email_text <- "<p>Dear {name}, <br><br>Please, find here attached the data that you will use for all 3 assignments of the MT5000 module. In addition, please find attached the instructions regarding the Tableau dashboard assignment. To succeed in this assignment, follow the instructions attached and submit the dashboard by Wednesday March 24th, 2021 on Loop. Can you confirm the reception of this email containing data and instructions?<br><br>Note that all assignment are individual, every student has received a different pool of countries to prevent collaboration. Any similarities between submissions will be considered as plagiarism.<br><br>Let me know if you have any problem to download the documents attached.<br><br>Best regards,<br><br>Damien</p>"

letter2number <- function(x) {utf8ToInt(x) - utf8ToInt("a") + 1L}

################################################################################
for (row_student in 1:nrow(list_email_students)) {
  
  student_db <- list_email_students[row_student, ]
  email <- student_db[["Email"]]
  name <- student_db[["Firstname"]]
  
  random_number <- as.numeric(abs(sum(letter2number(email))))
  set.seed(random_number)
  
  # data -----------------------------------------------------------------------
  # https://ourworldindata.org/covid-vaccinations
  df <- read_csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv") %>% 
    read_csv(
      col_types = cols(
        .default = col_double(),
        iso_code = col_character(),
        continent = col_character(),
        location = col_character(),
        date = col_date(format = ""),
        tests_units = col_character()
      )
    )
  
  df %>% 
    filter(is.na(iso_code)) %>% 
    remove_empty(which = "cols")  %>% 
    write_csv(here("assignments/temp/df_global.csv"), na = "")
  
  list_random_location <- df %>% 
    drop_na(iso_code) %>% 
    filter(location != "Ireland") %>% 
    pull(location) %>% 
    unique()
  
  df_country <- df %>% 
    filter(location %in% c("Ireland", sample(list_random_location, 9)))
  
  df_country %>% 
    select(!stringency_index:human_development_index) %>% 
    write_csv(here("assignments/temp/df_country_data.csv"), na = "")
  
  df_country_metadata <- df_country %>% 
    group_by(location) %>% 
    slice_head(n = 1) %>% 
    select(stringency_index:human_development_index) %>% 
    write_csv(here("assignments/temp/df_country_metadata.csv"), na = "")
  ################################
  
  print(email)
  
  ################################
  send.mail(
    from = gmail_dcu$email,
    to = email,
    subject = "MT5000 - Data for all Assignments and Instructions for Tableau Assignment",
    body = glue(email_text),
    attach.files = c(
      here("assignments/temp/df_global.csv"),
      here("assignments/temp/df_country_data.csv"),
      here("assignments/temp/df_country_metadata.csv"),
      here("assignments/instructions_tableau_assignment.pdf")
    ),
    smtp = list(
      host.name = "smtp.gmail.com", port = 465,
      user.name = gmail_dcu$email,
      passwd = gmail_dcu$passwd,
      ssl = TRUE
      ),
    authenticate = TRUE,
    send = TRUE,
    html = TRUE
    )
}
