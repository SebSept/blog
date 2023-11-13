---
title: "Retour Sur Docker"
date: 2023-11-10T14:09:22Z
draft: true
tags: [docker]
slug: "retour-sur-docker" 
---

Docker est incourtournable dans le developpement (web) aujourd'hui.  
Je l'ai toujours utilisé rapidement, comme utilisateur final, rarement pour écrire moi-même des DockerFile ou des compose.yml.  
J'ai décidé de me pencher un plus dedans et de l'utiliser plus souvent.

<!--more-->

## Contexte 

Je n'ai jamais vraiment eu de besoin fort d'utiliser [Docker](https://www.docker.com/).  
Je n'ai pas eu a tester mes modules sur différentes versions de PrestaShop, je me suis contenté de faire tourner des contenaires mysql, ftp et redis, simplement. j'ai eu nativement plusieurs versions de php sur ma machine (en cli et en apache) et ça me suffisait pour me simuler des différents environnements de production.

En agence, j'ai rencontré un client avec un site developpé avec Docker et je l'ai mis en place sur un autre projet. Dans ces contextes de travail, je n'ai pas pris le temps de bien creuser les possibilités offertes par Docker.

## Problèmes

Les problèmes que j'ai pu rencontrer avec Docker sont liés aux réseaux et aux taches de configuration des projets qui ne fonctionnait pas sous Windows (j'en reparlerai dans une autre note peut-être, ça n'est pas le sujet ici).

Quand je veux créer des images, des ensembles avec docker-compose, je tombe rapidement sur des blocages, je n'arrivais pas à faire ce que je veux. Je manque de pratique et de connaissances pour q'utiliser Docker soit vraiment efficace et agréable.  

J'ai profité des vacances de la Toussain sous un temps exécrables pour me plonger dans la doc et l'expérimentation poussée de Docker.

Aujourd'hui, je m'en sort bien mieux (j'ai passé la gestion du code de ce blog entirèment sous docker sans difficulté). 

Voici ce que j'ai appris en lisant/testant. 

## Lecture de la doc et tests

En préambule, il faut préciser que la documentation est très fournie, avec des exemples de début bien fait et une référence complète bien détaillée.  
Par contre, avec toutes les fonctionnalités annexes (compose, swarm, scout, ...) on peut parfois se perdre un peu dans le menu. Pour les fonctionnalités avancées, il n'y a pas d'example très détaillé (je pense à la gestion des secrets) et il faudra expérimenter ou faire d'autre recherches pour bien comprendre.

@todo detailler guides, manual, ref

### Docker desktop

J'ai toujours géré les données de docker sans le GUI proposé (il n'existait pas tout simplement). En installant [Docker desktop](https://www.docker.com/products/docker-desktop/), il y a quelques mois, j'ai pu voir que mes données n'y sont pas listées. On aurait dit une histoire de contexte, j'ai pu voir dans la doc que c'est bien ça.  
Sur mon vieux portable, j'ai tenté l'installation mais ça n'est pas possible, le processeur n'a pas fonctionnalité de virtualisation.  
J'en ai profité pour tester [Portainer](https://www.portainer.io/) qui est une altenative au desktop qui fonctionne très bien, peut-être un peu moins ergonomique (à voir).  

### Build

Le _Build_ de docker c'est ce qui concerne la création d'image (ont instancie ensuite les images pour faire des containers).  
Je ne reviens pas sur les fonctions de base (_FROM_, etc), [c'est bien documenté](https://docs.docker.com/build/building/packaging/).

### Multistage build

Dans un seul fichier _Dockerfile_ on peut construire plusieurs image et/ou contruire une image en plusieurs étapes.  

- Ça peut permettre de créer une image destinée à la prod et une destinée au dev.
- construire une image finale propre quand on a du installer construire beaucoup de choses à partir de sources
- Pourquoi pas organiser les choses en gérant 2 images dans un seul fichier

J'ai expérimenté ça, ça fonctionne bien quand on a compris [comment sont gérées les instructions _ARG_](https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact).

### Entry point vs CMD

Ce que je retiens de la doc de [Entry point](https://docs.docker.com/engine/reference/builder/#entrypoint) et [CMD](https://docs.docker.com/engine/reference/builder/#cmd) c'est qu'il faut préférer les formes json (`CMD ["/usr/bin/wc","--help"]`) pour les deux instructions, même si c'est moins lisible et plus pénible à écrire. Il faut le faire pour au moins deux raisons.  
Pour la gestion des arguments, ça permet à CMD de proposer des arguments pour l'entry point, on peut spécifier des arguments à passer à la commande de l'entry point avec `docker run monimage -xx`, les arguments de CMD sont remplacés, ceux de l'entry point (`ENTRYPOINT ["executable", "param1", "param2"]`) sont conservés.  
Pour le passage des signaux, quand on envoit un signal de fin d'execution (CTRL+D), le signal est passé à la commande de l'entrypoint.

### On build

### ARG

### ADD/COPY
-> Application à Hugo dans un prochain article

