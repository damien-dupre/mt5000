organisation_alpha <- readxl::read_xlsx(here("data/organisation_alpha.xlsx"))

ggplot(organisation_alpha, aes(salary_2019, fill = gender)) +
  geom_histogram(bins = 10) +
  theme_bw() +
  labs(x = "Salary", y = "Count by Bin Range") +
  coord_flip()

ggplot(organisation_alpha, aes(salary_2019, fill = gender)) +
  geom_histogram(bins = 10) +
  theme_bw() +
  facet_wrap(gender ~ .) +
  labs(x = "Salary", y = "Count by Bin Range") +
  coord_flip()

ggplot(organisation_alpha, aes(salary_2019, fill = gender, color = gender)) +
  geom_density() +
  theme_bw() + 
  facet_wrap(gender ~ .) +
  labs(x = "Salary", y = "Proportion by Bin Range") +
  coord_flip()

ggplot(organisation_alpha, aes(salary_2019, fill = gender, color = gender)) +
  geom_density() +
  theme_bw() +
  labs(x = "Salary", y = "Proportion by Bin Range") +
  coord_flip()

ggplot(organisation_alpha, aes(salary_2019, color = gender)) +
  geom_boxplot() +
  theme_bw() +
  labs(x = "Salary", y = NULL) +
  theme(
    axis.title.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  coord_flip()

ggplot(organisation_alpha, aes(x = gender, y = salary_2019, fill = gender)) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar") + 
  stat_summary(fun = "mean", geom = "bar") +
  theme_bw() +
  labs(x = NULL, y = "Salary")
