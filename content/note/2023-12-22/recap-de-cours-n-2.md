---
title: "Recap De Cours n°2"
date: 2023-12-22T15:54:54Z
draft: false
tags: [formation, docker]
slug: "recap-de-cours-n-2"
image: "/home/app/content/note/2023-12-22/recap-de-cours-n-2.md/ogimage.png"
---

Restitution de mes notes de formation.
Dans cette note, je vais continuer de solder le décalage.

<!--more-->

## Introduction aux bases de données

Le premier bloc consacré aux bases de données aborde des généralités sur les bases de données.  Les différents type de base, les bases sql. J'avais quelques lacunes, j'ai appris peu de choses, c'est normal,  mais je suis très content de ce que j'ai appris, autant au niveau théorique que pratique.
Il y a une introduction à MongoDb que j'ai trouvé très intéressante, je l'ai complété avec 2 replays de lives (il m'en reste 3 à voir). Les replays sont très légers, les suivants peut-être plus instructifs, j'ai prévu de les regarder.
J'ai aussi pu tester postgresql, très interessant, ça donne vraiment de l'utiliser, comme MongoDb.  J'aimerai bien developper des petites choses avec ces SGDB mais j'ai d'autres priorités pour le moment.

- J'ai appris des chose intéressante sur le type float, j'ai creusé la question en dehors du cours.
- des choses interessantes sur les indexes composites
- j'ai remis du vocabulaire _au propre_
- j'ai trouvé une faute dans le cours sur la définition des colonnes `DECIMAL(a,b)` (lol) mais le cours est de bonne qualité tout de même :)

J'ai surtout appris ce qu'est du fenêtrage avec `OVER(ORDER BY ...)` et `OVER (PARTITION BY ...)`, pour faire des aggrégation sans réduction des lignes retournées (je ne vous refais pas le cours). Très interessant, on utilise généralement pas assez la puissance des SGBD.

## Docker to the rescue

Je suis bien content d'avoir pris du temps pour ajouter une étoile dans ma maîtrise de Docker, j'ai pu utiliser phpmyadmin, mongodb et postgresql sans rien installer sur machine, et en un rien de temps grâce à [Docker](/tags/docker/), le retour sur investissement est en cours :)

## Gestion de projet

Il y a des contenus vraiment intéressants (pas tous).  Je suis parti un peu dégouté du sujet de la gestion de projet sur ma précédente expérience pro. Mais je suis en train de me réconcilier avec le thème.  
Le sujet est abordé de façon très pro, on apprend les méthodes de gestions de projet, les étapes à mettre en place, les limites, les outils, etc.  On est sur une gestion rationnelle, scientifique du sujet. Il reste toujours une part qui s'appuie sur de l'expérience, le vécu mais c'est limité aux moments oû on ne pas faire autrement.  Ça donne vraiment envie de faire de la gestion de projet !

Je me dit que parmis mes colaborateurs passés, je n'ai pas dû en rencontrer beaucoup qui ont appris cette gestion. Probablement aucun à vrai dire, ou alors, ils ont bien caché leurs acquis ;)

On a une partie sur la gestion Scrum, je crois avoir vu toutes les erreurs possibles par le passé, ça me fait bien rire. En fait, savoir saisir des données dans Jira est à la gestion de projet ce qu'emmètre des sons est au langage. 
J'ai commencé à utiliser [GanttProject](https://www.ganttprojet.biz) ( [github](https://github.com/bardsoftware/ganttproject)). Ça me semble très bien comme soft, il ne fait pas plus que ce qu'on lui demande et c'est parfait pour éviter de se disperser dans des détails.  
Au passage, j'ai testé [YouTrack](https://www.jetbrains.com/youtrack/) via [docker](https://hub.docker.com/r/jetbrains/youtrack), ça ressemble beaucoup à Jira, en plus simple. Je me suis interssé au diagramme de Gant, il à l'air plus souple que ceux de GanttProject mais je ne suis pas sur que ça soit une bonne chose. A confirmer.


