
# Einheit 1 ---------------------------------------------------------------

2 + 2 #Addition 

# Hier kommt eine Subtraktion

3-2
5 * 8
3 ^ 2
sqrt(10) + 11

?sqrt

# Objekte

a = 2
a

b = 4 * 5 

a + b 

c = a + b
c

d <- 10

# Zahltypen 

zahl = 4.5

Psychologe = "Wundt"

class(Psychologe)
class(zahl)

vector = c(2, 3, 4, 5, 1, 8)
vector


lieblingspsychologinnen = c("Mary", "Feldmann-Barett", "Anna Freud")

# Datensimulation

k = 1:100
sequenz = seq(from = 5, to = 500, by = 10)
identisch = seq(5, 500, 10)

kombination = c(1:10, seq(10, 100, 5))
y = c(k, sequenz)


# Normalverteilung 

n = 10000
MW = 100
SD = 15
IQ = rnorm(n, MW, SD)
hist(IQ)

# Erstellt einen numerischen Vektor "CFH", der die zahlen 12 bis 54 und jede dritte Zahl von 100 bis 120 enthält

CFH = c(12:54, seq(100, 120, 3))
CFH

Teil1 = 12:54
Teil2 = seq(100,120,3)

CFH2 = c(Teil1, Teil2)


# Elemente aus Vektoren auswählen ("Indizierung")


Vierte_Stelle = CFH[4]
Bereich = CFH[3:10]
CFH[c(4,8)]
CFH[seq(2,8,2)]
CFH[-1]

lieblingspsychologinnen[-1]
lieblingspsychologinnen[2]
lieblingspsychologinnen[c(1,3)]

mean(CFH) # Mittelwert
sd(CFH) #Standardabweichung
var(CFH) # Varianz

mean(lieblingspsychologinnen)

Ordinal = c(1:10, 10, 10, 8) #Plätze bei einem Wettkampf
as.factor(Ordinal)

lieblingspsychologinnen = c("Mary", "Mary", "Mary", "Feldmann-Barett", "Anna Freud", "Anna Freud")
lieblingspsychologinnen = as.factor(lieblingspsychologinnen)

table(lieblingspsychologinnen)


# Einheit 2 ---------------------------------------------------------------

Studiengang = c("Psychologie", "Mathematik", "Biologie", "Psychologie", "Mathematik")
levels(Studiengang)

Studiengang = factor(Studiengang, levels = c("Psychologie", "Biologie", "Mathematik"))
Studiengang

Geschlecht = c(1,2,1,2,2,2,3,1,1)
mean(Geschlecht)

Geschlecht = factor(Geschlecht, levels= c(1, 2, 3), labels = c("weiblich", "maennlich", "divers"))
Geschlecht
mean(Geschlecht)
table(Geschlecht)

Schulabschluss = c("Abitur", "Realschule", "Hauptschule", "Abitur", "Realschule", "Realschule", "Abitur")
Schulabschluss = factor(Schulabschluss, levels = c("Hauptschule", "Realschule", "Abitur"), ordered = TRUE)
Schulabschluss

Schulabschluss > "Hauptschule"
Schulabschluss[Schulabschluss >= "Realschule"]

set.seed(22)
df = data.frame(Studiencode = 100:105,
                Diagnose = c("Depression", "Angststörung", "Zwangsstörung", "Depression", "Zwangsstörung", "ADHS"),
                Klinik = c("LMU", "LMU", "LMU", "MPI", "MPI", "MPI"),
                BDI = rnorm(6, mean = 25, sd = 7),
                Alter = c(22, 24, 55, 85, 43, 45))

df
names(df)
head(df)
nrow(df)
ncol(df)
View(df)
str(df)

df$Alter
df$Diagnose = factor(df$Diagnose)
df$Klinik = factor(df$Klinik)
str(df)

df$Geschlecht = factor(c(1, 2, 3, 1, 2, 1), levels = c(1,2,3), 
                       labels = c("männlich", "weiblich", "divers"))
df

df[3,]
df[2:5,]
df[c(1,4),]
df[2:4, "Klinik"]
df$Klinik[2:4]
df[,c("Klinik", "BDI")]

#Aufgabe: Welche Diagnose hat die 3. Person? - es gibt (mindestens) zwei Optionen

df[3, "Diagnose"]
df[3, 2]
df$Diagnose[3]

df[3, "Diagnose"] = "ADHS"
df[3, "Diagnose"]

# Statt über Positionen können wir Werte nach einer BEDINGUNG auswählen.

