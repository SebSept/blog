help:
	# Commandes
	# make serve : afficher le blog : lance le serveur local et ouvre firefox
	# make new_post : création d'un nouveau post (lancer docker avant : make serve)
	# make git_push : versionner, pousser sur github, suivi de publish normalement
	# make publish : rsync sur blog.seb7.fr

serve:
	docker compose -f compose_serve.yml up --detach
	firefox http://localhost:1313/

new_post:
	@read -p "Titre du nouveau post : " title;\
	DIR="post/"$$(date +"%Y-%m-%d");\
	SLUG=$$title;\
	SLUG=$$(echo "$$title" | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z); \
	FULL_PATH="$${DIR}/$${SLUG}.md";\
	docker exec -it blog_hugo hugo new "$$FULL_PATH"; \
	docker exec -it blog_hugo chown 1000:1000 -R "/home/app/content"

new_note:
	@read -p "Titre de la nouvelle note : " title;\
	DIR="note/"$$(date +"%Y-%m-%d");\
	SLUG=$$title;\
	SLUG=$$(echo "$$title" | sed -e 's/[^[:alnum:]]/-/g' | tr -s '-' | tr A-Z a-z); \
	FULL_PATH="$${DIR}/$${SLUG}.md";\
	docker exec -it blog_hugo hugo new "$$FULL_PATH"; \
	docker exec -it blog_hugo chown 1000:1000 -R "/home/app/content"

git_push:
	git add .
	git status
	@read -p "message du commit : " message;\
	git commit -m "$$message"
	#git push github master

publish:
	docker compose -f compose_build.yml
	rsync --recursive --compress --delete public/ dev.seb7.fr:/var/www/seb7.fr/blog
	firefox https://blog.seb7.fr

stop_serve:
	docker stop blog_hugo
