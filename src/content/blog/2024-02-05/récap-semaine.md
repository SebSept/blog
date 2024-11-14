---
title: "Récap Semaine"
pubDatetime: 2024-02-05
draft: true
tags: ["java", "symfony", "architecture"]
slug: "recap-semaine-5"
description: "Java toujours, examen test 'en cours de formation', un peu de sécurité."
---

Java toujours, examen test "en cours de formation", un peu de sécurité.

<!--more-->

## Java

J'ai surtout fait de java cette semaine, j'ai beaucoup de cours sur le sujet, mais ça il faut dire que c'est plus un prétexte qu'une fin en soi.

### Mise en place de projets Java

Ce n'est pas très simple tout ça ! Je manque de pratique. Il y a une chose qui ne simplifie pas le travail, c'est qu'on a plusieurs gestionnaires de packages, Maven et Gradle au moins. Ces gestionnaires ont leurs propres fichiers de configuration pour rien arranger. _IntelliJ IDEA_ a aussi son gestionnaire de package. On a aussi des types de projets variés, un framework comme Spring s'utilise en ajoutant un type de projet et à sa création, on va ajouter des dépendances au framework. On peut aussi avoir des plugins comme Lombok qui modifie le code juste avant la compilation, on a des nouvelles annotations disponibles. Je n'y vois pas du tout clair dans tout ça. Je vais éviter d'aborder le sujet des langages en surcouche de Java (Kotlin et Scala) pour pas en remettre une couche.
En php, on peut être fière d'avoir Composer qui fait un super boulot et qui s'est imposé comme l'unique gestionnaire de paquets.  
Pour arranger les choses les erreurs données par Java ne sont pas très explicites, on n'est pas au niveau de yarn, node, npm et la bande, mais ce n'est pas très glorieux.

### Erreurs en Java

Dans le cours sur les dates, j'ai eu une très bonne impression (de beaux objets, au roles et aux méthodes bien clairs), mais dans la pratique ça se gate.

Avec ce petit bout de code :

```java
String date = "Jeudi 1 Février";
DateTimeFormatter dateFormater = new DateTimeFormatterBuilder()
                .parseCaseInsensitive()
                .appendPattern("EEEE d MMMM")
                .toFormatter(Locale.FRENCH);
this.date = LocalDate.parse(date, dateFormater);
```

On génère cette erreur : `Exception in thread "main" java.time.format.DateTimeParseException: Text 'jeudi 1 février' could not be parsed: Unable to obtain LocalDate from TemporalAccessor: {DayOfMonth=1, DayOfWeek=4, MonthOfYear=2},ISO of type java.time.format.Parsed`  
On voit qu'il y a un effort pour nous informer, mais ça reste très vague, pourquoi est-ce que parsing à échouer ? j'ai vérifié le format, l'entrée, généré une date à partir du format...  
En fait, il manque l'année pour que la date soit reconnue. L'erreur affiche tous les champs qui sont corrects, pas celui qui pose un problème, il faut le deviner, être familier avec l'objet.  
Avec Symfony, on a des messages d'erreurs qui ne sont pas juste des détails factuels sur le problème, on a très souvent des explications et même souvent directement des suggestions des solutions (c'est vraiment une superbe _Developper eXperience_). En java, il me semble qu'il y a du taf.

```java
String date = "Jeudi 1 Février" et
DateTimeFormatter dateFormater = new DateTimeFormatterBuilder()
                .parseCaseInsensitive()
                .appendPattern("EEEE d MMMM")
                .toFormatter(Locale.FRENCH);

Le code _correct_ c'est
```

DateTimeFormatter dateFormater = new DateTimeFormatterBuilder()
.parseCaseInsensitive()
.appendPattern("EEEE d MMMM y") // ajoute du y
.toFormatter(Locale.FRENCH);
this.date = LocalDate.parse(date + " 2024", dateFormater); // ajout du 2024.

Autrement dit l'erreur, c'est que la date ne pas être _parsé_, car elle est incomplète (elle ne contient pas d'année). Pas évident à déchiffrer !. On est bien loin des messages d'erreur de Symfony qui sont souvent tout simplement des solutions directes :/

### Java pur

#### Les collections

C'est assez facile, je connais les structures de données en php (tableau, Collections Doctrine, Laravel, [php-ds](https://www.php.net/ds)).
Ce qui est intéressant et nouveau, c'est la possibilité de typer des variables sur des interfaces au niveau des instructions. On peut écrire `List<String> list2 = new ArrayList<>();`, _List_ est une interface pas une classe concrète. On ne peut pas faire ça en php puisqu'on n'en peut pas typer des variables dans des _statement_ (on peut typer des arguments ou le retour de méthode, des propriétés de class, mais pas directement des variables).

#### @Override

`@Override` est une annotation qui sert à indiquer qu'une fonction en surcharge une autre. Ça n'a aucun effet sur le fonctionnement du programme. Il me semble que ça peut être utilisé par des outils d'analyse du code, mais c'est surtout destiné au développeur pour mettre en valeur la surcharge justement. Ça n'a donc qu'une visée informative pour le lecteur du code. J'étais sceptique sur cette utilité. À la lecture de quelques morceaux de code, je trouve ça pratique. On n'a pas l'habitude de voir ça en php, mais ça pourrait être une bonne idée, je testerai à l'occasion...

## Symfony

Coté Symfony, j'ai revu les bases des form, je connaissais déjà, c'est utilisé dans PrestaShop en admin (avec des couches de complexité en plus) et j'ai fait un module qui utilisait ce composant de façon assez poussée.
