.POSIX:

default: init run

init:
	ansible-galaxy install -r requirements.yml

run:
	ansible-playbook \
		--ask-become-pass \
		--ask-vault-pass \
		--inventory hosts.ini \
		main.yml

dotfiles:
	ansible-playbook \
		--inventory hosts.ini \
		--tags dotfiles \
		main.yml
