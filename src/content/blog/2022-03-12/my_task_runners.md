---
title: "Task runners"
pubDatetime: 2022-03-12
draft: true 
slug: task-runners
tags: [python, php, outils]
description: "Task runners"
---

Lancer une compilation, des tests, vider un cache, copier des fichiers, etc, toutes ses tâches devraient être gérées par un outil dédié, un task runner.  
J'en discute dans cet article.

<!--more-->

## Un task runner ?

Quelque soit le projet, vous avez des taches à faire régulièrement.

Quel que soit le projet, vous avez presque toujours des taches récurrentes à faire.  
Quand on ne sort pas du contexte, on s'en rappelle et en manipulant bien son terminal, on retrouve facilement ces tâches.  
Mais ça pose tout de même pas mal de problèmes (que je détaille plus bas).

Un task runner (ou lanceur de taches si vous préférez), vient vous aider dans la gestion de ces taches.  
Avec un simple fichier on vient consigner ces taches pour les relancer simplement.

## Les problèmes à travailler sans task runner

Les taches ne sont pas explicitement définies et ça pose certains problèmes.

### Le cout cognitif

Se rappeller, rechercher à un coût. Hors, en bon développeur, on se doit de réduire au maximum nos efforts sur les tâches annexes pour se concentrer le coeur de nos métiers.  
Évitons ces efforts et consignons les taches dans un fichier pour le task runner.

### Le risque d'erreur

En se basant sur l'historique du shell ou sa mémoire, on se donne la possibilité de lancer une tache avec de mauvais paramètres ou tout simplement d'oublier qu'une est ou doit être lancée.

Pour un professionnel, ça n'est pas vraiment acceptable. 

## (Les avantages et) les limites

pas besoin de tout y mettre.


### Les solutions alternatives

- scripts composer
- ide
- document / note
- alias sur les outils


Probablement que vous configurerez votre IDE 



