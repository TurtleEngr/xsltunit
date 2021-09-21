# $Header: /repo/public.cvs/app/xsltunit/doc/example1/Makefile,v 1.6 2021/09/20 21:31:27 bruce Exp $

# Doc:  https://kata-log.rocks/gilded-rose-kata
# Src:  https://github.com/emilybache/GildedRose-Refactoring-Kata/tree/main/xslt
# Repo: git@github.com:emilybache/GildedRose-Refactoring-Kata.git

mApp = update_quality.xsl
mTestSuite = tst_$(mApp)

mFmtReport = xsltunit_report.xsl
mParms = \
	--stringparam gpApp $(mApp) \
	--stringparam gpTestSuite $(mTestSuite)

mDataIn = texttest_fixture.xml
mDataOut = texttest_fixture.next_day.xml

mDTD = gilded_rose.dtd

mTidyHtml = tidy -m -q -i -w 78 -asxhtml --break-before-br yes --indent-attributes yes --indent-spaces 2 --tidy-mark no --vertical-space no

# ========================================

test : validate run-app run-tests report

run-app $(mDataOut) : validdtd $(mApp) $(mDataIn)
	xsltproc $(mApp) $(mDataIn) >$(mDataOut)

run-tests : $(mTestSuite)
	xsltproc $(mTestSuite) $(mApp) >$(mTestSuite).result.xml

report : $(mTestSuite).result.xml $(mFmtReport)
	for p in pass fail; do \
		xsltproc \
			$(mParms) \
			--stringparam gpPassFail $$p \
			$(mFmtReport) \
			$(mTestSuite).result.xml \
			>$(mTestSuite).$$p.result.html; \
		$(mTidyHtml) $(mTestSuite).$$p.result.html; \
	done

validate : valid validdtd

valid : 
	xmllint --noout --nonet *.xml *.xsl

validdtd : $(mDataIn)
	xmllint --dtdvalid $(mDTD) --noout $(mDataIn)

reformat : validate
	export XMLLINT_INDENT='  '; \
	for i in *.xml *.xsl; do \
		echo $$i; \
		xmllint --format $$i | awk ' \
			/xsl:template>/ {print $$0; print " "; next}; \
			/xsl:when>/ {print $$0; print " "; next}; \
			/xsltu:test>/ {print $$0; print " "; next}; \
			{print $$0} \
		' >t.tmp; \
		mv t.tmp $$i; \
	done

clean :
	-rm *~ $(mDataOut) *result.*
