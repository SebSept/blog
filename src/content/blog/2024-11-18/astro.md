---
title: "Migration du moteur de ce blog"
description: "Passage de Hugo à Astro"
pubDatetime: 2024-11-18
draft: true
tags: [blog, astro, hugo]
slug: "migration-hugo-astro"
---

Je me forme actuellement aux technologies JavaScript _front end_. Et mon blog ne me convenait plus vraiment, le process de création de contenu ne me satisfaisait pas. Pour faire d'une pierre, deux coups j'ai migré ce blog de [Hugo](https://gohugo.io/) vers [Astro](https://astro.build/).  
Je suis satisfait de cette migration, j'ai maintenant un thème plus agréable, un rendu plus performant, je peux facilement le modifier et ça m'a permis de mettre en action quelques nouvelles compétences en JavaScript / ReactJs.

## Les limites d'Hugo

### La documentation

Rédiger une documentation de qualité est une tâche ardue, il faut être simple sans être réducteur, être complet sans être rébarbatif.  Pour un projet public, il faut répondre à des besoins relativement différents, c'est un challenge supplémentaire.  
Pour hugo, le _get started_ est trop minimaliste à mon goût et la documentation détaillée rentre dans les détails dès le début, mais beaucoup de questions restent cependant ouvertes.   
Comme j'ai une connaissance très superficielle du langage Go et du code de Hugo, il m'est difficile d'y faire des modifications. 

### La syntaxe des templates

J'aime bien le code expressif, qu'on peut lire en langage naturel, j'essaie le code de cette façon le plus possible.  
Le moteur de template d'Hugo est ([text/template](https://pkg.go.dev/text/template)).  Pour distinguer deux types de post dans les listings j'ai du modifier un template, le code produit était le suivant.

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

J'ai ajouté la ligne `{{- if eq .Type "post" -}} [Article] {{- end -}}`.  
La place de l'opérateur `eq` m'a heurté. C'est assez désagréable à lire de prime abord. On conditionne l'affichage de `[Article]` au type de post. Avec [Twig](https://twig.symfony.com/doc/3.x/templates.html#test-operator), on aurait écrit `{% if type is "post" %}`. C'est bien plus élégant. Ça peut sembler un détail ,mais ça change vraiment l'écriture et surtout la lecture du code.  
Je n'aime pas réellement non plus l'absence de nommage de la variable contenant  le post qui fait l'objet d'une itération, on ajoute simplement un `.` qui fait office de variable locale dans l'itération.  

### Docker et taches

Les commandes pour lancer le serveur local et générer les fichiers ne sont pas très clairs non plus. C'est peut-être moi J'ai créé un _Makefile_ pour les retrouver facilement. Pour l'action de publication, j'avais ces lignes :

```makefile
publish:
	docker compose -f compose_build.yml up
	rsync --recursive --compress --delete public/ dev.seb7.fr:/var/www/seb7.fr/blog
	firefox https://blog.seb7.fr
```

Ça semble propre, on génère les contenus, on les pousse sur le serveur de production et on ouvre firefox pour vérifier. Mais, il y une référence à un fichier docker compose (réalisé par mes soins), qui fait référence un autre docker compose (de mes soins également) qui utilise un `Dockerfile` présent dans le code source. Ça n'est ni simple ni rapide initialement.  

## Passage à Astro

J'ai choisi Astro parce qu'il est en JavaScript, un langage que je maitrise bien, il joui d'une bonne réputation, la documentation est bien faite (à priori) et il répond à mes attentes (à savoir obtenir le site le plus leger possible).

### Docker natif 


