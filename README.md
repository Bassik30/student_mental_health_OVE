# 📊 Analyse des données de l’Observatoire de la Vie Étudiante (OVE)

## 🎯 Objectif
Analyser les déterminants de la santé mentale et générale des étudiants en France à partir des données OVE 2016.  
L’étude combine **méthodes économétriques classiques** et **approches Machine Learning**.

## 📂 Structure
- **data/** : données nettoyées ou scripts de préparation
- **scripts/** : code R pour analyses et modèles
- **results/** : figures et tableaux exportés
- **report/** : rapport complet (HTML/PDF)
- **README.md** : ce fichier

## 🔎 Méthodologie
1. **Analyse descriptive** : profils étudiants, santé mentale et conditions de vie.  
2. **Analyse bivariée** : associations entre variables sociodémographiques et santé mentale.  
3. **Modèles supervisés** :
   - Logit binaire (santé mentale)
   - Logit ordinal et multinomial (santé générale)
   - Random Forest (importance des variables, AUC/ROC)
4. **Modèle non supervisé** :
   - Clustering K-means (profils-types d’étudiants)

## 📈 Résultats clés
- Les difficultés financières, le revenu parental et la satisfaction du logement sont les principaux déterminants de la santé mentale.
- Le modèle Random Forest confirme ces variables comme prédictives majeures.
- Les clusters révèlent des groupes distincts d’étudiants avec vulnérabilités différenciées.

## 📘 Rapport complet
- [📄 Lire le rapport HTML](report/rapport_OVE.html)  
- [⬇️ Télécharger le PDF](report/rapport_OVE.pdf)

## 🖼️ Exemples de visualisations
![Courbe ROC - Random Forest](results/roc_randomforest.png)  
![Clustering K-means](results/clustering_kmeans.png)

---
