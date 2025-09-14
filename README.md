# 📊 Analyse des données de l’Observatoire de la Vie Étudiante (OVE)

## 🎯 Objectif
Analyser les déterminants de la santé mentale et générale des étudiants en France à partir des données OVE 2016.  
L’étude combine **méthodes économétriques classiques** et **approches Machine Learning**.

## 📂 Structure
- **data/** : données nettoyées ou scripts de préparation
- **scripts/** : code R pour analyses et modèles
- **results/** : figures et tableaux exportés
- **report/** : rapport complet (HTML/PDF)


## 🔎 Méthodologie
1. **Analyse descriptive** : profils étudiants, santé mentale et conditions de vie.  
2. **Analyse bivariée** : associations entre variables sociodémographiques et santé mentale.  
3. **Modèles supervisés** :
   - Logit binaire (santé mentale)
   - Logit ordinal et multinomial (santé générale)
   - Random Forest (importance des variables, AUC/ROC)
4. **Modèle non supervisé** :
   - Clustering K-means (profils-types d’étudiants)

## 📊 Résultats clés

### 1. Facteurs associés (modèles économétriques)

- **Santé mentale (logit binaire)**  
![Forest Plot – Santé mentale](results/figures/forest_plot_logit.png)

- **Santé générale (logit ordinal)**  
![Facteurs associés – Santé générale](results/figures/factors_sante_generale.png)

---

### 2. Machine Learning – Random Forest

- **Courbe ROC et AUC**  
![Courbe ROC – Random Forest](results/figures/roc_randomforest.png)

- **Matrice de confusion**  
![Matrice de confusion – RF](results/tables/confusion_matrix_rf.png)  
[Télécharger en CSV](results/confusion_matrix_rf.csv)

- **Indicateurs de performance (Accuracy, AUC, F1, etc.)**  
![Performance RF](results/tables/performance_rf.png)

---

### 3. Machine Learning – Clustering K-means

- **Segmentation en 3 clusters**  
![Clustering K-means](results/figures/clustering_kmeans.png)


## 📊 Résultats Machine Learning

### Visualisations
- Facteurs associés à la santé mentale (logit binaire)  
![Forest Plot – Logit](results/figures/forest_plot_logit.png)

- Clustering K-means des étudiants  
![Clusters K-means](results/figures/clustering_kmeans.png)

### Tableaux de performance
- Matrice de confusion – Random Forest  
![Confusion Matrix RF](results/tables/confusion_matrix_rf.png)

- Indicateurs de performance (Accuracy, AUC, F1, etc.)  
![Performance RF](results/tables/performance_rf.png)

---
