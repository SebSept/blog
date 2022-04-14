---
title: "Indicateur Debug Mode Prestashop dans le terminal."
date: 2022-04-12T18:25:38+02:00
draft: false 
tags: ["prestashop", "shell", "fop_console"]
slug: "indicateur-debug-mode-starship-shell-prestashop" 
---

Comment ajouter un indicateur à la ligne commande pour savoir si vous êtes en mode debug ou pas.

<!--more-->

[Starship](https://starship.rs) est un programme qui permet de customiser simplement le prompt de votre shell.  
Pour le dire autrement, ça permet de modifier le texte de l'_invit_ de commande dans un terminal.  

## Mon prompt

Ici vous pouvez voir mon prompt :

![Mon prompt personnalisé](/post/2022-04-12/prompt.webp "en mode debug")

Pour le détail : 
- _7.2_ : la version de php cli est cours
- _monsterquad_17_ : le dossier courant
- _dev_ : la branche git courante
- le cafard est vert : PrestaShop est en mode debug

Je passe beaucoup de temps avec phpstorm d'un côté et un terminal de l'autre. Je me pose très souvent la question "est-ce que ce site est actuellement en mode debug" ?  
Avec ce caractère "bug" vert, je sais que le mode debug est activé.  

Si bascule de mode \_PS\_MODE_DEV\_ à `false`, il devient rouge :

![Mon prompt personnalisé](/post/2022-04-12/prompt2.webp "en mode debug")

Et voilà.

## Pour l'obtenir

Il vous faut donc utiliser [Starship](https://starship.rs) et le configurer de cette façon (uniquement les parties intéressantes)

```toml
# ~/.config/starship.toml
format = """
 ${custom.ps_debug_mode} 
"""

[custom.ps_debug_mode]
command = 'grep -q "define.*PS_MODE_DEV.*true" config/defines.inc.php && echo 🪲 || echo 🐞'
when = """true"""
files = ["bin/console"]

```

1. On ajoute la variable `${custom.ps_debug_mode}` dans le prompt.  
2. La valeur de cette variable est déterminée dans la section `[custom.ps_debug_mode]` de cette façon :  
  * `command` détermine le contenu à insérer dans le prompt.
  * `files` permet de déterminer une condition pour exécuter la `command`.  
  * `when` détermine une condition supplémentaire pour l'exécution.

La commande pour déterminer le mode debug (dev mode) est assez rudimentaire et pas complètement fiable, mais très rapide à exécuter. En résumé on détermine si la constante `_PS_MODE_DEV_` est définie à  `true` ou pas.  
Alternativement, on peut passer par la commande `./bin/console fop:debug-mode status` de la [fop console](https://github.com/friends-of-presta/fop_console), c'est plus fiable, mais plus long (si les caches doctrine et symfony doivent être recréés) :

```toml
[custom.ps_debug_mode]
command = './bin/console fop:debug-mode status | tail -n1 | (grep disable -qv && echo 🪲) || echo 🐞'
when = """true"""
files = ["bin/console", "modules/fop_console/fop_console.php"]
```

Vous avez maintenant l'info du mode de dev de PrestaShop, en continu dans la console, un peu de temps de gagner Bon développement !

## Config complète

Pour info, ma config starship complète : 

```toml
# ~/.config/starship.toml
format = """
$virtualenv$python$php $directory $git_status $git_branch$git_state$git_commit ${custom.ps_debug_mode}$character
"""

command_timeout=250

[directory]
style = '81'
format = '[$read_only]($read_only_style)[$path]($style)'

[character]
#format = '$symbol '
success_symbol = "[❯](bold 117)"
error_symbol = "[✗](bold red)"

[cmd_duration]
# ne fonctionne pas, il faut un build avec le support des notifications
# show_notifications = true
# min_time_to_notify = 60_000

[git_branch]
always_show_remote = false
style = 'yellow'
format = '[$symbol $branch]($style)'
symbol = ''

[git_status]
style = '209'
format = '[$conflicted$stashed$deleted$renamed$modified$staged]($style)'
conflicted = '🔥'
modified = '✨'

[php]
format = '[$symbol($version)]($style)'
version_format = '${major}.${minor}'

# Prestashop debug mode
[custom.ps_debug_mode] # "custom"   obligé ?
command = 'grep -q "define.*PS_MODE_DEV.*true" config/defines.inc.php && echo 🪲 || echo 🐞'
# commande alternative : plus fiable mais plus longue
#command = './bin/console fop:debug-mode status | tail -n1 | (grep disable -qv && echo 🪲) || echo 🐞'

```