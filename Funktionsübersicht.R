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
mean(x, na.rm = TRUE)            # na.rm = TRUE: NAs vor der Berechnung entfernen; ohne -> Ergebnis NA (gilt auch für sd, var, min, max, range)
anyNA(x)                         # TRUE, wenn irgendwo ein NA vorkommt; x = Vektor oder Data Frame
round(x, digits)                 # Runden; digits = Anzahl Nachkommastellen, z. B. round(mean(x), 2)

# Daten einlesen (Datei muss im Projektordner liegen!)
read.csv("datei.csv")            # CSV-Datei einlesen, z. B. df = read.csv("bipolar.csv"); Komma als Trennzeichen
readRDS("datei.rds")             # R-eigenes Format (.rds)
haven::read_sav("datei.sav")     # SPSS-Datei; Paket haven
# Excel-Dateien: Paket readxl

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


# Einheit 4 ---------------------------------------------------------------

# Daten einlesen & speichern
read_csv("datei.csv")            # tidyverse-Variante von read.csv(): schneller, Ergebnis ist ein "tibble"
saveRDS(objekt, file = "datei.rds") # Objekt im R-Format speichern (inkl. Faktoren); Endung .rds mit angeben
# Wieder einlesen: df = readRDS("datei.rds")

# Items umpolen & Skalenwerte bilden
recode(x, "1" = 4, "2" = 3, ...) # tidyverse: Werte umkodieren; alter Wert (in "") = neuer Wert
# Beispiel: 4-stufige Skala (1-4) umpolen: 1 -> 4, 2 -> 3, 3 -> 2, 4 -> 1
# Formel für die Rechen-Variante: neuer Wert = (Min + Max) - alter Wert

# Möglichkeiten zum Umpolen im Vergleich:
#
# A) Spalte überschreiben
#    df$ISEL_1 = recode(df$ISEL_1, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
#    + Alle Items heißen weiter ISEL_..., daher geht danach einfach:
#      rowMeans(select(df, starts_with("ISEL")))
#    - Originalwerte sind weg
#    - Zweimal ausgeführt = Item wieder in Originalrichtung (ohne Fehlermeldung!)
#    -> Absichern: direkt vor dem Umpolen immer frisch starten, z. B. df = rohdaten
#       (oder Datensatz neu einlesen); dann kann der Block beliebig oft laufen
#
# B) Neue Spalte anlegen
#    df$ISEL_1r = recode(df$ISEL_1, "1" = 4, "2" = 3, "3" = 2, "4" = 1)
#    + Original bleibt erhalten, direkter Vergleich möglich: df[, c("ISEL_1", "ISEL_1r")]
#    + Mehrfaches Ausführen ist unproblematisch
#    - starts_with("ISEL") erfasst jetzt Original UND umgepolte Version
#      -> Items für den Skalenwert manuell auswählen, z. B.
#         rowMeans(df[, c("ISEL_1r", "ISEL_2r", "ISEL_3", "ISEL_4", ...)])
#    - Mehr Spalten im Datensatz
#
# C) Rechnen statt umkodieren (Überschreiben oder neue Spalte)
#    df$ISEL_1 = 5 - df$ISEL_1      # 5 = Min (1) + Max (4)
#    + Kurz, kein Paket nötig
#    - Nur für numerische Skalen mit lückenlosen Stufen (1, 2, 3, 4)
#    - Beim Überschreiben gleiche Gefahr wie bei A -> auch hier vorher df = rohdaten

rowMeans(df[, c("v1", "v2")])    # Zeilenmittelwerte = Mittelwert pro Person, z. B. rowMeans(select(df, starts_with("ISEL")))

# Korrelation
cor(x, y)                        # Korrelationskoeffizient (Standard: Pearson); x, y = numerische Vektoren
cor.test(x, y, method, alternative) # Korrelation mit Signifikanztest:
#   method      = "pearson" (Standard, Produkt-Moment), "spearman" (Rangkorrelation) oder "kendall" (Kendalls Tau)
#                 gilt auch für cor(), z. B. cor(x, y, method = "spearman")
#   alternative = "two.sided" (Standard), "less" (negativer Zus.) oder "greater" (positiver Zus.)

# Grafiken speichern (Base R)
jpeg(file = "name.jpg", width, height, units, res) # Grafikdatei öffnen, z. B. width = 15, height = 10, units = "cm", res = 300
dev.off()                        # Grafikdatei schließen und speichern; erst dann ist das Bild fertig
# Ablauf: jpeg(...) -> Grafikcode ausführen -> dev.off()
# Alternative für ggplot: ggsave("name.jpg", width = 15, height = 10, units = "cm", dpi = 300) speichert den zuletzt erstellten Plot

# ggplot2 – Grundprinzip: Daten + Ästhetik (aes) + Ebenen (geom_...), verbunden mit +
ggplot(data = df, aes(x = v1, y = v2)) # Grundgerüst: welcher Datensatz, welche Variable auf welche Achse
#   in aes() außerdem: fill = Füllfarbe nach Variable, color = Linien-/Punktfarbe nach Variable

