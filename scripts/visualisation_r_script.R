################################################################################
#                               Visualisation                                  #
################################################################################
# libraries --------------------------------------------------------------------
library(tidyverse)
# data -------------------------------------------------------------------------
products <- "C:/Users/dupred/OneDrive/Damien/universities/DCU/2019-2020/module/AC579_AC584/data/northwind_database/products.csv" %>% 
  readr::read_csv()

################################################################################
#                                COMPOSITION                                  #
################################################################################

# bar chart --------------------------------------------------------------------
products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>% 
  ggplot(aes(x = discontinued)) +
  geom_bar(color="white") +
  theme_classic()

products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>% 
  ggplot(aes(x = categoryID)) +
  geom_bar(color="white") +
  theme_classic()

# pie chart --------------------------------------------------------------------
products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>% 
  dplyr::group_by(discontinued) %>% 
  dplyr::summarise(n = n()) %>%
  dplyr::mutate(freq = round(n / sum(n),2)) %>% 
  dplyr::arrange(desc(discontinued)) %>% 
  dplyr::mutate(lab.ypos = cumsum(freq) - 0.5*freq) %>% 
  ggplot(aes(x = "", y = freq, fill = discontinued)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  coord_polar("y", start = 0) +
  geom_text(aes(y = lab.ypos, label = freq), color = "white") +
  theme_void()

# bar chart --------------------------------------------------------------------
products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>% 
  dplyr::group_by(categoryID) %>% 
  dplyr::summarise(n = n()) %>%
  dplyr::mutate(Proportion = round(n / sum(n),2)) %>% 
  ggplot(aes(y = Proportion, x = categoryID, fill = categoryID)) +
  geom_col(color="white") +
  theme_classic() +
  theme(legend.position = "none")


################################################################################
#                                DISTRIBUTION                                  #
################################################################################

# histogram chart --------------------------------------------------------------
products %>% 
  ggplot(aes(x = unitPrice)) +
  geom_histogram(color="white") +
  theme_classic()

# density chart ----------------------------------------------------------------
products %>% 
  ggplot(aes(x = unitPrice)) +
  geom_density() +
  theme_classic()

# box plot chart ---------------------------------------------------------------
products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>% 
  ggplot(aes(x=factor(""), y = unitPrice)) +
  geom_boxplot() +
  theme_classic() +
  xlab("") +
  coord_flip()

products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>% 
  dplyr::summarise(
    mean_data = mean(unitPrice),
    sd_data = sd(unitPrice)
  ) %>% 
  ggplot(aes(x=factor(""), y = mean_data)) +
  geom_col(color="black") +
  geom_errorbar(aes(ymin=mean_data, ymax=mean_data+sd_data), width=.1) +
  theme_classic() +
  xlab("") +
  scale_y_continuous("unitPrice", limits = c(0,max(products$unitPrice))) +
  coord_flip()

################################################################################
#                                COMPARISION                                   #
################################################################################

products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>% 
  ggplot(aes(x = categoryID, fill = discontinued)) +
  geom_bar(color="white") +
  theme_classic()

products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>%
  ggplot(aes(x = categoryID, fill = discontinued)) +
  geom_bar(color="white", position = position_dodge2(preserve = "single")) +
  theme_classic()

products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>% 
  plyr::mutate(discontinued = as.factor(discontinued)) %>% 
  dplyr::group_by(categoryID, discontinued) %>% 
  dplyr::summarise(n = n()) %>%
  dplyr::mutate(Proportion = round(n / sum(n),2)) %>% 
  ggplot(aes(y = Proportion, x = categoryID, fill = discontinued)) +
  geom_col(color="white") +
  theme_classic() +
  theme(legend.position = "none")

# box plot chart ---------------------------------------------------------------


products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>% 
  ggplot(aes(x = unitPrice, fill = discontinued)) +
  geom_histogram(color="white") +
  theme_classic()

products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>% 
  ggplot(aes(x = unitPrice, fill = discontinued)) +
  geom_histogram(color="white") +
  theme_classic() +
  facet_wrap(~discontinued) +
  theme(legend.position = "none")


products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>% 
  ggplot(aes(x = unitPrice, fill = categoryID)) +
  geom_histogram(color="white") +
  theme_classic()

products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>% 
  ggplot(aes(x = unitPrice, fill = categoryID)) +
  geom_histogram(color="white") +
  theme_classic() +
  facet_wrap(~categoryID) +
  theme(legend.position = "none")

products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>% 
  ggplot(aes(x = unitPrice,  fill = discontinued)) +
  geom_density() +
  theme_classic()

products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>% 
  ggplot(aes(x = unitPrice,  fill = categoryID)) +
  geom_density() +
  theme_classic()

library(ggridges)

products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>% 
  ggplot(aes(x = unitPrice, y = discontinued,  fill = discontinued)) +
  geom_density_ridges() +
  theme_classic()

products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>% 
  ggplot(aes(x = unitPrice, y = categoryID,  fill = categoryID)) +
  geom_density_ridges() +
  theme_classic()

# ------------------------------------------------------------------------------

products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>% 
  ggplot(aes(x = discontinued, y = unitPrice, fill = discontinued)) +
  geom_boxplot() +
  theme_classic()

products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>% 
  ggplot(aes(x = categoryID, y = unitPrice, fill = categoryID)) +
  geom_boxplot() +
  theme_classic()

products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>% 
  ggplot(aes(x = discontinued, y = unitPrice, fill = discontinued)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) +
  theme_classic()

products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>% 
  ggplot(aes(x = categoryID, y = unitPrice, fill = categoryID)) +
  geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) +
  theme_classic()

