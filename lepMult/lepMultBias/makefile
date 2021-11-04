include ../../make_opts

all: lepMult

clean:
	$(RM) *.o $(BIASLIBDIR)$(BIASLIBRARY)

#
# Compilation of the module lepMult
#
lepMult.o: lepMult.f ../bias.inc
	$(FC) $(FFLAGS) $(LDFLAGS) -c -o lepMult.o lepMult.f

lepMult: lepMult.o
	$(call CREATELIB, $(BIASLIBDIR)$(BIASLIBRARY), $^)

#
# List of the requirements for this module.
# 'VALID' is the keyword that *must* be returned if everything is in order.
#
requirements:	
	@echo "VALID"

