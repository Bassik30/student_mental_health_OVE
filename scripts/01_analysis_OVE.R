######################################################################
#   Projet OVE – Santé mentale et conditions de vie des étudiants
#   Auteur : Bassik Idrissou
#   Objectif : Analyses descriptives, économétriques et Machine Learning
######################################################################

# ====================================================================
# 0. Packages
# ====================================================================
library(tidyverse)
library(ggplot2)
library(dplyr)
library(broom)
library(car)
library(ResourceSelection)
library(pROC)
library(randomForest)
library(caret)
library(MASS)
library(nnet)
library(ordinal)
library(effects)
library(gtsummary)
library(factoextra)

# ====================================================================
# 1. Préparation des données
# ====================================================================
df6 <- df5

# Liste des variables et modalités
lapply(names(df6), function(var) {
  cat("----", var, "----\n")
  print(table(df6[[var]], useNA = "ifany"))
  cat("\n")
})

# Sélection des variables utiles
df7 <- df6[, c(
  "Age_grp","Sexe","Nationalite","Niveau_etud","Etude_parents","Filiere_niv1",
  "Sante_mentale","Bourse","Logement_grp","Revenu_pere_grp","Revenu_mere",
  "Renonciation_medecin_grp","Sante_generale_grp","Satisfaction_logement_grp",
  "Utilisation_services_grp","Difficulte_financiere_grp","Plusieurs_activites_grp",
  "Type_couverture_grp"
)]

# ====================================================================
# 2. Analyses descriptives
# ====================================================================
# Exemple Sexe
df7 %>%
  count(Sexe) %>%
  mutate(prop = round(100 * n / sum(n), 1))

ggplot(df7, aes(x = Sexe)) +
  geom_bar(fill = "#2E86AB") +
  labs(title = "Répartition par sexe", y = "Effectif", x = "")

# Répéter pour Age, Nationalité, Niveau d’étude, Bourse, etc.
# ...

# ====================================================================
# 3. Analyses bivariées (Chi²)
# ====================================================================
vars_H1 <- c("Sexe","Age_grp","Nationalite","Niveau_etud")
vars_H2 <- c("Bourse","Logement_grp","Revenu_pere_grp","Difficulte_financiere_grp",
             "Satisfaction_logement_grp","Renonciation_medecin_grp")

tab_H1 <- df7 %>%
  select(all_of(vars_H1), Sante_mentale) %>%
  tbl_summary(by = Sante_mentale, statistic = all_categorical() ~ "{n} ({p}%)") %>%
  add_p(test = all_categorical() ~ "chisq.test")

tab_H2_sm <- df7 %>%
  select(all_of(vars_H2), Sante_mentale) %>%
  tbl_summary(by = Sante_mentale, 
              statistic = all_categorical() ~ "{n} ({p}%)",
              missing = "no") %>%
  add_p(test = all_categorical() ~ "chisq.test") %>%
  bold_labels()

tab_H2_sg <- df7 %>%
  select(all_of(vars_H2), Sante_generale_grp) %>%
  tbl_summary(by = Sante_generale_grp, 
              statistic = all_categorical() ~ "{n} ({p}%)",
              missing = "no") %>%
  add_p(test = all_categorical() ~ "chisq.test") %>%
  bold_labels()

# ====================================================================
# 4. Modèles économétriques
# ====================================================================

## 4.1 Logit binaire (santé mentale)
modele_sm <- glm(Sante_mentale ~ Sexe + Age_grp + Niveau_etud +
                   Difficulte_financiere_grp + Satisfaction_logement_grp +
                   Renonciation_medecin_grp + Revenu_pere_grp,
                 data = df7, family = binomial(link = "logit"))
summary(modele_sm)

## 4.2 Logit ordinal (santé générale)
modele_ordinal <- polr(Sante_generale_grp ~ Sexe + Age_grp + Niveau_etud +
                         Bourse + Logement_grp +
                         Difficulte_financiere_grp + Satisfaction_logement_grp +
                         Renonciation_medecin_grp,
                       data = df7, Hess = TRUE)

## 4.3 Robustesse : probit + multinomial
modele_probit <- glm(Sante_mentale ~ Sexe + Age_grp + Niveau_etud +
                       Difficulte_financiere_grp + Satisfaction_logement_grp +
                       Renonciation_medecin_grp + Revenu_pere_grp,
                     data = df7, family = binomial(link = "probit"))

modele_multinom <- multinom(Sante_generale_grp ~ Sexe + Age_grp + Niveau_etud +
                              Bourse + Logement_grp +
                              Difficulte_financiere_grp + Satisfaction_logement_grp +
                              Renonciation_medecin_grp,
                            data = df7)

# ====================================================================
# 5. Machine Learning (Random Forest)
# ====================================================================
df7$Sante_mentale_num <- ifelse(df7$Sante_mentale == "Oui", 1, 0) %>% factor(levels = c(0,1))
set.seed(123)
train_index <- createDataPartition(df7$Sante_mentale_num, p = 0.8, list = FALSE)
train_data <- df7[train_index, ]
test_data  <- df7[-train_index, ]

# Rééquilibrage des classes
train_balanced <- downSample(
  x = train_data[, -which(names(train_data) == "Sante_mentale_num")],
  y = train_data$Sante_mentale_num, yname = "Sante_mentale_num"
)

# Modèle Random Forest
rf_model <- randomForest(Sante_mentale_num ~ Sexe + Age_grp + Niveau_etud +
                           Difficulte_financiere_grp + Satisfaction_logement_grp +
                           Renonciation_medecin_grp + Revenu_pere_grp,
                         data = train_balanced, ntree = 500, importance = TRUE)

# Courbe ROC
pred_proba_rf <- predict(rf_model, newdata = test_data, type = "prob")[, "1"]
roc_rf <- roc(test_data$Sante_mentale_num, pred_proba_rf)
plot(roc_rf, col = "blue", main = paste("Courbe ROC RF (AUC =", round(auc(roc_rf), 3), ")"))

# ====================================================================
# 6. Clustering K-means
# ====================================================================
df_clust <- df7 %>%
  select(Sexe, Age_grp, Niveau_etud, Difficulte_financiere_grp,
         Satisfaction_logement_grp, Renonciation_medecin_grp,
         Revenu_pere_grp, Sante_mentale) %>% na.omit()

df_encoded <- df_clust %>%
  mutate(across(everything(), as.factor)) %>%
  model.matrix(~ . -1, data = .) %>% scale()

kmeans_res <- kmeans(df_encoded, centers = 3, nstart = 25)
df_clust$cluster <- factor(kmeans_res$cluster)

fviz_cluster(kmeans_res, data = df_encoded, geom = "point", ellipse.type = "convex")

# ====================================================================
# 7. Exportations
# ====================================================================
write.csv(df_clust, "results/clustering_results.csv", row.names = FALSE)
write.csv(confusionMatrix(predict(rf_model, newdata = test_data),
                          test_data$Sante_mentale_num)$table,
          "results/confusion_matrix_rf.csv")
