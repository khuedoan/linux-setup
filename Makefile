.POSIX:

default: init run

init:
	python3 -m venv .venv \
		&& . .venv/bin/activate \
		&& pip3 install --upgrade pip \
		&& pip3 install -r requirements.txt \
		&& ansible-galaxy install -r requirements.yml

run:
	. .venv/bin/activate \
		&& ansible-playbook --ask-become-pass --inventory hosts.ini main.yml

dotfiles:
	. .venv/bin/activate \
		&& ansible-playbook --inventory hosts.ini --tags dotfiles main.yml
