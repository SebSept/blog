help:
	# git_push : pousser sur github, suivi de deploy normalement
	# deploy : pousser le repo github sur le site
	# publish : git_push + deploy
	# new : création d'un nouveau post
	# test : afficher le blog : lance le serveur local et ouvre firefox

git_push:
	#git push github master

deploy:
	#deployer deploy

new:
	@read -p "Titre du nouveau post : " title; hugo new "$$title"; vim "/home/http/perso/seb7.fr/blog/content/$$title"
	hugo

test:
	hugo serve 1> /dev/null &
	firefox http://localhost:1313/

stop_test:
	kill $$(pidof hugo)

generate:
	hugo
