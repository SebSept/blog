---
title: "Test de Hugo à nouveau"
pubDatetime: 2022-03-18
draft: false
tags: ["blog", "hugo", "Go"]
slug: "test-de-hugo-à-nouveau"
description: "remarques sur Hugo"
---

Deux petites remarques sur Hugo.

<!--more-->

## Prise en main pas si simple

J'ai choisi [Hugo](https://gohugo.io/) pour sa simplicité, mais je trouve que je mets trop de temps pour obtenir ce que je veux.  
C'est peut-être, le temps de prise en main...
Ou c'est peut-être la doc qui est mal faite...

Actuellement, j'ai quelques bases, j'ai pris l'option de regarder le code des templates du thème en premier, puis je complète avec la doc au besoin. C'est plus productif que d'entamer par la doc.
On verra à l'usage, même si je n'ai pas l'intention de beaucoup _jouer_ avec.

## Des templates pas jolis

La syntaxe des templates ([text/template](https://pkg.go.dev/text/template)) ne me plait pas beaucoup non plus.  
Par exemple, pour écrire une condition, on a `{{- if eq .Type "post" -}} [Article] {{- end -}}`, ça n'est pas expressif comme syntaxe, ça ne se lit pas comme du langage naturel. Je préfère nettement une syntaxe à la [twig](https://twig.symfony.com/doc/3.x/templates.html#test-operator) `{% if type is "post" %}`.  
C'est peut-être pour être cohérent avec la syntaxe du [langage Go](https://go.dev/), dans ce cas, ça à du sens. Ça n'en reste pas moins repoussant.

Je changerai peut-être d'avis plus tard, si je décide de me plonger dans Go.  
À l'heure actuelle, je n'ai aucune envie de le faire, c'est en contradiction avec ma quête de beauté et d'expressivité du code.

---

Malgré ça, Hugo fait bien son job et une fois en place, c'est très pratique, je vais le garder pour ce blog.  
J'aurais l'occasion de faire un article détaillé dessus dans quelque temps.

> Note : Actuellement, le blog n'est plus propulsé par Hugo mais par [Astro](https://astro.build).
