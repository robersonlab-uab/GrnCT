library(readxl)
evergladess <- read_excel("C:/Users/snkas/Downloads/everglades_s.xlsx")
datas = evergladess

datas$Treatment <- as.factor(datas$Treatment)
datas$Treatment <- relevel(datas$Treatment, ref = "WTGFP")
library(MASS)
modWT <- glmmPQL(S_Val ~ Treatment, random = ~1|Mouse, family = Gamma(link = "log"), data = datas)
datas$Treatment <- relevel(datas$Treatment, ref = "KOGFP")
modGFP <- glmmPQL(S_Val ~ Treatment, random = ~1|Mouse, family = Gamma(link = "log"), data = datas)
datas$Treatment <- relevel(datas$Treatment, ref = "KONTD")
modNTD <- glmmPQL(S_Val ~ Treatment, random = ~1|Mouse, family = Gamma(link = "log"), data = datas)
