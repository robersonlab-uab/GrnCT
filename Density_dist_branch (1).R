install.packages("readxl")   # If not installed yet
install.packages("ggplot2")
library(readxl)
library(ggplot2)
densedata <- read_excel("C:/Users/skashyap/Downloads/wt_test.xlsx")
ggplot(densedata, aes(x = Y, color = Group, fill = Group)) + geom_density(alpha = 0.3) + labs(title = "Branch Lengths", x = "Branch Lengths", y = "Density") + theme_minimal()
ggplot(densedata, aes(x = Y, color = Group, fill = Group)) +
  geom_density(alpha = 0.3) +
  scale_color_manual(values = c("WTGFP" = "#000000", "KOGFP" = "#4CAF50", "KOCTD" = "#E69F00", "KONTD" = "#009EF3")) +  # Line colors
  scale_fill_manual(values = c("WTGFP" = "#000000", "KOGFP" = "#4CAF50", "KOCTD" = "#E69F00", "KONTD" = "#009EF3")) +  # Fill colors
  labs(title = "Branch Lengths", x = "Branch Lengths", y = "Density") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))








