---
title: "Apiplatform Et Symfony"
date: 2024-04-05T15:25:36Z
draft: false
tags: ["symfony"]
slug: "apiplatform-et-symfony"
---

Cette semaine et la semaine dernière, j'ai consacré presque exclusivement mon temps à Symfony.

<!--more-->

## Projet en cours de formation

Pour valider mon titre professionel, je vais présenter un projet à un jury.  
Dans ce cadre, Studi propose un projet que nous devons réalisé. Ce projet est relavivement complet et complexe, il vise à nous faire mettre en oeuvre l'ensemble des compétences du [titre professionnel Concepteur développeur d'applications](https://www.francecompetences.fr/recherche/rncp/37873/).

En deux mot le projet consiste à developper un système de réservation de rendez-vous. Avec une api, un client web, un client mobile et un client desktop.  
Pour les parties client web et api, je vais utiliser Symfony.  
J'ai passé pas mal de temps à rédiger le document de pré-démarrage, la note de cadrage et le cahier des charges, à faire une roadmap et un planning. J'ai ensuite réalisé des wireframe et entamé une documentation technique de référence pour finalement enfin commencer à developper une infrastructure en Docker et finalement  travailler sur le composant API.

## API Platform

Determiner qu'il fallait utiliser [API Platform](https://api-platform.com/) s'est imposé et avec un peu de recule, ça semble toujours la meilleure option.  
Il y a une très bonne documentation, c'est très bien conçu et on sent bien qu'on est sur une version mature (la version 3). [Symfonycasts](https://symfonycasts.com/) propose d'excelentes vidéos (et textes) pour la découverte et l'approfondissement, c'est une très bonne ressource, je me suis abonné (pour un mois pour le moment, je risque de poursuivre).  
J'ai appris beaucoup de choses sur l'utilisation directe de d'API Platform. Comme c'est très bien intégré dans Symfony, j'ai également appris beaucoup de choses sur Symfony. Je suis un peu revenu sur l'utilisation de [Doctrine](https://symfony.com/doc/current/doctrine.html), j'ai également appris à utiliser (une partie) du composant de [sécurité](https://symfony.com/doc/current/security.html) (SymfonyCast m'a bien guidé). J'ai mis en place un système d'authentification qui permet avec un mot de passe et un identifiant d'obtenir une token. Ce token sert ensuite à faire des appels à l'api. Les endpoints (actions) de l'api sont accessible en fonction des roles des utilisateurs (patient, docteur, secrétaire, admin). 

En plus, j'ai appris comment tester une api (et faire des fixtures) avec [Foundry](https://symfony.com/bundles/ZenstruckFoundryBundle/current/index.html). J'ai creusé aussi le composant de sérialisation, deux, trois choses sur phpunit, le profiler, etc.

En bref, le projet avance, c'est extrèmement formateur !

