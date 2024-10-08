.DEFAULT_GOAL := help

# Colours used in help
RESET    := $(shell tput -Txterm sgr0)
RED      := $(shell tput -Txterm setaf 1)
GREEN    := $(shell tput -Txterm setaf 2)
YELLOW   := $(shell tput -Txterm setaf 3)
WHITE    := $(shell tput -Txterm setaf 7)

HELP_FUN = \
	%help; \
    local $$/; \
    $$_ = <>; \
	print "Usage:\n  make ${YELLOW}<target> [argument1=value1] [argument2=value2]${RESET}\n\nThe following targets are available:\n"; \
    while (/(?:^\#\#\s*(?:@(.+):\s*)?(.+)\n)?^([a-zA-Z\-]+):/mg) { \
        push @{$$help{$$1}}, [$$3, $$2] \
    } \
	for (sort keys %help) { \
		if (length $$_) { \
			print "${WHITE}$$_${RESET}\n"; \
		} \
		for (@{$$help{$$_}}) { \
			$$sep = " " x (32 - length $$_->[0]); \
			print "  ${YELLOW}$$_->[0]${RESET}$$sep${GREEN}$$_->[1]${RESET}\n"; \
		} \
		print "\n"; \
	}

# This gives the ability to set required arguments for a target.
# Example:
#   my-target: guard-myarg 
#     Will exit 1 with message "Required argument myarg not set!" when myarg is not passed to my-target.
guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Required argument ['$*'] not set!"; \
		exit 1; \
	fi

## Print this help.
help:
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)

## @Git: Create .gitconfig.
git-config:
	@if cp -n git/base.gitconfig ~/.gitconfig; then \
		echo "${RED}Don't forget to setup user details if they differ from personal.${RESET}"; \
		echo "${RED}Don't forget to setup gpg keys locally and add to remote VCS.${RESET}"; \
	else \
		echo "${RED}~/.gitconfig already exists!"; \
	fi

## @iTerm2: Export iTerm2 settings.
iterm-export:
	defaults export com.googlecode.iterm2 iterm/com.googlecode.iterm2

## @iTerm2: Import iTerm2 settings.
iterm-import:
	defaults import com.googlecode.iterm2 iterm/com.googlecode.iterm2

## @zsh: Link .zshrc which will auto install omz on next source.
zsh:
	ln -s ~/.dotfiles/.zshrc ~/.zshrc