# Ebenen (geoms)
geom_boxplot(width, alpha)       # Boxplot; width = Breite der Box, alpha = Transparenz (0 = durchsichtig, 1 = deckend)
geom_jitter(width, alpha)        # Einzelne Datenpunkte, leicht seitlich gestreut, damit sie sich nicht überdecken
geom_point()                     # Streudiagramm (Punkte)
geom_smooth(method = "lm")       # Regressionsgerade (lm = lineares Modell) mit Konfidenzband
stat_summary(fun = "mean", geom = "crossbar") # Kennwert (hier Mittelwert) pro Gruppe berechnen und einzeichnen

# stat_summary() im Detail ------------------------------------------------
# Grundidee: stat_summary(WAS berechnen, WIE darstellen, AUSSEHEN)
#
# WAS berechnen
#   fun = "mean"           Ein Wert pro Gruppe: "mean", "median", "min", "max"
#   fun.min = "min",       Untere/obere Grenze dazu (für Balken/Linien von ... bis),
#   fun.max = "max"          z. B. fun = "median", fun.min = "min", fun.max = "max"
#   fun.data = "mean_se"   Mittelwert + Standardfehler auf einmal (y, ymin, ymax)
#   fun.data = "mean_cl_normal" Mittelwert + 95%-Konfidenzintervall  (Paket Hmisc muss installiert sein)
#   fun.data = "mean_sdl", Mittelwert ± 1 SD                         (Paket Hmisc muss installiert sein;
#     fun.args = list(mult = 1)                                        ohne fun.args: ± 2 SD)
#   ohne Angabe            Standard: fun.data = "mean_se", geom = "pointrange" (+ Hinweis in der Konsole)
#
# WIE darstellen (geom = ...)
#   "crossbar"     Querbalken; mit nur fun = eine waagerechte Linie (z. B. Mittelwert im Boxplot)
#   "point"        Punkt
#   "pointrange"   Punkt mit senkrechter Linie von ymin bis ymax (braucht fun.data oder fun.min/fun.max)
#   "errorbar"     Fehlerbalken mit Querstrichen (braucht fun.data oder fun.min/fun.max)
#   "linerange"    Nur die senkrechte Linie, ohne Punkt
#   "bar"          Säule bis zum Kennwert (Säulendiagramm der Mittelwerte)
#   "line"         Verbindet die Kennwerte der Gruppen; braucht aes(group = 1)
#   "text"         Kennwert als Zahl, z. B. aes(label = round(after_stat(y), 2)), vjust = -1 (darüber)
#
# AUSSEHEN (feste Werte, außerhalb von aes())
#   color = "black"   Farbe von Punkten und Linien (auch als Farbcode, z. B. "#61243F")
#   fill = "white"    Füllfarbe (bei "bar", "crossbar" und bei shape 21-25)
#   size = 3          Punktgröße
#   linewidth = 0.5   Linienstärke (Fehlerbalken, Crossbar, Linien)
#   width = 0.5       Breite (bei "crossbar", "errorbar", "bar"); 0.2 = schmale Fehlerbalken
#   alpha = 0.6       Transparenz (0 = durchsichtig, 1 = deckend)
#   shape = 18        Punktform: 16 = Kreis (Standard), 17 = Dreieck, 18 = Raute, 15 = Quadrat,
#                     4 = Kreuz, 8 = Stern, 21-25 = Formen mit Rand (color) UND Füllung (fill)
#   linetype = "dashed"  Linienart: "solid" (Standard), "dashed", "dotted"
#   position = position_dodge(width = 0.5)  Bei zusätzlicher Gruppierung (fill/color) nebeneinander statt übereinander
#
# Beispiele
#   stat_summary(fun = "mean", geom = "point", size = 4, shape = 18, color = "black")
#   stat_summary(fun.data = "mean_se", geom = "errorbar", width = 0.2, linewidth = 0.5)
#   stat_summary(fun = "median", fun.min = "min", fun.max = "max", geom = "pointrange", color = "red")
#   stat_summary(fun = "mean", geom = "bar", fill = "#D32D7D", alpha = 0.6, width = 0.5)
#   stat_summary(fun = "mean", geom = "line", aes(group = 1), linetype = "dashed")
#   stat_summary(fun = "mean", geom = "point", shape = 21, size = 4, color = "black", fill = "white")
#   stat_summary(fun = "mean", geom = "text", aes(label = round(after_stat(y), 2)), vjust = -1)
# Mehrere stat_summary() lassen sich kombinieren, z. B. Punkt + Fehlerbalken:
#   ... + stat_summary(fun.data = "mean_se", geom = "errorbar", width = 0.2) +
#         stat_summary(fun = "mean", geom = "point", size = 3)

# Beschriftung & Aussehen
labs(x = "...", y = "...", title = "...") # Achsenbeschriftungen und Titel
theme_minimal()                  # Schlichtes Layout; weitere z. B. theme_classic(), theme_bw()
scale_fill_manual(values = c("#61243F", "#D32D7D")) # Eigene Füllfarben (eine pro Gruppe), als Farbcode; für color: scale_color_manual()
theme(legend.position = "right") # Feineinstellungen: Position der Legende ("right", "left", "top", "bottom", "none")
theme(plot.title = element_text(hjust = 0.5)) # Titel zentrieren (hjust: 0 = links, 0.5 = Mitte, 1 = rechts)


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
# +                   In ggplot: Ebenen verbinden (am Zeilenende, nicht am Zeilenanfang!)