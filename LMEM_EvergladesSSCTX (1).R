library(readxl)
everglades <- read_excel("C:/Users/skashyap/Desktop/everglades_lipo.xlsx")
data = everglades
data$A_Val[data$A_Val == 0] <- 0.0001
data$Treatment <- as.factor(data$Treatment)
data$Treatment <- relevel(data$Treatment, ref = "WTGFP")
library(lme4)
model <- glmer(A_Val~Treatment + (1|Mouse), data = data, family = Gamma(link = "log"), control=glmerControl(optimizer="bobyqa", boundary.tol = 1e-3))
library(MASS)
modWT <- glmmPQL(A_Val ~ Treatment, random = ~1|Mouse, family = Gamma(link = "log"), data = data)
data$Treatment <- relevel(data$Treatment, ref = "KO NTD")
modNTD <- glmmPQL(A_Val ~ Treatment, random = ~1|Mouse, family = Gamma(link = "log"), data = data)
