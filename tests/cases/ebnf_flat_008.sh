#! /bin/bash

# Test case: test if a provided Filter langauge EBNF grammar correctly
# recognises filter expressions

#BEGIN DEPEND -----------------------------------------------------------------

INPUT_GRAMAR=grammars/flat-filters.ebnf

#END DEPEND -------------------------------------------------------------------

./tools/grammatiker/BNF/scripts/grammatica-tree \
    <(./tools/grammatiker/EBNF/scripts/ebnf2grammatica ${INPUT_GRAMAR}) \
    <(echo -n filter='aax <= +.1e8 OR c21 >= 10 AND NOT f = y OR NOT a >= b OR x = t OR ( NOT x != "Some string" OR a = b AND x > v AND NOT v < w)')
