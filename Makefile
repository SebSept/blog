help:
	# git_push : pousser sur github, suivi de deploy normalement
	# publish : rsync sur dev.seb7.fr
	# new : création d'un nouveau post
	# test : afficher le blog : lance le serveur local et ouvre firefox

git_push:
	#git push github master

publish:
	rm -rf public/*
	hugo
	rsync --recursive --compress --delete public/ dev.seb7.fr:/var/www/seb7.fr/blog

new:
	@read -p "Titre du nouveau post : " title;\
		source ./tools/venv/bin/activate;\
		DIR="post/"$$(date +"%Y-%m-%d");\
		SLUG=$$(echo "$$title" | ./tools/slug.py);\
		FULL_PATH="$${DIR}/$${SLUG}.md";\
		hugo new "$$FULL_PATH" --editor phpstorm -k post;
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
