# =========================================================================
# Funktionsübersicht – Computergestützte Datenanalyse (WS 2026/27)
# Nachschlagewerk, wird nach jeder Einheit ergänzt.
# Nicht als Ganzes ausführen: x, df usw. sind Platzhalter.
# =========================================================================


# Einheit 1 ---------------------------------------------------------------

# Hilfe & Grundrechnen
?sqrt                            # Hilfeseite zu einer Funktion öffnen: ?Funktionsname
sqrt(x)                          # Quadratwurzel; x = Zahl oder numerischer Vektor

# Objekte & Vektoren
c(...)                           # Werte zu einem Vektor kombinieren; beliebig viele Werte/Vektoren, durch Komma getrennt
class(x)                         # Datentyp eines Objekts ("numeric", "character", "factor", ...)
seq(from, to, by)                # Zahlenfolge; from = Start, to = Ende, by = Schrittweite
# Kurzform für 1er-Schritte: von:bis, z. B. 1:100

# Simulation & Grafik
rnorm(n, mean, sd)               # n normalverteilte Zufallszahlen; n = Anzahl, mean = Mittelwert, sd = Standardabweichung
hist(x)                          # Histogramm; x = numerischer Vektor

# Deskriptive Statistik (nur numerische Vektoren; bei Text/Faktor -> NA + Warnung)
mean(x)                          # Mittelwert
sd(x)                            # Standardabweichung (Stichprobe, Nenner n-1)
var(x)                           # Varianz (Stichprobe, Nenner n-1)

# Faktoren & Häufigkeiten
as.factor(x)                     # Wandelt x in einen Faktor (kategoriale Variable) um; Stufen automatisch sortiert
table(x)                         # Häufigkeitstabelle; x = Vektor oder Faktor


# Einheit 2 ---------------------------------------------------------------

# Faktoren
factor(x, levels, labels, ordered) # Faktor mit Kontrolle über die Stufen:
#   x       = Vektor
#   levels  = Ausprägungen in gewünschter Reihenfolge, z. B. c(1, 2, 3)
#   labels  = Namen der Ausprägungen, gleiche Reihenfolge wie levels (optional)
#   ordered = TRUE für ordinale Variablen (erlaubt <, >); Standard: FALSE
levels(x)                        # Stufen eines Faktors anzeigen (bei Text-Vektoren: NULL)

# Zufall reproduzierbar machen
set.seed(zahl)                   # Startwert für Zufallszahlen: gleiche Zahl -> gleiche Ergebnisse; vor rnorm() ausführen

# Data Frames
data.frame(name1 = vektor1, name2 = vektor2) # Datensatz erstellen; jede Spalte = Vektor, alle gleich lang
names(df)                        # Spaltennamen
head(df, n = 6)                  # Erste n Zeilen (Standard: 6)
nrow(df)                         # Anzahl Zeilen (= Personen)
ncol(df)                         # Anzahl Spalten (= Variablen)
View(df)                         # Datensatz als Tabelle öffnen (großes V!)
str(df)                          # Struktur: Variablen, Datentypen, erste Werte

# Pakete
install.packages("paket")        # Paket einmalig installieren; Name MIT Anführungszeichen
library(paket)                   # Paket in jeder neuen Sitzung laden; Name OHNE Anführungszeichen

# tidyverse
filter(df, bedingung)            # Zeilen auswählen, die eine Bedingung erfüllen, z. B. filter(starwars, mass > 100)
df %>% filter(bedingung)         # Dasselbe mit Pipe: %>% gibt das Objekt links als erstes Argument an die Funktion rechts


# Einheit 3 ---------------------------------------------------------------

# Fehlende Werte (NA) & Runden
mean(x, na.rm = TRUE)            # na.rm = TRUE: NAs vor der Berechnung entfernen; ohne -> Ergebnis NA (gilt auch für sd, var, min, max, range, sum)
anyNA(x)                         # TRUE, wenn irgendwo ein NA vorkommt; x = Vektor oder Data Frame
round(x, digits)                 # Runden; digits = Anzahl Nachkommastellen, z. B. round(mean(x), 2)

