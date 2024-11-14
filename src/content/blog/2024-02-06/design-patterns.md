---
title: "Design Patterns"
pubDatetime: 2024-02-06
draft: true
tags: ["php"]
slug: "design-patterns"
description: "Note sur mon appréhension des design patterns."
---

Note sur mon appréhension des _design patterns_.

<!--more-->

## Bagage

Avec mon expérience, je connais forçément les design pattern de base. Comme pour le reste de la formation, elle m'apporte une vision avec du recul et de la théorie. C'est intéressant, je comprends mieux le pourquoi et le comment de quelques design pattern, je peux prendre le temps de les interogger, d'en voir les limites, les cas d'utilisation.

## Quelques patterns

J'ai vu le _singleton_, facile à comprendre et à mettre en place, venant de PrestaShop, c'est un pattern familierutiliser pour les requêtes à la base de données. Le principe est de n'avoir qu'une unique instance d'une classe.

J'ai vu aussi les patterns _adapter_, _bridge_, _observer_, et _strategy_. C'est relativement simple, mais je ne les ai jamais vraiment mis en place moi-même à partir de rien.

## Abstract Factory

Le pattern de création _Factory_, je croyais, à tort, utiliser et connaitre ce pattern. Mon utilisation n'était pas basée sur une fabrique unique chargée de renvoyer l'objet adéquate. Bien que pratique, ça ne correspond au design pattern théorique qui s'appuie sur :

1. une interface de factory, implémentée par plusieurs factory, une factory n'étant capable de ne renvoyer qu'une seule instance concrête.
2. Une interface pour l'objet créé.  
   Si on prend l'exemple d'une Usine qui

## Conclusion

J'en retiens surtout qu'il ne faut pas penser qu'on croit connaitre un pattern sans en creuser la théorie. On a pu en voir des implémentations partielle, customisée en croyant avoir affaire à du standard. Ce n'est souvent pas le cas dans PrestaShop. Je serais donc très méfiant sur ce point.
C'est intéressant et pas très compliqué, pour ce que j'ai vu.
C'est un point que je pourrai creuser plus tard.
Dans le post uniquement
