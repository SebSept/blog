---
title: "Recap de cours n°6"
date: 2024-01-26T14:19:05Z
draft: false
tags: ["java", "projet", "symfony", "php"]
slug: "recap-semaine-4"
---

Semaine assez dense avec l'ouverture sur un stage et un examen.

<!--more-->

## Java

Toujours dans le cadre du bloc _réalisation d'une interface de type desktop_, j'ai continué les cours Java, on entame les choses un peu plus sérieuses.  
J'ai vu le polymorphisme (d'héritage et d'interface) et la surcharge de méthode. La surcharge n'existe pas en php en dehors de l'héritage, c'est la possibilité d'avoir 2 méthodes de même nom dans la même classe mais avec des types d'arguments différent (j'avais déjà vu ce concept en c++, de mémoire). C'est intéressant mais j'ai rarement (jamais?) ressenti le besoin de ce type de construction en php.  
On à le mot clé `final` qui est l'équivalent de `readonly` sur une propriété en php. En php on a le mot `final` sur une méthode ou une classe qui n'a pas du tout le même effet (il empêche la surcharge par héritage). Ça va me demander un peu de gymanstique mental en perspective.  
On a des `enums` comme en php, ça m'a incité a lire la documentation complète de php sur le sujet. J'ai appris qu'il existe deux types d'enum ([`backed`](https://www.php.net/manual/en/language.enumerations.backed.php) et `pure`), j'en ai profité pour revoir le code de mon implémentation du jeu de poker dans lequel j'utilise des enums. A l'heure où j'écris, j'ai un peu oublié les caractéristiques des enum en java, il faudra que je pratique pour que ça rentre. Ça tombe bien, j'ai pour projet de developper une appli android (et j'ai surement ça dans mes cours à venir).

## Symfony

J'ai entamé les cours Symfony, c'est assez léger et un peu daté pour le moment. Les cours demandent d'avoir déjà une connaissance du framework déjà bien établie. Les docs de Symfony sont vraiment bien faites, le cours sur [Webpack Encore](https://symfony.com/doc/current/frontend/encore/index.html) ne m'a pas appris grand chose. Par contre j'en ai profité pour ajouter ça à mon [starter php](https://github.com/SebSept/php-starter). Et j'ai surtout découvert qu'on a maintenant une solution plus simple et (presque) aussi riche, l'[Asset mapper](https://symfony.com/doc/current/frontend.html#assetmapper-recommended). J'ai prévu de creuser ça. Je me prend maintenant du temps pour creuser ce que j'apprend/redécouvre de Symfony. J'ai fais une introduction sur les fixture doctrine dans Symfony, j'en ai profité pour ajouté postgresql dans le Docker de mon starter. Quel plaisir d'ajouter un service du premier coup, sans problème de config :) 

## Sécurité 

2 cours sur la sécurité, ce sont des cours avec des principes et des introductions, pas d'exploitation concrètes pour le moment.  Je suis déjà bien sensibilité et aggueri à la sécurité (c'est l'expérience qui parle), je n'ai rien appris et c'est une bonne chose.

## Projet : analyse des risques et élaboration du besoin

L'analyse des risques dans un projet est un sujet intéressant, j'ai appris beaucoup de choses, ça n'est pas trivial. Dans la gestion de projet, j'ai l'impression que ça repose sur beaucoup de cadres, de rationnadité, de méthodes, mais qu'au final, l'expérience personnelle est ce qui va faire la différence dans la conduite.  
Le cours sur l'élaboration du besoin, bien qu'instructif, m'a moins enthousiasmé, peut-être a cause de sa structure pas optimale.

## Examen, stage, emploi et self branding

Dans cette formation ([bachelor developpeur symfony](https://www.studi.com/fr/formation/developpement/bachelor-developpeur-phpsymfony)), on a beaucoup de choses à faire, une masse importante de cours, un examen en cours de formation, des entrainements à a cet examen, la réalisation d'un dossier professionnel, optionnellement la réalisation d'un stage, la passation d'examen internes (diplome studi) et la passation d'un examen final qui complète le dossier professionnel pour l'acquisition du [titre profesionnel](https://www.francecompetences.fr/recherche/rncp/37873/).  
Ça demande une organisation pour ne pas se retrouver débordé et être angoissé. J'ai un beau diagramme de Gant qui contient tout, et des documents qui résument les attendus, les dead lines, etc.
J'ai décidé que j'allais faire un stage, pour l'expérience, pour mettre un pied chez un evéntuel futur employeur, pour améliorier mon employabilité, pour que mon dossier professionnel soient de meilleure qualité.

Dans l'optique de ma recherche d'emploi, j'ai entamé une mise en valeur de mes compétences, expériences, qualités et savoir être. J'en suis à l'étape de conception. C'est intéressant de rationnaliser cette recherche en anticipation, c'est une façon d'appliquer des framework de pensées, des méthodes de gestion de projet.
Concrètement, j'ai maintenant un compte sur le Mastodon des dev php -> [phpc.social/@sebastienmonterisi](https://phpc.social/@sebastienmonterisi).

