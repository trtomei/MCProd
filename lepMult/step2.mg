import model heft

define p = g u c d s u~ c~ d~ s~ b b~
define j = g u c d s u~ c~ d~ s~ b b~
define l+ = e+ mu+ ta+
define l- = e- mu- ta-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~

define lept = l+ l- vl vl~
define bos = Z W+ W- a
define top = t t~

generate p p > h  $ top bos h HIG=1 HIW=0
#add process p p > h j  $ top bos h HIG=1 HIW=0
#add process p p > h j j  $ top bos h HIG=1 HIW=0
#add process p p > h j j j  $ top bos h HIG=1 HIW=0

output step2
launch step2
madspin=on
reweight=on
done
../lepMult/madspin_card_Higgs.dat
set iseed 1
done

launch step2
done
../lepMult/madspin_card_HiggsBias.dat
done

#launch step2
#done
#done