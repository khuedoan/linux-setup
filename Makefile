.POSIX:

default: run

run:
	ansible-playbook \
		--ask-become-pass \
		--inventory hosts.ini \
		main.yml

dotfiles:
	ansible-playbook \
		--inventory hosts.ini \
		--tags dotfiles \
		main.yml

games:
	ansible-playbook \
		--ask-become-pass \
		--inventory hosts.ini \
		games.yml
