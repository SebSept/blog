---
title: "Récap Semaine"
date: 2024-02-05T08:55:51Z
draft: false
tags: ["java", "symfony", "architecture"]
slug: "recap-semaine-5"
---

Java toujours, examen test "en cours de formation", un peu de sécurité.

<!--more-->

## Java

J'ai surtout fait de java cette semaine, j'ai beaucoup de cours sur le sujet, mais ça il faut dire que c'est plus un pretexte qu'une fin en soit.

### Design Pattern

Je connais forçément les design pattern de base. Comme pour le reste de la formation, elle m'apporte une vision avec du recul et de la théorie. C'est interessant, je saisie mieux le pourquoi et le comment de quelques design pattern, je peux prendre le temps de les interogger, d'en voir les limites, les cas d'utilisation.  
Le singleton, facile à comprendre et à mettre en place, venant de PrestaShop, c'est un pattern familier.  Le pattern de création _Factory_, je croyais utiliser et connaitre ce pattern mais je me suis aperçu que non, mon utilisation n'était pas basée sur une fabrique unique chargée de renvoyée l'objet adéquate. Bien que pratique, ça ne correspond au design pattern théorique qui s'appuie sur une interface de factory implémentée par plusieurs factory, une factory n'étant capable de ne renvoyer qu'un seul type de création.
J'ai vu aussi les pattern _adapteur_, _bridge_, _observer_, et _strategy_. C'est relativement simple mais je ne les jamais vraiment mis en place moi même à partir de rien.  J'en retiens surtout qu'il ne pas penser qu'on croit connaitre un pattern sans en creuser la théorie. On a pu en voir des implémentations partielle, customisée en croyant avoir à faire à du standard. C'est souvent pas le cas dans PrestaShop. Je serais donc très méfiant sur ce point.  
C'est intéressant et pas très compliqué, pour ce que j'ai vu.  
C'est un point que je pourrai creuser plus tard.

### Mise en place de projets Java

C'est pas très simple tout ça! Je manque de pratique. Il y a une chose qui ne simplifie pas le travail c'est qu'on a plusieurs gestionnaire de packages, Maven et Gradle au moins. Ces gestionnaires ont leur propres fichiers de configuration pour rien arranger. IntelliJ IDEA à aussi son gestionnaire de package. On a aussi des types de projets variées, un framework comme Spring s'utilise en ajoutant un type de projet et à sa création, on va ajouter des dépendances au framework. On peut aussi avoir des plugins comme Lombok qui modifie le code juste avant la compilation, on a des nouvelles annotation disponibles. Je n'y vois pas du tout clair dans tout ça.  Je vais éviter d'aborder le sujet des langages en surcouche de Java (Kotlin et Scala) pour pas en remettre une couche.
En php, on peut être fière d'avoir Composer qui fait un super boulot et qui s'est imposé comme l'unique gestionnaire de paquets.  
Pour arranger les choses les erreurs données par Java sont pas très explicites, on est pas au niveau de yarn, node, npm et la bande mais c'est pas très glorieux.

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
On voit qu'il y a un effort pour nous informer mais ça reste très vague, pourquoi est-ce que parsing à échouer ? j'ai vérifier le format, l'entrée, généré une date a partir du format...  
En fait, il manque l'année pour que la date soit reconnue. L'erreur affiche tous les champs qui sont correctes, pas celui qui pose problème, il faut le deviner, être familier avec l'objet.  
Avec Symfony, on a des messages d'erreurs qui ne sont pas juste des détails factuels sur le problème, on tros souvent des explications et même souvent directement des suggestions des solutions (c'est vraiment une superbe Developper eXperience). En java, il me semble qu'il y a du taf.



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

Autrement dit l'erreur c'est que la date ne pas être parsé car elle est incomplète (elle ne contient pas d'année). Pas évident à déchiffrer !. On est bien loin des messages d'erreur de Symfony qui sont souvent tout simplement des solutions directe :/

### Java pur

#### Les collections

C'est assez facile, je connais les structures de données en php (tableau, Collections Doctrine, Laravel, [php-ds](https://www.php.net/ds)).
Ce qui est intéressant et nouveau, c'est la possibilité de typer des variables sur des interfaces au niveau des instructions. On peut écrire `List<String> list2 = new ArrayList<>();`, _List_ est une interface paus une classe concrète. On ne peut pas faire ça en php puisqu'on en peut pas typer des variables dans des i_statement_ (on peut typer des arguments ou des retour de méthode, des propriétés de class, mais pas directement des variables).

#### @Override

`@Override` est une annotation qui sert à indiquer qu'une fonction en surcharge une autre. Ça n'a aucun effet sur le fonctionnement du programme. Il me semble que ça peut-être utilisé par des outils d'analyse du code mais c'est surtout destiné au développeurs pour mettre en valeur la surcharge justement. Ça n'a donc qu'une visée informative pour le lecteur du code. J'étais sceptique sur cette utilité. À la lecture de quelques morceaux de code, je trouve ça pratique. On a pas l'habitude de voir ça en php, mais ça pourrait être une bonne idée, je testerai à l'occasion...

## Symfony

Coté Symfony, j'ai revu les bases des form, je connaissais déjà, c'est utilisé dans PrestaShop en admin (avec des couches de compléxité en plus) et j'ai fais un module qui utilisait ce composant de façon assez poussée.

[la description](url)

## 
