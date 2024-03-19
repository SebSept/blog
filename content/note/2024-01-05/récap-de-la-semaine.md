---
title: "Récap De La Semaine n°3"
date: 2024-01-05T16:04:06Z
draft: false
tags: ["figma", "css", "design"]
slug: "recap-de-la-semaine"
image: "/home/app/content/note/2024-01-05/récap-de-la-semaine.md/ogimage.png"
---

Récap de cette semaine de reprise, axée design.

<!--more-->

# Coté php

De ce coté, je passe les cours de base sur la programmation orientée objet. J'ai du apprendre 2,3 détails, rien de plus.  
Il y a des cours _recommandés_ par opposition à _indispensable_. Pour les domaines qu'on maitrise bien, on peut effectivement facilement s'épargner ses cours.  
Pour ma part, je les fais quand même, rapidement, ça prend ainsi même pas la moitié de temps indiqué (20,25 minutes pour une leçon d'une heure).  
Par contre pour les domaines qu'on ne maîtrise pas, c'est très bien, tres instructif. Je pense à tout ce qui concerne la création de maquettes, mockup, etc.

# Coté design

Le gros de mes cours cette semaine a porté sur ce sujet.

## Adobe XD

C'est un bon outil, bien fait qui encourage aux bonnes pratiques et agréable. Avec les raccourcis, je présume qu'on devient rapidement très productif.
Le gros point noir de ce soft, c'est qu'il faut payer presque 70€ par mois pour l'utiliser. C'est lié au fait qu'il est dans la suite Adobe Creative, qui comprend beaucoup de chose dont je n'ai pas besoin.
J'ai donc profité de quelques jours gratuits et j'ai déjà résilié mon abonnement pour ne pas payer.

## Figma

Figma, j'ai déjà pu survoler ce logiciel lors de la présentation de maquette qu'on devait intégrer. N'étant pas non plus en charge de l'intégration, je n'avais eu qu'un rôle passif.  
Cette fois, j'ai commencé à devenir créateur. C'est un soft intéressant, pratique, qui reprend quelques concept vus dans Adobe XD.  
Mes cours ne sont pas terminés sur ce sujet mais j'ai déjà appris beaucoup de choses.  
À l'instar d'Adobe XD, on a une version gratuite illimité dans le temps. Les limitations sont en terme quantitatif, un seul projet avec seulement 3 documents et fonctionnelles (mais très peu à priori).
ça reste très bien pour découvrir le soft et une utilisation occasionnelle, non professionnelle.
En ce qui concerne l'agencement des éléments, ça incite clairement a utiliser flexbox comme modèle de mise en page.

## Aussi

J'ai tout juste entamé le bloc _designer une interface desktop_, je vois qu'avant de rentrer dans le dur, il y a du contenu sur la création de projet, l'élaboration de la demande, etc, c'est très bien de voir ces choses du point de vu producteur, je n'ai souvent été que consommateur de la gestion de projet.

## Et Tailwindcss

[Tailwindcss](https://tailwindcss.com/) est un framework css qui n'est pas tout jeune, qui continue prendre de la popularité (il me semble). J'ai décidé de m'y interessé. Mon avis était que c'est vraiment moche etrepoussant. L'idée c'est de ne quasiment plus écrire de css et mettre un paquet, un gros paquet de _class_ sur les éléments html. Il en résult un code html très chargé, c'est ce qui m'a repoussé, je ne suis pas le seul. Ce point est parfaitement assumé par le créateur.

> “Best practices” don’t actually work.
> I’ve written a few thousand words on why traditional “semantic class names” are the reason CSS is hard to maintain, but the truth is you’re never going to believe me until you actually try it. If you can suppress the urge to retch long enough to give it a chance, I really think you’ll wonder how you ever worked with CSS any other way.

Et c'est le prix a payer pour tous les autres avantages (pas de css a écrire, code parfaitement maintenable, rendu unique). Actuellement, je pense que c'est une bonne approche, j'ai changé mon fusil d'épaule. J'ai déjà joué avec, il faut tout de même apprendre un peu le framework mais ça vient vite, la courbe d'apprentissage ne semble pas trop décourageante. J'ai préfu de refaire le style de ce blog avec, on verra.

L'utilisation via nodejs est assez simple (j'ai fais une install via [docker](https://blog.seb7.fr/tags/docker/), normal). Le nombre de classes css possible est gigantesque. Le principe c'est que la compilation en nodejs va lire les fichiers html, js de notre projet et créer les classes css en conséquence. Cette approche est très originale et novatrice (non?), ça vallait le coup d'être signalé.

## Poker domain

Sur mon temps libre toujours, j'ai commencé a codé en php la représentation d'un jeu de poker. Je connais bien le sujet. Mon but est de coté purement le _domain_ le plus proprement possible, c'est intéressant, j'aime vraiment bien cette partie _domain_, représentation en code du réél. Je publierai ce code plus tard, très probablement.
