---
title: "Configuration Facile De Xdebug en Cli "
date: 2023-12-05T14:54:50Z
draft: true
tags: ["php","xdebug","docker"]
slug: "configuration-facile-de-xdebug-en-cli"
image: "/home/app/content/note/2023-12-05/configuration-facile-de-xdebug-en-cli.md/ogimage.png
---

J'ai pris un peu de temps pour creuser l'utilisation de xdebug avec les commandes en cli et phpstorm.

<!--more-->

Pour le contexte, j'utilise phpstorm et j'ai un petit container docker avec mon appli php. C'est une appli en cli (pas un page web, un script à lancer dans un shell).  
Mon intention c'est de faire du _step debugging_, c'est à dire mettre des _breakpoints_ pour voir l'état du script (évaluer des commandes dans ce contexte, voir la trace, etc).

## C'est peut-être compliqué ...

La [doc officielle de xdebug](https://xdebug.org/docs/step_debug) et la [doc de phpstorm](https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html) sont très touffues et on s'y perd. On s'y perd vraiment si on va chercher dans les [paramètres](https://xdebug.org/docs/all_settings) pourquoi ça ne va. De quoi se décourager si on est pressé de mettre son enviromment de developpement en place). Je sais que beaucoup vont préférer lancer de vulgaires exceptions et dump() à la place. Pas très pro convenons en.

Je vous ai dit qu'on avait 3 localisations pour paramétrer xdebug ? dans un fichier d'initialisation de php (99-xdebug.ini), dans les paramètres de la ligne commande `php -dxdebug_client_host=172.18.0.1 ... monscript.php` et dans les variables d'environnement `XDEBUG_CONFIG="client_host=192.168.42.34 log=/tmp/xdebug.log" php monscript.php`.


## Mais en fait, c'est pas très compliqué

Il y a deux choses à faire, lancer le script et configurer phpstorm pour qu'il écoute les infos.

Tout d'abord, dans phpstorm, ça fonctionne out of the box, on peut lancer une commande php en mode debugage et tout est ok. (Run > debug).  
Ça pourrait me suffire si mon script n'était pas une commande interactive. Mais pour un script interactif, on est bloqué (ou alors il faut m'expliquer). Et puis savoir ne pas être dépendant de son ide est une bonne chose.

### La configuration de phpstorm

Quand phpstorm lance lui même la commande, il met tout ce qu'il faut en variable d'environnement et il sait quel fichier est exécuté.  Quand ça n'est pas phpstorm qui lance la commande, c'est à nous de définir les variables d'environnement, comme vu juste avant, mais il faut aussi indiquer un _mapping_ à notre ide pour qu'il sache quel fichier sur le serveur correspond à nos fichiers locaux. Pour ça il faut défini un serveur dans phpstorm (pas un serveur d'outils, pas un serveur de déploiement (il y a beaucoup de choses dans phpstorm). 

Pour créér un serveur dans phpstorm : Configuration (CTRL+S) > PHP > Servers : ajout un serveur, cocher "use path mapping" et indiquer la localisation correspondant à la racine de votre projet.  
Ce serveur il aura un petit nom, c'est ce nom qu'il faut utiliser dans la variable d'environnement <a verifier ide_config>


### Lancement du script

D'abord il faut savoir qu'on a pas besoin de mixer les entrées de configuration, on va choisir de procéder par config de php, variable d'environnement ou paramètre passé à php. Ici, j'ai choisi les variables d'environnement, je reviendrai peut-être sur ce choix à l'avenir, je verrai.

<la ligne de commande>

### Config de port docker

Il n'y a pas de configuration à faire si vous utiliser l'adresse de votre machine vue par docker. Usuellement quelque chose qui ressemble à 172.x.0.1.

## Les clés à emporter

Pour lancer un script php à déboger <completer>:

1. Définir un serveur php sur votre phpstorm en utilisant le _path mapping_ et noter son nom.
2. Ajouter des variables d'environnement dans la commande shell qui lance votre script.

## Pour aller plus loin

Je continue de dockerisé complètement mon environnement de travail. Il faudra voir pour ce qui concerne les pages web maintenant, ça viendra quand j'en aurais besoin. A ce moment, je serais peut-être amené à revoir ma config.


