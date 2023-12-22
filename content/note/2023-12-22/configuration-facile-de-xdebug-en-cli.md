---
title: "Configuration Facile De Xdebug en Cli "
date: 2023-12-21T14:54:50Z
draft: false
tags: ["php","xdebug","docker", "phpstorm"]
slug: "configuration-facile-de-xdebug-en-cli"
image: "/home/app/content/note/2023-12-05/configuration-facile-de-xdebug-en-cli.md/ogimage.png"
---

J'ai pris un peu de temps pour creuser l'utilisation de xdebug avec les commandes en cli interactives et phpstorm.

<!--more-->

Pour le contexte, j'utilise [phpstorm](/tags/phpstorm) et j'ai un petit container [docker](/tags/docker) avec mon appli php. C'est une appli en cli (command line interface) interactive.
Mon intention c'est de faire du _step debugging_, c'est à dire mettre des _breakpoints_ pour voir déboger le script.

## C'est peut-être compliqué ...

La [doc officielle de xdebug](https://xdebug.org/docs/step_debug) et la [doc de phpstorm](https://www.jetbrains.com/help/phpstorm/configuring-xdebug.html) sont très touffues et on s'y perd. On s'y perd vraiment si on va chercher dans les [paramètres](https://xdebug.org/docs/all_settings) pourquoi ça ne va. Il y a de quoi se décourager si on est pressé de mettre son enviromment de developpement en place. Je sais que beaucoup vont préférer lancer de vulgaires die(), var_dump(),exceptions à la place. C'est pas très pro et c'est surtout bien moins efficace, en particulier si on doit chercher à quel moment ça part en sucette.

On a 3 façon de paramétrer xdebug. Dans un fichier d'initialisation de php (`99-xdebug.ini`, classiquement), dans les paramètres de la ligne commande `php -dxdebug_client_host=172.18.0.1 ... monscript.php` et dans les variables d'environnement `XDEBUG_CONFIG="client_host=192.168.42.34 log=/tmp/xdebug.log" php monscript.php`. En thèorie c'est pratique, en pratique ajoute inutilement de l'information. Ça peut être d'autant plus perturbant quand on sait qu'on peut mixer les 3 approches.
Dans [le zen de python](https://fr.wikipedia.org/wiki/Zen_de_Python) on peut lire 
> Sache qu'il ne devrait y avoir qu'une et une seule façon de procéder

C'est à mon avis une règle très importante, dans le doute, je m'y réfère souvent, j'imagine que c'est un principe que ne renierait pas [Oncle Bob](https://www.cultura.com/p-coder-proprement-9782326002272.html). 



## Mais en fait, c'est pas très compliqué

Il y a deux choses à faire, lancer le script et configurer phpstorm pour qu'il écoute les infos.

Tout d'abord, dans phpstorm, ça fonctionne _out of the box_, on peut lancer une commande php en mode debugage et tout est ok. (Run > debug).  
Ça pourrait me suffire si mon script n'était pas une commande interactive. Mais pour un script interactif, on est bloqué (ou alors il faut m'expliquer). Et puis savoir ne pas être dépendant de son ide est une bonne chose.

### La configuration de phpstorm

Quand phpstorm lance lui même la commande, il met tout ce qu'il faut en variable d'environnement et il sait quel fichier est exécuté.  
Quand ça n'est pas phpstorm qui lance la commande, il ne va faire que recevoir les infos de xdebug, c'est à nous de définir les variables d'environnement, mais il faut aussi indiquer un _mapping_ entre le fichier executé et nos fichiers locaux.  
Pour ça il faut définin un serveur dans phpstorm (pas un serveur d'outils, pas un serveur de déploiement (il y a beaucoup de choses dans phpstorm)). 

Pour créér un serveur dans phpstorm : _Configuration_ (CTRL+S) > PHP > Servers : _ajouter un serveur_, cocher `use path mapping` et indiquer la localisation correspondant à la racine de votre projet.  
Ce serveur il aura un petit nom, c'est ce nom qu'il faut utiliser dans la variable d'environnement `PHP_IDE_CONFIG`, par exemple : `PHP_IDE_CONFIG="serverName=myrepl"` (myrepl est le nom de mon _server_ créé à l'étape précédente dans phpstorm).

XDEBUG_MODE=debug XDEBUG_SESSION=1 XDEBUG_CONFIG="client_host=172.17.0.1 client_port=9003" PHP_IDE_CONFIG="serverName=myrepl" php /app/hello.php
# 

### Lancement du script

J'ai choisi d'utiliser les variables d'environnement pour la configuration de xdebug. Je reviendrai peut-être sur ce choix à l'avenir, pour le moment ça fait le taf.  
Dans le terminal de mon contenaire, je lance `XDEBUG_MODE=debug XDEBUG_SESSION=1 XDEBUG_CONFIG="client_host=172.17.0.1 client_port=9003" PHP_IDE_CONFIG="serverName=myrepl" php /app/hello.php` et c'est tout bon, phpstorm s'arretera sur le premier breakpoint défini. Je vais pouvoir regarder l'état des variables, taper du code php executé dans le contexte de breakpoint, bref déboger efficacement.

### Config de port docker

Il n'y a pas de configuration à faire si vous utiliser l'adresse de votre machine vue par docker. Usuellement quelque chose qui ressemble à 172.18.0.1.  
Par exemple pour le contenaire de dev de ce blog, je lance `docker inspect blog_hugo | grep Gateway` et j'ai l'ip de ma machine sur le réseau docker.

## Les clés à emporter

Pour lancer un script php à déboger quand l'ide ne peut pas le faire :

1. Définir un serveur php sur votre phpstorm en utilisant le _path mapping_ et noter son nom.
2. Ajouter des variables d'environnement dans la commande shell qui lance votre script : `XDEBUG_MODE=debug XDEBUG_SESSION=1 XDEBUG_CONFIG="client_host=172.17.0.1 client_port=9003" PHP_IDE_CONFIG="serverName=lePetitNomDeMonServerDansPhpstorm" php /app/hello.php`

## Pour aller plus loin

Je continue de dockerisé complètement mon environnement de travail. Il faudra voir pour ce qui concerne les pages web maintenant, ça viendra quand j'en aurais besoin.  
A ce moment, je serais peut-être amené à revoir ma config.


