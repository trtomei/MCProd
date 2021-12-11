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

generate h > all all

# generate    h > Z l+ l- , Z > l+ l-
# add process h > Z l+ l- , Z > vl vl~
# add process h > Z l+ l- , Z > j j
# add process h > Z vl vl~, Z > l+ l-
# add process h > Z vl vl~, Z > vl vl~
# add process h > Z vl vl~, Z > j j
# add process h > Z j j   , Z > l+ l-
# add process h > Z j j   , Z > vl vl~
# add process h > Z j j   , Z > j j
# add process h > W- l+ vl , W- > l- vl~
# add process h > W- l+ vl , W- > j j
# add process h > W- j j   , W- > l- vl~
# add process h > W- j j   , W- > j j
# add process h > W+ l- vl~, W+ > l+ vl
# add process h > W+ l- vl~, W+ > j j
# add process h > W+ j j   , W+ > l+ vl
# add process h > W+ j j   , W+ > j j
# add process h > b b~
# add process h > ta+ ta-

#generate h > b b~
#add process h > ta+ ta-

output step1
launch step1
reweight=on
done
set iseed 1
done

launch step1
done
set bias_module lepMult
done
