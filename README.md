# 📊 Analyse des données de l’Observatoire de la Vie Étudiante (OVE)

## 🎯 Objectif
L’objectif de ce projet est de mieux comprendre les **facteurs qui influencent la santé mentale et générale des étudiants en France**, en utilisant les données de l’OVE 2016 (46 000 observations).  

Ce projet combine :
- des **méthodes économétriques classiques** (régressions logistiques et ordinales) pour mesurer l’impact des variables,  
- et des **méthodes de Machine Learning** (Random Forest, clustering) pour prédire et segmenter les profils étudiants.

---

## 📂 Structure du projet
- **data/** : données nettoyées  
- **scripts/** : scripts R pour analyses et modèles  
- **results/** : figures et tableaux exportés  
- **report/** : rapport complet (PDF)

---

## 🔎 Méthodologie
1. **Analyse descriptive** : observer la répartition des étudiants selon le sexe, l’âge, le logement, les difficultés financières, etc.  
2. **Analyse bivariée** : vérifier les liens entre caractéristiques sociodémographiques et santé mentale.  
3. **Modèles économétriques** :
   - Logit binaire → probabilité de déclarer des troubles psychologiques.  
   - Logit ordinal / multinomial → état de santé générale (insatisfait, neutre, satisfait).  
4. **Machine Learning** :
   - Random Forest → prédire la santé mentale et identifier les variables les plus importantes.  
   - K-means → regrouper les étudiants en profils homogènes selon leurs conditions de vie.  

---

## 📊 Résultats

### 1. Résultats économétriques

- **Santé mentale (logit binaire)**  
![Forest Plot – Santé mentale](results/forest_plot_logit.png)  

👉 Ce graphique montre l’**impact de chaque facteur sur la probabilité de déclarer des troubles psychologiques**.  
- Les étudiants ayant des difficultés financières ou un revenu parental faible présentent un risque plus élevé.  
- La satisfaction vis-à-vis du logement joue un rôle protecteur.  
- L’âge (plus de 25 ans) est également associé à une probabilité plus forte de troubles.  

---

- **Santé générale (logit ordinal)**  
![Santé générale prédite](results/sante_generale_predite.png)  

👉 Ici, on observe les **probabilités prédites d’évaluer sa santé comme “insatisfaisante”, “neutre” ou “satisfaisante” selon le niveau de difficultés financières**.  
- Les étudiants avec de fortes difficultés financières déclarent beaucoup plus souvent une santé insatisfaisante.  
- À l’inverse, l’absence de difficultés augmente nettement la probabilité d’être satisfait de sa santé.  

---

### 2. Résultats Machine Learning

#### 🔹 Random Forest
- **Courbe ROC**  
![Courbe ROC – Random Forest](results/roc_randomforest.png)  

👉 La courbe ROC illustre la capacité du modèle à distinguer les étudiants avec ou sans troubles psychologiques.  
Même si les performances restent modestes (AUC autour de 0.54), le modèle parvient à identifier des variables prédictives intéressantes.  

- **Matrice de confusion**  
[Télécharger en CSV](results/confusion_matrix_rf.csv)  

👉 Cette matrice compare les prédictions du modèle avec la réalité.  
On voit que le modèle tend à prédire surtout la catégorie majoritaire (étudiants sans troubles), ce qui reflète le déséquilibre des données.  

- **Indicateurs de performance**  
[Télécharger en CSV](results/performance_random_forest.csv)  

👉 Les indicateurs (Accuracy ≈ 59%, Sensibilité ≈ 59%, Spécificité ≈ 46%, F1 ≈ 0.73) montrent que le modèle doit être interprété avec prudence.  
Il est surtout utile pour **repérer les variables clés**, plus que pour une prédiction parfaite.  

---

#### 🔹 Clustering K-means
- **Visualisation des clusters**  
![Clustering K-means](results/clustering_kmeans.png)  

👉 Le clustering segmente les étudiants en **3 profils distincts** en fonction de leurs caractéristiques (âge, sexe, conditions de vie, difficultés financières…).  
- Chaque couleur correspond à un groupe d’étudiants homogènes.  
- Cette typologie permet d’identifier des sous-populations à cibler dans des politiques de prévention (ex. étudiants isolés avec forte précarité).  

---

## 📝 Conclusion
- Les **difficultés financières**, le **revenu parental** et la **satisfaction du logement** sont les déterminants majeurs de la santé mentale des étudiants.  
- Les modèles économétriques confirment l’importance de ces facteurs.  
- Le **Random Forest** permet d’illustrer les mêmes tendances, même si les performances de prédiction restent limitées à cause du déséquilibre entre étudiants avec/sans troubles.  
- Le **clustering K-means** met en évidence l’existence de profils types d’étudiants, ouvrant la voie à des stratégies de prévention différenciées.  

👉 En résumé : ce projet montre à la fois ma maîtrise des **méthodes statistiques classiques** et des **outils modernes de Machine Learning**, appliqués à une problématique concrète de santé publique étudiante.
