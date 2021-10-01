include ../../make_opts

all: HT

clean:
	$(RM) *.o $(BIASLIBDIR)$(BIASLIBRARY)

#
# Compilation of the module HT
#
HT.o: HT.f ../bias.inc
	$(FC) $(FFLAGS) $(LDFLAGS) -c -o HT.o HT.f

HT: HT.o
	$(call CREATELIB, $(BIASLIBDIR)$(BIASLIBRARY), $^)

#
# List of the requirements for this module.
# 'VALID' is the keyword that *must* be returned if everything is in order.
#
requirements:	
	@echo "VALID"

