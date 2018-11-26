all:
	bazel build :func.so $(OPTIONS)

ifeq ($(show), all)
OPTIONS += -s
endif
ifdef options
OPTIONS += $(options)
endif

build    : all             ## Build all

rebuild  : clean all       ## Clean and build again

test     : build           ## Run tests
	bazel test

clean    :                 ## Clean
	bazel clean

help     :                 ## Show this help
	@echo Additional targets:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -r 's/(.*):.*##(.*)/   \1 -\2/'
	@echo
	@echo Additional options:
	@echo "   show=all          - show subcommand output"
	@echo "   options=<options> - add bazel options"
	@echo
	@echo Example of usage:
	@echo "   make build options=-s"
