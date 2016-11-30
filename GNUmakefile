#---*- Makefile -*-------------------------------------------------------
#$Author: antanas $
#$Date: 2016-04-29 16:13:21 +0300 (Fri, 29 Apr 2016) $
#$Revision: 92 $
#$URL: svn+ssh://saulius-grazulis.lt/home/saulius/svn-repositories/makefiles/Makefile-multiscript-testing $
#------------------------------------------------------------------------

TEST_DIR = tests/cases
OUTP_DIR = tests/outputs

TEST_FILES = ${wildcard ${TEST_DIR}/*.inp}
TEST_DIFF_FILES = ${TEST_FILES:${TEST_DIR}/%.inp=${OUTP_DIR}/%.diff}
TEST_OUTP_FILES = ${TEST_FILES:${TEST_DIR}/%.inp=${OUTP_DIR}/%.out}

OPT_FILES = ${wildcard ${TEST_DIR}/*.opt}
OPT_DIFF_FILES = ${OPT_FILES:${TEST_DIR}/%.opt=${OUTP_DIR}/%.diff}
OPT_OUTP_FILES = ${OPT_FILES:${TEST_DIR}/%.opt=${OUTP_DIR}/%.out}

SH_FILES = ${wildcard ${TEST_DIR}/*.sh}
SH_DIFF_FILES = ${SH_FILES:${TEST_DIR}/%.sh=${OUTP_DIR}/%.diff}
SH_OUTP_FILES = ${SH_FILES:${TEST_DIR}/%.sh=${OUTP_DIR}/%.out}

DIFF_FILES = $(sort ${TEST_DIFF_FILES} ${OPT_DIFF_FILES} ${SH_DIFF_FILES})
OUTP_FILES = $(sort ${TEST_OUTP_FILES} ${OPT_OUTP_FILES} ${SH_OUTP_FILES})

.PHONY: all clean cleanAll distclean check test tests out outputs

all: tests

check test tests: ${DIFF_FILES}

out outputs: ${OUTP_FILES}

#------------------------------------------------------------------------------

# Rules to run script-specific tests:

${OUTP_DIR}/%.diff: ${TEST_DIR}/%.inp ${TEST_DIR}/%.opt
	-@printf "%-30s " "$<:" ; \
	./$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $(shell grep -v '^#' ${word 2, $^}) \
	    $< \
	2>&1 \
	| diff ${OUTP_DIR}/$*.out - > $@ ; \
	if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi

${OUTP_DIR}/%.diff: ${TEST_DIR}/%.opt
	-@printf "%-30s " "$<:" ; \
	./$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $(shell grep -v '^#' ${word 1, $^}) \
	2>&1 \
	| diff ${OUTP_DIR}/$*.out - > $@ ; \
	if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi

${OUTP_DIR}/%.diff: ${TEST_DIR}/%.inp
	-@printf "%-30s " "$<:" ; \
	./$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $< \
	2>&1 \
	| diff ${OUTP_DIR}/$*.out - > $@ ; \
	if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi

# Shell-script based tests:

${OUTP_DIR}/%.diff: ${TEST_DIR}/%.sh
	-@printf "%-30s " "$<:" ; \
	$< 2>&1 \
	| diff ${OUTP_DIR}/$*.out - > $@ ; \
	if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi

# Rules to generate sample test outputs:

${OUTP_DIR}/%.out: ${TEST_DIR}/%.inp ${TEST_DIR}/%.opt
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	./$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $(shell grep -v '^#' ${word 2, $^}) \
	    $< \
	2>&1 \
	| tee $@
	-@touch $@

${OUTP_DIR}/%.out: ${TEST_DIR}/%.opt
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	./$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $(shell grep -v '^#' ${word 1, $^}) \
	2>&1 \
	| tee $@
	-@touch $@

${OUTP_DIR}/%.out: ${TEST_DIR}/%.inp
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	./$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $< \
	2>&1 \
	| tee $@
	-@touch $@

${OUTP_DIR}/%.out: ${TEST_DIR}/%.sh
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	$< 2>&1 \
	| tee $@
	-@touch $@

#------------------------------------------------------------------------------

.PHONY: listdiff

listdiff: ## test
	@-( test -d ${OUTP_DIR} && \
	    ls -l ${OUTP_DIR}/*.diff | awk '{if( $$5 > 0 ) print}' ) | sort -u || \
	    true

#------------------------------------------------------------------------------

clean:
	rm -f ${DIFF_FILES}

distclean cleanAll: clean