# ------------------------------------------------------------------------------

products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>%
  dplyr::group_by(discontinued) %>% 
  dplyr::summarise(
    mean_data = mean(unitPrice),
    sd_data = sd(unitPrice)
  ) %>% 
  ggplot(aes(x=discontinued, y = mean_data, fill = discontinued)) +
  geom_col(color="black") +
  geom_errorbar(aes(ymin=mean_data, ymax=mean_data+sd_data), width=.1) +
  theme_classic() +
  xlab("") +
  scale_y_continuous("unitPrice", limits = c(0,max(products$unitPrice))) +
  coord_flip()

products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>%
  dplyr::group_by(categoryID) %>% 
  dplyr::summarise(
    mean_data = mean(unitPrice),
    sd_data = sd(unitPrice)
  ) %>% 
  ggplot(aes(x=categoryID, y = mean_data, fill = categoryID)) +
  geom_col(color="black") +
  geom_errorbar(aes(ymin=mean_data, ymax=mean_data+sd_data), width=.1) +
  theme_classic() +
  xlab("") +
  scale_y_continuous("unitPrice", limits = c(0,max(products$unitPrice))) +
  coord_flip()

products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>%
  dplyr::group_by(categoryID) %>% 
  dplyr::summarise(
    mean_data = mean(unitPrice),
    sd_data = sd(unitPrice)
  ) %>% 
  ggplot(aes(x=fct_reorder(categoryID, mean_data), y = mean_data, fill = categoryID)) +
  geom_col(color="black") +
  geom_errorbar(aes(ymin=mean_data, ymax=mean_data+sd_data), width=.1) +
  theme_classic() +
  xlab("") +
  scale_y_continuous("unitPrice", limits = c(0,max(products$unitPrice))) +
  coord_flip()

################################################################################
#                                RELATIONSHIP                                  #
################################################################################

products %>% 
  ggplot(aes(x = unitsInStock, y = unitPrice)) +
  geom_point() +
  theme_classic()

products %>% 
  ggplot(aes(x = unitsInStock, y = unitPrice)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

products %>% 
  dplyr::mutate(discontinued = as.factor(discontinued)) %>%
  ggplot(aes(x = unitsInStock, y = unitPrice, fill = discontinued, color = discontinued)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic()

products %>% 
  dplyr::mutate(categoryID = as.factor(categoryID)) %>%
  ggplot(aes(x = unitsInStock, y = unitPrice, fill = categoryID, color = categoryID)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_classic() +
  facet_grid(~ categoryID)


