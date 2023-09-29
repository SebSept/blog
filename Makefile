help:
	# make new : création d'un nouveau post
	# make test : afficher le blog : lance le serveur local et ouvre firefox
	# make generate : genaration des fichiers (pour éviter prob de versionning)
	# make git_push : versionner, pousser sur github, suivi de publish normalement
	# make publish : rsync sur blog.seb7.fr

debug:
	echo message : $$message

git_push:
	git add .
	@read -p "message du commit : " message;\
	git commit -m "$$message"
	#git push github master

publish:
	rm -rf public/*
	hugo
	rsync --recursive --compress --delete public/ dev.seb7.fr:/var/www/seb7.fr/blog

new:
	@read -p "Titre du nouveau post : " title;\
		source ./tools/venv/bin/activate;\
		DIR="post/"$$(date +"%Y-%m-%d");\
		SLUG=$$title;\
		FULL_PATH="$${DIR}/$${SLUG}.md";\
		hugo new "$$FULL_PATH";# --editor phpstorm -k post;
	hugo

# utile avant versionning - pour éviter les erreurs
generate:
	hugo

test:
	hugo serve -D 1> /dev/null &
	firefox http://localhost:1313/ &
	hugo --watch -D

stop_test:
	killall hugo
