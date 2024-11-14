---
title: "Erreurs en Java"
pubDatetime: 2024-02-05
draft: false
tags: ["Java", "Symfony"]
slug: "erreurs-en-java"
description: "Les messages d'erreur en Java ne sont pas très 'developper friendly'."
---

Les messages d'erreur en Java ne sont pas très _developper friendly_.

<!--more-->

**Disclaimer** : Mon expérience en Java est très limitée, je tire une conclusion à partir de très peu de choses et je peux me tromper.

## Erreurs de code Java

Dans mon cours sur les dates, j'ai eu une très bonne impression, on a de beaux objets, aux roles et aux méthodes bien claires. Mais dans la pratique, j'ai buté sur un problème trop longtemps.

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
On voit qu'il y a un effort pour nous informer, mais ça reste très vague : pourquoi est-ce que parsing à échouer ? On ne le sait pas. J'ai vérifié le format, l'entrée, leur cohérence puis généré une date à partir du format pour enfin comprendre.
En fait, il manque l'année pour que la date soit reconnue. L'erreur affiche tous les champs qui sont corrects, pas celui qui pose un problème, il faut le deviner, être familier avec l'objet. On n'a pas le problème, on a des éléments pour aller le trouver nous même. Quand on n'est pas familier de ces objets, ça n'est pas évident.

Avec Symfony, on a des messages d'erreurs qui ne sont pas juste des détails factuels sur le problème, on trouve souvent des explications et directement des suggestions des solutions. C'est vraiment une superbe Developper eXperience car les messages nous aident directement à résoudre le problème, sans même consulter une doc ou faire une recherche.

En java, il me semble qu'il y a du taf pour avoir des messages d'erreur qui aident à résoudre les problèmes.

---

Et si vous êtes curieux, le code qui fonctionne :

```Java
    String date = "Jeudi 1 Février";
    DateTimeFormatter dateFormater = new DateTimeFormatterBuilder()
                .parseCaseInsensitive()
                .appendPattern("EEEE d MMMM y")
                .toFormatter(Locale.FRENCH);
    this.date = LocalDate.parse(date + " 2024", dateFormater);
```

## Erreurs de projet Java

Je n'ai pas eu que ce problème de code, j'ai eu aussi des problèmes de dépendances non reconnues. J'ai finalement complètement abandonné l'idée de résoudre le problème dans IntelliJ, j'ai changé d'IDE et suis passé à Eclipse pour gérer correctement un projet Spring. C'était le plus efficace, et pourtant Eclipse n'était pas encore installé sur ma machine.

Là, j'ai renoncé, abandonné et passer sur environnement fonctionnel était la meilleure option du moment. J'aurais perdu du temps inutilement.

Java n'en reste pas moins un langage que j'apprécie, je pense pouvoir y trouver une bonne source de satisfaction, car le langage est fait pour être clair, on devine qu'il a été bien réfléchi...
