---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
tags: []
slug: "{{ .Name | urlize }}"
image: "{{ .File.Filename }}/ogimage.png
---

Résumé

<!--more-->

Dans le post uniquement

[la description](url)

## 
