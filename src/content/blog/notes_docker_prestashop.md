---
title: "Notes sur Prestashop avec Docker"
pubDatetime: 2021-11-05
draft: true
description: "Notes sur Prestashop avec Docker"
tags: ["prestashop", "docker"]
slug: "notes-sur-prestashop-avec-docker"
---

## Contexte

J'ai découvert [Docker](<https://fr.wikipedia.org/wiki/Docker_(logiciel)>) il y a quelques années.

### Point forts

- Avec les images disponibles sur le [hub docker](https://hub.docker.com/), on peut faire tourner presque tout ce qu'on veut très facilement, sans installation ni configuration fastidieuses, chronophages et incertaines.
- Ça permet de garder un environnement de travail propre.
- Il y a d'autres avantages, je vais rester concis.

### Point faibles

- Quand on a des besoins qui ne peuvent être satisfaits avec ce qu'on peut trouver, il faut apprendre a créer des images et container. Ça peut s'avérer long et couteux en énergie.
- Les documentations sur l'utilisation des images disponibles sont souvent incomplètes. Il peut y avoir du travail de configuration et d'adaptation assez pénible.

Il faut aussi noter que Docker peut se révéler gourmand en espace disque et en ressources comparé à une installation directement sur une machine linux. L'espace disque peut-être critique si vous ne prenez pas la peine de nettoyer les images et containers installés.
Ceci dit, ça reste moins gourmand que de lancer une machine virtuelle complète.
Le compromis praticité/ressource est finalement largement positif.

### Besoins liés à PrestaShop

Quand je développe un module, quasiment tout le temps, c'est pour un client précis. Je le développe in situ, sur une copie du site en production. Je n'ai donc pas besoin de tester le module sur plusieurs version de PrestaShop.

Il y a quelques jours, j'ai développé un module sans avoir d'accès direct au site sur lequel il sera en place.
Je connais la version de PrestaShop et de php, sans d'autre précision.

Je pourrai installer cette version localement et travailler dans cet environnement. Mais cela fait quelque temps que j'ai pour idée de tester les images Docker fournies par PrestaShop. À moyen terme utiliser les images PrestaShop Docker doit être plus rapide et fiable que d'installer un PrestaShop localement. J'ai donc fait quelques essais.

Je vous donne donc ici quelques informations qui ne relèvent pas d'une expérience consolidée mais bien d'une expérience initiale de PrestaShop avec Docker, étant moi-même peut expérimenté avec Docker.

## PrestaShop
