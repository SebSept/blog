---
title: "Hugo, c'est pas le délire."
pubDatetime: 2022-03-25
draft: true
tags: ["blog", "hugo", "Go"]
slug: "test" 
description: "Hugo, c'est pas le délire."
---

J'ai utilisé Hugo pour générer ce blog.

<!--more-->


## Hugo (pas) délire

Ce blog est généré avec [Hugo](https://gohugo.io/). C'est une bonne solution quand on l'a en main, quand on mis le blog en place. Avant ça, c'est un peu pénible. C'est tout à fait subjectif, comme tout ce qui suit.

### La documentation

Il y a beaucoup de documentation, mais elle rate souvent d'aller à l'essentiel, ça fait beaucoup de lecture pour trouver une information, quand je la trouve...
Écrire de la documentation, c'est compliqué, ça demande beaucoup d'énergie et le résultat n'est pas toujours à la hauteur.
Avec Hugo, on à un _get started_ vraiment (trop) sommaire puis une doc touffue et tout de suite chargée en termes techniques.


C'est peut-être le temps de prendre ce moteur de blog en main,  en main, mais 

Je note au passage, la syntaxe plutôt moche des templates.  
Ça n'est pas a imputer à Hugo, mais au moteur de template choisi ([text/template](https://pkg.go.dev/text/template)).  
Ici, j'ai ajouté le mot `[Article]` dans le listing de l'accueil :

J'ai ajouté cette ligne `{{- if eq .Type "post" -}} [Article] {{- end -}}`.  
La place de l'opérateur `eq` m'a heurté. C'est moche à lire de prime abort, pour moi qui tente de coder de façon expressive. C'est à dire que le code vise à pouvoir être lu et compris comme du langage naturel.  
`Si le type est "post"`, comme on le fait en [twig](https://twig.symfony.com/doc/3.x/templates.html#test-operator) par exemple `{% if type is "post" %}`
Naturellement, j'aurais tapé `{{- if .Type eq "post" -}} [Article] {{- end -}}


```twig
{{ define "main" }}
<!-- homepage range in all posts -->
{{ $paginator := .Paginate (where .Site.RegularPages "Type" "in" .Site.Params.mainSections) }}
{{ range $paginator.Pages }}
<div class="post">
    <h2 class="post-item post-title">
        {{- if eq .Type "post" -}} [Article] {{- end -}}
      <a href="{{ .Permalink }}">{{ .Title }}</a>
    </h2>
    <div class="post-item post-meta">
        {{ partial "post-meta.html" . }}
    </div>
    <div class="post-item post-summary markdown-body">
        {{ .Summary }}
    </div>
</div>
{{ end }}

{{- partial "pagination.html" (dict "context" . "pagi" $paginator) -}}

{{ end }}
```
