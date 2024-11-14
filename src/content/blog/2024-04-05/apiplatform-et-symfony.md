---
title: "Apiplatform Et Symfony"
pubDatetime: 2024-04-05
draft: false
tags: ["symfony", "apiplatform"]
slug: "apiplatform-et-symfony"
description: "Cette semaine et la semaine dernière, j'ai consacré presque exclusivement mon temps à Symfony."
---

Cette semaine et la semaine dernière, j'ai consacré presque exclusivement mon temps à Symfony.

<!--more-->

## Projet en cours de formation

Pour valider mon titre professionnel, je vais présenter un projet à un jury.  
Dans ce cadre, _Studi_ propose un projet que nous devons réaliser. Ce projet est relativement complet et complexe, il vise à nous faire mettre en œuvre l'ensemble des compétences du [titre professionnel Concepteur développeur d'applications](https://www.francecompetences.fr/recherche/rncp/37873/).

En deux mot le projet consiste à développer un système de réservation de rendez-vous. Avec une api, un client web, un client mobile et un client desktop.  
Pour les parties client web et api, je vais utiliser Symfony.  
J'ai passé pas mal de temps à rédiger le document de pré-démarrage, la note de cadrage et le cahier des charges, à faire une roadmap et un planning. J'ai ensuite réalisé des wireframe et entamé une documentation technique de référence pour finalement enfin commencer à développer une infrastructure en Docker et finalement travailler sur le composant API.

## API Platform

Determiner qu'il fallait utiliser [API Platform](https://api-platform.com/) s'est imposé et avec un peu de recul, ça semble toujours la meilleure option.  
Il y a une très bonne documentation, c'est très bien conçu et on sent bien qu'on est sur une version mature (la version 3). [Symfonycasts](https://symfonycasts.com/) propose d'excellentes vidéos (et textes) pour la découverte et l'approfondissement, c'est une très bonne ressource, je me suis abonné (pour un mois pour le moment, je risque de poursuivre).  
J'ai appris beaucoup de choses sur l'utilisation directe de d'API Platform. Comme c'est très bien intégré dans Symfony, j'ai également appris beaucoup de choses sur Symfony. Je suis un peu revenu sur l'utilisation de [Doctrine](https://symfony.com/doc/current/doctrine.html), j'ai aussi appris à utiliser (une partie) du composant de [sécurité](https://symfony.com/doc/current/security.html) (SymfonyCast m'a bien guidé). J'ai mis en place un système d'authentification qui permet avec un mot de passe et un identifiant d'obtenir un _token_. Ce _token_ sert ensuite à faire des appels à l'api. Les endpoints (actions) de l'api sont accessibles en fonction des roles des utilisateurs (patient, docteur, secrétaire, admin).

En plus, j'ai appris comment tester une api (et faire des fixtures) avec [Foundry](https://symfony.com/bundles/ZenstruckFoundryBundle/current/index.html). J'ai creusé aussi le composant de sérialisation, deux, trois choses sur phpunit, le profiler, etc.

En bref, le projet avance, c'est extrêmement formateur !
