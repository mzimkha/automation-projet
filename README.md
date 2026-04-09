# automation-projet
# 🚀 Pipeline de génération automatique de projet Spring Boot

Ce pipeline GitHub Actions permet d’automatiser entièrement la création d’un nouveau projet Java Spring Boot dans un repository GitHub fraîchement créé.  
Il garantit une standardisation complète des projets tout en respectant les bonnes pratiques de développement, d’architecture et DevOps.

---

## ✅ Fonctionnalités principales

### 1️⃣ Création automatique du repository GitHub
Le pipeline reçoit un seul paramètre utilisateur :

- `project_name` → utilisé pour :
  - créer automatiquement le repository GitHub
  - générer le projet Spring Boot
  - définir le package Java du projet

📌 *Le repository ne doit pas exister : il sera créé automatiquement.*

---

### 2️⃣ Génération automatique d’un projet Spring Boot

Le pipeline génère un projet via **Spring Initializr** en utilisant :

- la version Spring Boot choisie (`spring_version`)
- les dépendances spécifiées (`dependencies`)
- un packaging Maven standard
- un package temporaire `com.sogeti.temp` (ensuite renommé)

---

### 3️⃣ Création d’une structure Java standardisée

Après génération, le pipeline crée automatiquement la structure suivante :

# A venir: Intégration de la partie k8s
✅ Création des fichiers manifestes pour deployer le projet avec tout les prérequis 
