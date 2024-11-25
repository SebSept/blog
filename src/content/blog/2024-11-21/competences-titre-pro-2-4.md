---
title: "📑 Dossier De Projet - 2/4 - Concevoir et développer la persistance des données"
pubDatetime: 2024-11-21
draft: true
tags: ["Symfony", "apiplatform", "docker"]
slug: "dossier-de-projet-2"
description: "Mon dossier de projet professionnel : 2/4 Concevoir et développer la persistance des données"
featured: false
---

Ce post est le second d'une série de quatre articles qui décrivent mon dossier de projet professionnel pour l'obtention du titre professionnel. Le premier post se trouve [ici](/post/dossier-de-projet).

Le bloc s'intitule précisément _Concevoir et développer la persistance des données en intégrant les recommandations de sécurité_. Il est composé de trois parties : [Concevoir une base de données](#concevoir-une-base-de-données), [Mettre en place une base de données](#mettre-en-place-une-base-de-données) et [Développer des composants dans le langage d'une base de données](#mettre-en-place-une-base-de-données).

C'est finalement assez basique pour moi qui manipule les SGBD _MySQL_ et _MariaDB_ depuis des années. Pour le projet, j'ai choisi d'utiliser _PostgreSQL_, c'est le SGBD utilisé par défaut par Symfony. Comme indiqué dans la note de pré-démarrage, je
m’efforce de me conformer aux standards et aux configurations initiales de _Symfony_.  Je n'avais jamais eu l'occasion de l'utiliser. C'était donc le bon moment, car je disposais d'une marge de temps et que j'ai évalué dans la gestion du risque que c'était possible (le choix du SGBD ne figure pas dans les risques, tant il est mineur).

## Concevoir une base de données

J'ai conçu la base de données d'abord dans phpstorm avec le plugin [plantuml](https://plantuml.com/fr/) mais ça n'était pas très satisfaisant, uml n'est pas fait représenter les bases de données (ou je m'y prenais mal), j'ai utilisé LucidChart comme recommandé dans les cours, sans chercher plus loin. Avec du recul et pour une prochaine fois, j'utiliserai peut-être  [dbdiagram.io](https://dbdiagram.io/home) qui semble parfaitement adapté à la tâche.

Rien de très sorcier, c'est sans difficulté que j'ai conçu une base de données normalisée. Le rendu n'est pas fameux mais ça n'est pas très important car ce schéma n'est pas un document de travail très utilisé, comme on va le voir.

![Schéma de la base de données](./base_de_donnees.png)

Une chose n'apparait pas dans ce schéma, le fait qu'un user peut également être une secrétaire ou un administrateur. Ces personnes n'ont pas de profil. On aurait pu le voir si on avait un type Enum pour les rôles dans le user, mais la norme dans le développement Symfony semble être de gérer les contraintes au niveau de l'entité Doctrine plus que dans la base de données.  
Je vais d'ailleurs digresser un peu. Par le passé j'ai développé une petite application pour gérer un championnat de poker entre amis. J'avais pris l'option d'utiliser les fonctions avancées de la base de données, des vues, des procédures et des triggers. C'était très intéressant, mais cela présente au moins deux problèmes qui font que j'évite désormais ce type de pratiques (en cohérence avec la logique qu'on trouve un peu partout). 

## Mettre en place une base de données

## Développer des composants dans le langage d'une base de données