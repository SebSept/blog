---
title: "Sqlmap : Tester Les Injections Sql"
date: 2022-03-14T13:50:03+01:00
draft: false 
tags: [securité, sql, prestashop]
slug: sqlmap-tester-injections-sql-prestashop
---

Éprouvez la sécurité des modules PrestaShop avec Sqlmap.

<!--more-->

Sqlmap est un outil python en ligne de commande qui permet de tester la vulnérabilité d'un site aux injections sql.

## Un peu de contexte

Dans le cœur de PrestaShop et dans les modules développés par l'entreprise PrestaShop, il est très improbable d'en trouver. Le code est public, il y a de nombreux développeurs et un [bug bounty](https://yeswehack.com/programs/prestashop) est en place.

Dans les modules tiers, par contre, c'est tout à fait possible.  
C'est d'autant plus possible que certaines plateformes de vente ne sont pas très regardantes sur la qualité de ce qu'elles vendent. Notamment quand il s'agit de thème et que ces thèmes embarquent des modules.  Un intégrateur, graphiste, designer (comme vous voulez), peut penser savoir coder, alors qu'il est tranquillement posé au sommet de la montagne de la stupidité (en référence à [l'effet Dunning-Kruger](https://fr.wikipedia.org/wiki/Effet_Dunning-Kruger)).

Pour ma part, j'ai plusieurs fois découvert des vulnérabilités critiques dans les modules de mes clients et c'était souvent dans des modules embarqués par des thèmes.

## Les enjeux d'une injection sql

Pour restreindre le sujet aux injections sql, une faille de type injection sql permet d'avoir un accès complet aux données de la boutique PrestaShop (et plus encore).
Pour une définition un peu plus étoffée, vous pouvez lire [celle de wikipédia](https://fr.wikipedia.org/wiki/Injection_SQL).

Avec ces données, sans imagination, il est déjà possible de se livrer a une belle [campagne de fishing](https://fr.wikipedia.org/wiki/Hame%C3%A7onnage); revendre les données à un concurrent ; ou, en poussant encore un peu, on pourra tenter de déchiffrer les mots de passe des clients. Et je vous laisse imaginer ce qu'on peut en faire.

Il doit également être possible (ça je ne l'ai pas testé) d'injecter des données dans votre base de données. Des redirections, changer des clés d'api de paiement, des choses très sympathiques...

Bref, ça ne doit pas être pris à la légère.  Vous devriez toujours demander à votre développeur de vérifier le code des modules dont on peut douter de la qualité.  
Au besoin, je suis joignable.

## Sqlmap pour tester les injections

Sans outil dédié, il faut lire le code, c'est non seulement pénible, mais sujet à erreur.  Faire appel à outil spécialisé comme sqlmap n'est pas un luxe.  
[Sqlmap](https://sqlmap.org/) est disponible en open source, la documentation est bien faite et complète, en la lisant vous trouverez votre bonheur.

À partir de maintenant, ça va devenir un peu plus technique.  

L'installation est très simple, python et git sont prérequis.

```shell
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev
```

Pour tester l'outil, on va partir sur un bout de script appelé en POST, en ajax.  
Voici un petit bout de script php qui contient du code problématique.

```php
<?php
# modules/mon_module_pourri/ajax.php

require(dirname(__FILE__) . '/../../config/config.inc.php');
include(dirname(__FILE__) . '/../../init.php');

$sql = "select id_shop from ps_shop where id_shop=".$_POST['id_shop'];
Db::getInstance()->executeS($sql);

exit(0);
# vous remarquez l'absence d'affichage de données, ça n'est même pas nécessaire
```

Voici maintenant la commande qui exploite la vulnérabilité.

```shell
./sqlmap.py -u=http://localhost/prestashop/modules/mon_module_pourri/ajax.php \
  --data="id_product=1&current_page=1&current_option_filter=1&reviews_max_pages=1&id_shop=1"\
  --dbms mysql\
  # --batch\
  # --dump\
  # -D la_base\
  # -T ps_currency\
  # -p id_shop
  # --flush-session
```

- `-u`  : L'url problématique, il vous faudra peut-être utiliser la console de votre navigateur pour la trouver si c'est un appel ajax.  
C'est dans ce type de fichier, destiné aux requêtes ajax que le développeur amateur aura commit son méfait, le plus probablement. 
- `--data` : ce sont les paramètres passés en POST (en methode GET, pas besoin de spécifier ce paramètre.)
- `--dbms` : en spécifiant le type de base de données on évite certains tests inutiles
- `--batch` : avec ce paramètre, vous évitez les questions de sqlmap. Dans un premier temps, ne mettez pas ce paramètre, ça vous renseignera un peu sur ce que fait sqlmap et les possibilités offertes
- `--dump` : par défaut sqlmap va se contenter de chercher les failles, une fois trouvée, vous voudrez surement récupérer les données en utilisant ce paramètre.
- `-D` : permet de spécifier la base de données sur laquelle travailler, c'est utile si l'utilisateur sql infiltré à accès à plusieurs bases. Normalement vous ne connaissez pas le nom de cette base, mais sqlmap vous l'aura donné précédemment.
- `-T` : permet de spécifier la table a dumper, celle en example n'a aucun intérêt, mais elle très simple, pratique à tester.
- `-p` : permet de spécifier le paramètre sur lequel va jouer sqlmap, si vous ne spécifier pas ce paramètre, sqlmap va tenter sur tous les paramètres passés dans l'url ou l'option --data
- `--flush-session` : par défaut sqlmap stock les informations qu'il extrait pour les réutiliser dans les appels suivants. Si vous changez le code php, vous voudrez l'utiliser pour réinitialiser _l'attaque_.

Sqlmap va bombarder votre script pour chercher les failles. Vous ferez donc ça sur une machine de test et pas sur un site vraiment hébergé en ligne.  

## Pour conclure

Sqlmap offre d'autres possibilités, notamment, il peut prendre en compte les tokens visant sécuriser les requêtes, ou encore utiliser des entêtes personnalisés, gérer les cookies, mettre des délais entre les requêtes, tenter de déchiffrer le hash des mots de passes, ...

Je crois qu'on a là un bon outil à lancer pendant les pauses café pour tester les modules douteux à moindre effort.
Ça sera moins pénible et plus fiable que la lecture de code pour débusquer les vulnérabilités aux injections sql.

Si vous avez besoin que je mène ce genre de prestation pour vous, c'est possible, [j'ai un email](mailto:contact@seb7.fr).

### Pour aller un peu plus loin

Ça n'est pas très méchant à faire, mais ça serait sympa de coder un petit script qui va lire les logs du serveur, extraire les urls potentiellement à risque et lancer des commandes sqlmap adéquates...  
Si vous connaissez un tel outil, n'hésitez pas à m'en faire par, sur [twitter](https://twitter.com/seb_sept) par exemple.  

> PS : n'oubliez pas de mettre une capuche avant le lancer sqlmap.