df$Alter > 30
Alten = df[df$Alter > 30,]
Alten
Frauen = df[df$Geschlecht == "weiblich",]
Frauen
df[df$Alter > 30 & df$Geschlecht == "männlich",]
df[df$Alter > 30 | df$Geschlecht == "männlich",]

# install.packages("tidyverse")
library(tidyverse)

starwars$mass

filter(starwars, mass > 100)

Schwergewichte = starwars %>% filter(mass > 100)
Schwergewichte$name


# Einheit 3 ---------------------------------------------------------------

library(tidyverse)
mean(starwars$mass, na.rm = TRUE)

round(mean(starwars$mass, na.rm = TRUE),2)

df = read.csv("bipolar.csv")
# readRDS() R-Format

# .sav (SPSS) 
# install.packages("haven")
#library(haven)
#read_sav()

# install.packages("readxl")

head(df)
str(df)
View(df)
summary(df)
anyNA(df)

df$YMRS_1 + df$YMRS_2

rowSums(df[,c("YMRS_1", "YMRS_2", "YMRS_3")])

library(tidyverse)

?select
rowSums(select(df, starts_with("YMRS")))

df$sum_YMRS = rowSums(select(df, starts_with("YMRS")))
head(df)

round(mean(df$sum_YMRS),2)
sd(df$sum_YMRS)
var(df$sum_YMRS)
range(df$sum_YMRS)

table(df$groups)

df$sum_YMRS[df$groups == "EW"]
df$sum_YMRS[df$groups == "noEW"]

mean(df$sum_YMRS[df$groups == "EW"])
mean(df$sum_YMRS[df$groups == "noEW"])

tapply(df$sum_YMRS, df$groups, mean)
tapply(df$sum_YMRS, df$groups, sd)

df %>% group_by(groups) %>%
  summarise(n = n(),
            Mittelwert = mean(sum_YMRS),
            SD = sd(sum_YMRS),
            Min = min(sum_YMRS),
            Max = max(sum_YMRS))

#install.packages("psych")
library(psych)

psych::describe(df)

describe(df)
describeBy(df, group = df$groups)

head(df)

t.test(sum_YMRS ~ groups, data = df, var.equal = TRUE, alternative = "less")
?t.test


# Einheit 4 ---------------------------------------------------------------

library(tidyverse)
library(psych)
library(ggplot2)

bipolar = read_csv("bipolar.csv")
rohdaten = read_csv("bipolar.csv")

# names(bipolar)

bipolar$sum_YMRS = rowSums(select(bipolar, starts_with("YMRS")))

# Reverse Items: 1, 2, 7, 8, 11, 12 

# summary(select(bipolar, starts_with("ISEL")))

# bipolar$ISEL_1r = recode(bipolar$ISEL_1, "1" = 4, "2" = 3, "3" = 2, "4" = 1)

# bipolar[, c("ISEL_1r", "ISEL_1")]

bipolar$ISEL_1 = recode(bipolar$ISEL_1, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_2 = recode(bipolar$ISEL_2, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_7 = recode(bipolar$ISEL_7, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_8 = recode(bipolar$ISEL_8, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_11 = recode(bipolar$ISEL_11, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
bipolar$ISEL_12 = recode(bipolar$ISEL_12, "1" = 4, "2" = 3, "3" = 2, "4" = 1)

bipolar$mean_ISEL = rowMeans(select(bipolar, starts_with("ISEL")))


saveRDS(bipolar, file = "bipolar_clean")

t.test(sum_YMRS ~ groups, data = bipolar)

#?ggplot2


jpeg(file = "Unser_erstes_GGPLOT.jpg", width = 15, 
     height = 10, units = "cm", res = 300)

ggplot(data = bipolar, aes(x = groups, y = sum_YMRS, fill = groups)) +
  geom_boxplot(width = 0.5, alpha = 0.6, fatten = NULL) +
  geom_jitter(width = 0.15, alpha = 0.5) +
  stat_summary(fun = "mean", geom = "crossbar", width = 0.5, linewidth = 0.1, color = "black") +
  labs(x = "Gruppen", y = "YMRS", title = "Boxplot der YMRS Werte nach Gruppen") +
  theme_minimal() +
  scale_fill_manual(values = c("#61243F", "#D32D7D")) +
  theme(legend.position = "right",
        plot.title = element_text(hjust = 0.5, vjust = 1))

dev.off()

cor(bipolar$sum_YMRS, bipolar$mean_ISEL)
cor.test(bipolar$sum_YMRS, bipolar$mean_ISEL, 
         method = "pearson", alternative = "less")
?cor.test

ggplot(bipolar, aes(x = sum_YMRS, y = mean_ISEL, color = groups)) +
  geom_point() +
  geom_smooth(method = "lm")









