help:
	# git_push : pousser sur github, suivi de deploy normalement
	# publish : rsync sur dev.seb7.fr
	# new : création d'un nouveau post
	# test : afficher le blog : lance le serveur local et ouvre firefox

git_push:
	#git push github master

publish:
	hugo
	rsync -rz public/ dev.seb7.fr:/var/www/seb7.fr/blog

#publish: git_push deploy

new:
	@read -p "Titre du nouveau post : " title; hugo new "$$title"; vim "/home/http/perso/seb7.fr/blog/content/$$title"
	hugo

test:
	hugo serve 1> /dev/null &
	firefox http://localhost:1313/ &
	hugo --watch

stop_test:
	killall hugo

generate:
	hugo
