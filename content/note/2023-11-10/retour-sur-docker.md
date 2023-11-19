---
title: "Retour Sur Docker"
date: 2023-11-10T14:09:22Z
draft: true
tags: [docker]
slug: "retour-sur-docker" 
---

Docker est incourtournable dans le developpement (web) aujourd'hui.  
Je l'ai toujours utilisé rapidement, comme utilisateur final, rarement pour écrire moi-même des DockerFile ou des compose.yml.  
J'ai décidé de m'y pencher un peu plus et de l'utiliser plus souvent.

<!--more-->

## Contexte 

Je n'ai jamais eu de besoin fort d'utiliser [Docker](https://www.docker.com/).  
Je n'ai pas eu a tester mes modules sur différentes versions de PrestaShop, je me suis contenté de faire tourner des contenaires mysql, ftp et redis, simplement.  j'ai rencontré un client avec un site sous Docker et je l'ai mis en place sur un autre projet. Mais dans ces contextes de travail, je n'ai pas pris le temps de bien creuser les possibilités offertes par Docker. Mettre les machines en fonctionnement était mon seul but.

## Problèmes

Les problèmes que j'ai pu rencontrer avec Docker sont liés aux réseaux, aux lancements et interactions avec les containers sous Windows (pour mes collaborateurs).

A ce jour, je manque de pratique. Utiliser Docker n'est pas vraiment agréable, je ne suis pas très efficace avec. Mais je vais y remedier et j'ai déjà commencé. J'ai profité des conditions tempétueuses des vacances de la Toussain pour me plonger dans la doc et l'expérimentation poussée de Docker.

Voici ce que j'ai appris en lisant/testant. 

## Lecture de la doc et tests

En préambule, il faut préciser que la documentation est très fournie, avec des _exemples de début_ bien fait et une référence complète bien détaillée (généralement).
Par contre, avec toutes les fonctionnalités annexes (compose, swarm, scout, ...) on peut parfois se perdre un peu dans les contenus. Pour les fonctionnalités avancées, il n'y a pas d'example très détaillé (je pense à la gestion des secrets) et il faudra expérimenter ou faire d'autre recherches pour bien comprendre.

On trouves des guides, des manuels et des références, cette séparation est bien pensée pour rentrer progressivement dans Docker.

### Docker desktop

J'ai toujours géré les données de docker sans le GUI proposé (il n'existait pas tout simplement pas quand j'ai démarré Docker). En installant [Docker desktop](https://www.docker.com/products/docker-desktop/), il y a quelques mois, j'ai pu voir que mes données (images, containers, ...) n'y sont pas listées. On aurait dit une histoire de contexte, j'ai pu voir dans la doc que c'est bien ça.  J'en suis resté là sur ma machine fixe, je teste actuellement avec mon portable.
Sur ce vieux portable, j'ai tenté l'installation mais ça n'est pas possible, le processeur n'a pas fonctionnalité de virtualisation.  
J'en ai profité pour tester [Portainer](https://www.portainer.io/) qui est une altenative au desktop qui fonctionne très bien, peut-être un peu moins ergonomique, à voir. Fort possible que je l'utilise à l'avenir si j'ai beaucoup de données à gérer.  

### Build

Le _Build_ de docker c'est ce qui concerne la création d'image (ont instancie ensuite les images pour faire des containers).  
Je ne reviens pas sur les fonctions de base (_FROM_, etc), [c'est bien documenté](https://docs.docker.com/build/building/packaging/).

### Multistage build

Dans un seul fichier _Dockerfile_ on peut construire plusieurs images et/ou contruire une image en plusieurs étapes.  

- Ça peut permettre de créer une image destinée à la prod et une destinée au dev.
- construire une image finale propre quand on a dû installer/construire beaucoup de choses à partir de sources

J'ai expérimenté, ça fonctionne bien quand on a compris [comment sont gérées les instructions _ARG_](https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact). Je saurais m'en servir le temps venu, ça fait partie des bonnes pratiques officielles.

### ENTRYPOINT vs CMD

Dans les 2 cas, il s'agit de l'instruction exécutée au lancement du container.  
Ce que je retiens de la doc de [ENTRYPOINT](https://docs.docker.com/engine/reference/builder/#entrypoint) et [CMD](https://docs.docker.com/engine/reference/builder/#cmd). Il faut préférer les formes json (`CMD ["/usr/bin/wc","--help"]`) pour les deux instructions. Même si c'est moins lisible et plus pénible à écrire, il faut le faire pour au moins deux raisons. L'articulation entre les instructions et les signaux.    
Concrêtement, avec la forme json pour la gestion des arguments, ça permet à CMD de proposer des arguments pour l'entry point, on peut spécifier des arguments à passer à la commande de l'entry point avec `docker run monimage -xx`, les arguments de CMD sont remplacés, ceux de l'entry point (`ENTRYPOINT ["executable", "param1", "param2"]`) sont conservés.  
Pour le passage des signaux, quand on envoit un signal de fin d'execution (CTRL+D), le signal est passé à la commande de l'entrypoint.

### On build

Cette instruction permet d'executer des instructions lorsque l'image est utilisée pour construire une autre image. Je ne vois pas d'utilité pour moi actuellement, mais au besoin, je saurais que ça existe.  
[Onbuild](https://docs.docker.com/engine/reference/builder/#onbuild).

### ARG

Permet de définir des variables dans un DockerFile, pour la construction de l'image (pas pour le container), pratique. Je connaissais déjà mais je vois maintenant bien la différence avec les variables d'environnement.  
[ARG](https://docs.docker.com/engine/reference/builder/#arg).

### ADD/COPY

[ADD](https://docs.docker.com/engine/reference/builder/#add) et [COPY](https://docs.docker.com/engine/reference/builder/#copy) font fondamentalement la même chose, mais ADD est plus riche et permet d'ajouter des contenus distants, notament le contenu de dépots git en précisant la référence (tag, branche). On évite ainsi d'installer git dans l'image.  
Pour les deux instructions, on peut préciser des droits et faire des liens symboliques.

### RUN

J'ai appris qu'il y avait une option `--mount` qui permet d'acceder aux fichiers, à des ressources distantes par ssh ou à des _secrets_ . Je n'ai pas encore joué avec cette option.

### FROM

La chose importante que j'ai appris c'est qu'on peut utiliser des images disponibles sur le net avec la forme `docker build url#ref:dir`. Pour un dépot git, on précisera la `ref` (ref git) et eventuellement le dossier (`:dir`).  On est donc pas tributaire ni du hub docker (ni de la mise en place d'un hub privé).  [build](https://docs.docker.com/engine/reference/commandline/build/#git-repositories).

### Compose config

Coté `docker compose` la chose importante, nouvelle pour moi, c'est la commande `docker compose convert`.  
C'est commande permet de valider, reformater un fichier compose existant. La commande permet aussi de transformer le contenu en explicitant les paramètres.

Si vous avez un compose_serve.yml comme ceci :

```yaml
services:
  hugo:
    ports:
      - 1313:1414
```

Avec la `docker compose -f compose_serve.yml convert`, vous obtenez
```yaml
name: blog
services:
  hugo:
    ports:
      - target: 1314
        published: 1313
```
Le port du contenaire et le port exposé sont explicitement nommés, c'est plus clair. L'ordre des paramètres est changé également, les réseaux explicités aussi, bref, on a une forme normalisée, parfaite pour bien suivre les modifications et faire des comparaisons.

Avec un compose qui fait appel à un autre compose.yml, on obtient le contenu aplati (la référence au fichier source est remplacée par le contenu source, plus les instructions mergés).

### Composition de compose

Pour éviter les rédondances on peut utiliser un compose.yml source et y modifier quelques instructions de cette façon :

```yaml
services:
  hugo:
    extends:
      file: compose_serve.yml
      service: hugo
    entrypoint: ["/bin/sh", "-c" , "rm -rf public/* && hugo"]
```

### Docker run : --mount vs --volume 

Généralement on trouve dans les docs et autres ressources des commandes sous leur formes courtes.

```shell
docker run --rm -it -v $(pwd)/content:/tmp/yep php:8.2-cli /bin/bash
```

On peut utiliser la forme longue pour faire exactement la même chose.  
A un détail près, avec la forme longue, si le dossier `content` n'existe pas sur l'hôte, on a une erreur alors qu'avec la forme courte, le contenaire est créé/lancé sans erreur et le dossier /tmp/yep est vide.  
Ça n'est pas du tout un détail, c'est essentiel de lever des erreurs le plus tôt possible quand on rate quelque chose (on peut généraliser cette philosophie à presque tout). On preferera donc la forme longue, plus secure et explicite :

```shell
docker run --rm -it --mount src=$(pwd)/content,target=/tmp/yep,type=bind php:8.2-cli /bin/bash
```

### Pour continuer

Maintenant que j'ai fais le tour de la doc qui m'interesse (j'ai ignoré docker swarm), mes prochaines étapes seront, la lecture des [best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/) et ce qui [docker hub](https://docs.docker.com/docker-hub/).