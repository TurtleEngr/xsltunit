
mApp = library.xsl
mTestSuite = tst_library.xsl
mFmtReport = xsltunit_report.xsl

mParms = \
	--stringparam gpApp $(mApp) \
	--stringparam gpTestSuite $(mTestSuite)

mTidyHtml = tidy -m -q -i -w 78 -asxhtml --break-before-br yes --indent-attributes yes --indent-spaces 2 --tidy-mark no --vertical-space no

test : validate $(mTestSuite).result.xml report

$(mTestSuite).result.xml : $(mApp) $(mTestSuite)
	xsltproc \
		$(mTestSuite) \
		$(mApp) \
		>$(mTestSuite).result.xml

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

validate : 
	xmllint --noout --nonet *.xml *.xsl

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
	-rm *~ *.result.* &>/dev/null
