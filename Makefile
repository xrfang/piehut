SHELL=/bin/bash
ISONPI=$(shell lsb_release -a 2>&1|grep -i raspbian|wc -l)
ifeq ($(ISONPI), 0)
all:	    
	@echo "This Makefile must be run on a Raspberry Pi!"
else
all: prepare
endif
prepare:
	@echo "ISONPI=$(ISONPI)"
	@echo "Install required packages..."