# Daten einlesen (Datei muss im Projektordner liegen!)
read.csv("datei.csv")            # CSV-Datei einlesen, z. B. df = read.csv("bipolar.csv"); Komma als Trennzeichen
read.csv2("datei.csv")           # Variante für Semikolon als Trennzeichen (deutsches Excel)
readRDS("datei.rds")             # R-eigenes Format (.rds)
haven::read_sav("datei.sav")     # SPSS-Datei; Paket haven
readxl::read_excel("datei.xlsx") # Excel-Datei; Paket readxl

# Überblick über einen Datensatz
summary(df)                      # Kurzstatistik je Spalte: Min, Quartile, Median, Mittelwert, Max, Anzahl NAs
range(x)                         # Kleinster und größter Wert (Vektor mit 2 Werten)
min(x)                           # Kleinster Wert
max(x)                           # Größter Wert

# Summenwerte bilden
rowSums(df[, c("v1", "v2")])     # Zeilensummen = Summe pro Person über die gewählten Spalten
select(df, spalten)              # tidyverse: Spalten auswählen, z. B. select(df, YMRS_1, YMRS_2)
starts_with("text")              # Hilfsfunktion in select(): alle Spalten, die mit "text" beginnen
# Beispiel: df$sum_YMRS = rowSums(select(df, starts_with("YMRS")))

# Kennwerte nach Gruppen
tapply(x, gruppe, funktion)      # Funktion getrennt pro Gruppe anwenden, z. B. tapply(df$sum_YMRS, df$groups, mean)
df %>% group_by(gruppe) %>%      # tidyverse: Datensatz nach Gruppe aufteilen ...
  summarise(name = funktion(x))  # ... und pro Gruppe Kennwerte berechnen; mehrere durch Komma getrennt
n()                              # Innerhalb von summarise(): Anzahl Fälle pro Gruppe
# Beispiel:
# df %>% group_by(groups) %>%
#   summarise(n = n(), M = mean(sum_YMRS), SD = sd(sum_YMRS))

# psych-Paket
describe(df)                     # Ausführliche Deskriptivstatistik je Spalte (n, M, SD, Median, Min, Max, Schiefe, Kurtosis, ...)
describeBy(df, group = df$gruppe) # Wie describe(), aber getrennt nach Gruppen

# Inferenzstatistik
t.test(av ~ gruppe, data = df, var.equal, alternative) # t-Test für unabhängige Stichproben:
#   av ~ gruppe  = abhängige Variable ~ Gruppenvariable (genau 2 Gruppen)
#   data         = Datensatz, aus dem die Variablen stammen
#   var.equal    = TRUE: Student-t-Test (gleiche Varianzen); Standard FALSE = Welch-Test
#   alternative  = "two.sided" (Standard, ungerichtet), "less" oder "greater" (gerichtet)
#   Achtung: "less" heißt M(Gruppe 1) < M(Gruppe 2); Reihenfolge = Reihenfolge der Faktorstufen
#            (ohne factor() alphabetisch, z. B. "EW" vor "noEW")


# Operatoren & Zugriff ----------------------------------------------------

# <-  oder  =         Zuweisung, z. B. a <- 2
# +  -  *  /  ^       Grundrechenarten, ^ = Potenz
# x[i]                Elemente aus Vektor x: x[4], x[3:10], x[c(1, 3)], x[-1] (alle außer dem 1.)
# df[zeile, spalte]   Auswahl im Data Frame; leer = alle, z. B. df[3, ], df[, c("Klinik", "BDI")]
# df$spalte           Eine Spalte als Vektor, z. B. df$Alter; auch zum Anlegen neuer Spalten
# ==  !=              gleich / ungleich
# >  <  >=  <=        größer / kleiner (gleich)
# &   |               UND / ODER
# df[bedingung, ]     Zeilen nach Bedingung auswählen, z. B. df[df$Alter > 30, ]
# NA                  Fehlender Wert ("not available")
# paket::funktion()   Funktion direkt aus einem Paket aufrufen, ohne library(), z. B. psych::describe(df)
# ~                   Formel: "erklärt durch", z. B. sum_YMRS ~ groups
# TRUE / FALSE        Immer ausschreiben; T und F funktionieren, können aber überschrieben werden