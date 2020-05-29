SHELL=/bin/bash
ISONPI=$(shell lsb_release -a 2>&1|grep -i raspbian|wc -l)
UID=$(shell id -u)
ifeq ($(ISONPI), 0)
all:	    
	@echo "This Makefile must be run on a Raspberry Pi!"
else ifneq ($(UID), 0)
all:
	@echo "This Makefile must be launched by root (try 'sudo')"
else
all: prepare
	@echo "TODO: print summary about tasks done..."
endif
prepare:
	@echo "Install required packages..."
