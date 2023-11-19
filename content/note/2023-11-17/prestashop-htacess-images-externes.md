---
title: "Eviter la copie des images PrestaShop"
date: 2023-11-17T14:02:30Z
draft: false
tags: [prestashop, apache]
slug: "prestashop-htaccess-images-externes" 
---

Juste une petite astuce rapide pour éviter de copier les images produit du PrestaShop de prod au PrestaShop de test/dev. 

<!--more-->

## Une copie de PrestaShop

Si vous possédez une copie d'une boutique PrestaShop, vous aurez besoin des fichiers images pour un affichage correct. Cependant, la duplication des images de produit peut prendre du temps et occuper beaucoup d'espace disque. Je vous livre une astuce pour éviter cette duplication.


## Afficher les images du site de prod

### Pas de lien symbolique

Au lieu de copier les fichiers, nous pourrions utiliser un lien symbolique entre le dossier des images de la copie et le site de production. Mais en intervenant dans l'admin de la copie, on interviendrait en fait sur les images du site de production sans forçément le savoir. On veut bien sur éviter ce risque !

### .htaccess à la rescousse

Mon idée est de modifier le fichier `.htaccess` afin que les images affichées sur la copie soient celles du site de production.

Le fichier .htaccess de PrestaShop contient ces lignes qui gèrent la réécriture d'url des images (je ne mets qu'une ligne pour l'exemple, il y en a d'autres) :

```apacheconf
RewriteRule . - [E=REWRITEBASE:/]

RewriteCond %{HTTP_HOST} ^lesite.com$
RewriteRule ^([0-9])(\-[_a-zA-Z0-9-]*)?(-[0-9]+)?/.+\.jpg$ %{ENV:REWRITEBASE}img/p/$1/$1$2$3.jpg [L]
```

L'idée est d'ajouter une variable qui référence l'URL du site de production et de remplacer les `%{ENV:REWRITEBASE}` par cette variable.
On obtient alors ceci :
```apacheconf
# déclaration de l'url de prod dans la variable REWRITEPROD
RewriteRule . - [E=REWRITEPROD:https://www.le-site-en-prod.fr/]

# La règle de réécriture modifiée
RewriteCond %{HTTP_HOST} ^le-site-de-dev.fr$
RewriteRule ^([0-9])(\-[_a-zA-Z0-9-]*)?(-[0-9]+)?/.+\.jpg$ {ENV:REWRITEPROD}img/p/$1/$1$2$3.jpg [L]
```

Un petit rechercher/remplacer pour tout ce qui concerne les images et on est bon.  
On affiche les images de prod sur le site de dev. C'est pas plus compliqué que ça.

## Limites

- Dans le backoffice : Comme les images ne sont pas présentes sur l'instance, il ne sera pas possible de leur d'apporter des modifications.
- Limitations Apache/Serveur : J'imagine qu'il est possible que certaines configurations d'Apache ou de serveur ne permettent pas l'utilisation d'images d'une autre hôte/URL.
- Volatilité : Dans cet exemple, j'ai écrit directement dans le bloc généré par PrestaShop, les modifications seront perdues lors de la prochaine régénération du fichier .htaccess.

## Perspectives 

Si on a besoin que d'afficher les images coté front, cette solution est très bonne. Concernant le problème d'écrasement des règles par la génénation automatique du .htaccess, des solutions peuvent être envisagées facilement.  
Par exemple copier les nouvelles règles en dehors du bloc de PrestaShop afin que les règles d'origine soient ignorées et nous instructions conservées. Cela doit être réalisable, bien que je n'aie pas effectué de tests.  
Si vous disposez d'une solution concrète et testée, n'hésitez pas à me la faire savoir.