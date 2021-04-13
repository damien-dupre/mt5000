# Introduction

This document is an example of what can be done using Rmarkdown file to produce an academic/professional report. It focuses on the titanic dataset which is one of the most classic dataset to practice data analytic and data science. Indeed the catastrophe of the titanic is not only interesting from a data point of view but also from an human point of view. 

While the James Cameron movie did not focus too much on the influence of classes on the final outcome, it appears that passengers were not equals in age and gender. For these reasons, this report will investigate what are the influence of age and gender on passengers' ticket fare.

# Literature Review

According to Saidatunnisa, Sili and Nasrullah (2019), the inequality issues towards women existed in one of the most outstanding movies of all times, Titanic. Titanic movie began with the 84 years old woman named Rose DeWitt Bukater who told about Titanic’s tragic story on its first and last voyage April 1912. Rose DeWitt Bukater was regardless of her status as the upper class, also a woman who experienced the inequality issues. Rose as a woman had to be obedient towards the male supremacy society she lived in.

In addition, Researchers interested in inequalities in healthcare wont to quote data from the Titanic disaster” (Marmot 1999, p. 16). This ritual stems from Antonovsky (1967), who opened his classic paper with an illustration based on data from the Titanic, highlighting the higher survival rate of the first- and second-class passengers, versus the second- and third-class passengers, to demonstrate that social class influences mortality (Pearson, 2008).

- **Hypothesis 1:** The average tickets fare of female passengers is higher than the average ticket fare of male passengers.

- **Hypothesis 2:** Passengers' tickets fare increase when their age increase.

# Method

The method section usually describes the participants where the data was collected, the material and the procedure used to collect the data, and the analysis performed to test the hypotheses.

## Participants

The data were collected from 1309 passengers known for having embarked on the Titanic. The average age of passengers was 29.9 years old (SD = 14.4) but the age from 263 passengers is unknown.

```{r}
titanic %>% # Average, SD of age with the amount of values and missing values
  summarise(
    n = n(),
    missing = sum(is.na(Age)),
    m_age = mean(Age, na.rm = TRUE),
    sd_age = sd(Age, na.rm = TRUE)
  ) %>% 
  kbl(booktabs = TRUE)
```

From them, 466 where female passengers and 843 were male passengers. 

```{r}
titanic %>% # Amount of passengers according gender
  group_by(Sex) %>% 
  summarise(n = n()) %>% 
  kbl(booktabs = TRUE)
```

## Material

Little is know over how these data were collected but it lists the passengers name, age, gender, ticket class, number of siblings / spouses aboard the Titanic, number of parents / children aboard the Titanic, ticket number, passenger fare, cabin number, port of Embarkation (C = Cherbourg, Q = Queenstown, S = Southampton) and ultimately their survival (0 = No, 1 = Yes).

## Procedure

This section usually describes how the data were collected but here they were found online on the Kaggle website https://www.kaggle.com/c/titanic/data.

## Data Analyses

Next week

# Results

The average fare for female passengers is slightly higher than the average fare for male passengers (£46.2 for female passengers vs. £26.2 for male passengers) as show by the Figure 2.

It also appears that the ticket fare increases when age increases as well as shown in Figure 3.

