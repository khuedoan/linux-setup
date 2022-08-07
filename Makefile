.POSIX:

playbook = main
tags = all

default: run

diff:
	ansible-playbook \
		--ask-become-pass \
		--inventory hosts.ini \
		--tags "${tags}" \
		--check \
		--diff \
		"${playbook}.yml"

run:
	ansible-playbook \
		--ask-become-pass \
		--inventory hosts.ini \
		--tags "${tags}" \
		"${playbook}.yml"
