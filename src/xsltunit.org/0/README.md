# XSLTunit

This Version: [V 0.2 (18 January 2002)](2/index.html)

Latest Version: [http://xsltunit.org](http://xsltunit.org)</a>

This namespace: [http://xsltunit.org/0/](index.html)

Previous Version: none

XSLTunit 0.x is a proof of concept including this page,
[xsltunit.xsl](xsltunit.xsl) (a XSLT sheet that can be imported into
transformation to perform unit tests on XSLT sheets) and a set of
examples.

The description of the namespace version convention I intend to use
for XSLTunit has been
[posted](http://lists.xml.org/archives/xml-dev/200103/msg00995.html)
for discussion on xml-dev.

Original Author: [Eric van der Vlist](mailto:vdv@dyomedea.com)
[Dyomedea](http://dyomedea.com)

----

## 1. Purposes

The purpose of XSLTunit is to provide a unit testing framework for XSLT transformations similar to the "*unit" environments available for other languages (i.e. Junit for Java).

Although not a general purpose programming language, XSLT is turing complete and allows to develop powerful (and complex) transformations that deserve unit testing.

----


## 2. Limitations

The first limitation I have found is that stylesheets need to be
slightly modified to test the template that is applied to the root
element.

This is because the XSLT sheet running the test needs to define a
template for the root document that will let it get control over the
tests to run. After having taken control, this template has no way to
invoke the template for root elements defined in the tested sheet that
is imported and has a lower priority.

We will see that there is an easy workaround using modes, but the
tested stylesheet has still to be edited.

----

## 3. Tutorial

### 3.1. Getting started.
  
A XSLTunit set of tests is a XSLT transformation that imports the
tested stylesheet and xsltunit.xsl, for instance:

    <?xml version="1.0" encoding="UTF-8"?>
    <xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:exsl="http://exslt.org/common"
        extension-element-prefixes="exsl"
        xmlns:xsltu="http://xsltunit.org/0/"
        exclude-result-prefixes="exsl">
        
        <xsl:import href="library.xsl"/>
        <xsl:import href="xsltunit.xsl"/>
        <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
        .../...
    </xsl:stylesheet>

This example will be using a EXSLT extension to convert result tree
fragments into nodeset and that's the reason why we have included the
declaration of the namespace for EXSLT.
  
The XSLTunit namespace is used to identify modes and named templates
belonging to XSLTunit as well as the vocabulary used by the test
report.
  
This transformation will gain control (typically using a template on
the document element) and generate the test report.
  
The document element of the test report will typically be xsltu:tests.

    <xsl:template match="/">
          <xsltu:tests>
          .../...
          </xsltu:tests>
    </xsl:template>

## 3.2. Our first test</h3>
  
Let's assume we want to test that the formatting of the title of a
book described in a document will have a specific value. We will write
this test as:

    <xsltu:test id="test-title">
          <xsl:call-template name="xsltu:assertEqual">
              <xsl:with-param name="id" select="'full-value'"/>
              <xsl:with-param name="nodes1">
                  <xsl:apply-templates select="document('library.xml')/library/book[isbn='0836217462']/title"/>
              </xsl:with-param>
              <xsl:with-param name="nodes2">
                  <h1>Being a Dog Is a Full-Time Job</h1>
              </xsl:with-param>
          </xsl:call-template>
    </xsltu:test>
  
The named template "xsltu:assertEqual" will compare the two parameters
nodes1 (that will contain the result of the transformation of the
title) and nodes2 (containing the expected value) and generate the
report for this test using the id defined in its id parameter).
  
The result will be for instance (if the test passes):

    <xsltu:test id="test-title">
        <xsltu:assert id="full-value" outcome="passed"/>
    </xsltu:test>
  
Or (if the test fails because the transformation has added a "!"):

<xsltu:test id="test-title">
    <xsltu:assert id="full-value" outcome="failed">
        <xsltu:message>
            <xsltu:diff name="">
                <xsltu:diff name="h1">
                    <xsltu:no-match>
                        <xsltu:node>Being a Dog Is a Full-Time Job!</xsltu:node>
                        <xsltu:node>Being a Dog Is a Full-Time Job</xsltu:node>
                    </xsltu:no-match>
                </xsltu:diff>
            </xsltu:diff>
        </xsltu:message>
    </xsltu:assert>
</xsltu:test>

### 3.3. Testing that values are not equal
  
The test can also be reverted and we can test that two variables are
different, for instance if we wanted to test that the result will not
be an empty h1 element:

    <xsltu:test id="test-title-reverted">
        <xsl:call-template name="xsltu:assertNotEqual">
            <xsl:with-param name="id" select="'non-empty-h1'"/>
            <xsl:with-param name="nodes1">
                <xsl:apply-templates select="document('library.xml')/library/book[isbn='0836217462']/title"/>
            </xsl:with-param>
            <xsl:with-param name="nodes2">
                <h1/>
            </xsl:with-param>
        </xsl:call-template>
    </xsltu:test>
      
### 3.4. Testing XPath expressions
  
For those situations that require more flexibility, XPath expressions
can be tested using the xsltu:assert named pattern, for instance:

    <xsltu:test id="XPath-expressions">
        <xsl:variable name="source">
            <title>My title</title>
        </xsl:variable>
        <xsl:variable name="result-rtf">
            <xsl:apply-templates select="exsl:node-set($source)/title"/>
        </xsl:variable>
        <xsl:variable name="result" select="exsl:node-set($result-rtf)"/>
        <xsl:call-template name="xsltu:assert">
            <xsl:with-param name="id" select="'h1'"/>
            <xsl:with-param name="test" select="$result/h1"/>
            <xsl:with-param name="message">This should be a h1!</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="xsltu:assert">
            <xsl:with-param name="id" select="'value'"/>
            <xsl:with-param name="test" select="$result/h1=$source"/>
            <xsl:with-param name="message">
                h1 is "<xsl:value-of select="$result/h1"/>"
            </xsl:with-param>
        </xsl:call-template>
    </xsltu:test>

----

## 4. Resources

### 4.1 XSLTunit library
    
This "XSLTunit library" (`library.xsl`) is imported into XSLTunit sets
of tests.

This release must be run using a EXSLT compliant XSLT processor (such
as Saxon, libxslt, 4xslt, Xalan-J, ...).

### 4.2 XSLTunit example</h4>
    
This "XSLT unit suite" (`tst_library.xsl`) is the one that is decribed
in the tutorial.
      
### 4.3 Library instance document
    
This "instance document" (`library.xml`) is used as an example in the
tutorial.

### 4.4 Library XSLT transformation.
    
This "transformation" (`library.xsl`) is the one that is tested in the
tutorial.

### 4.5 CSS Stylesheet
    
A "CSS stylesheet" (`xrd.css`) borrowed from RDDL used to provide the
&quot;look-and-feel&quot; of this document, suitable in general for
RDDL documents.

### 4.6 CSS Stylesheet (original)
    
Original version of the previous
[CSS stylesheet](http://www.rddl.org/xrd.css) on rddl.org.

----

## 5. To do

I have been pleasantly surprised after a couple of hours working on
XSLTunit that this simple tool was beginning to be useful while still
very simple (or simplistic).

The current version is already a powerful tool that can be used to
perform XSLT unit testing (and XSLTunit has been used to test the
XSLTunit library).

This being said, the simplicity of the tools is leaving room for many
applications and extensions on which your
[feedback](mailto:vdv@dyomedea.com) is welcome:

- Portability: develop versions that can run with other XSLT processors.

----

## 6. Acknowledgements

Many thanks to the many people that have given me hints, ideas or
encouragements.

Non normative list (by chronological order): Robert Martin, James
Grenning, Chuck Allison, Chet Hendricksen, Ron Jeffries, Leigh Dodds,
Matt Sergeant.

----

## 7. History

### [V0.2.1](2/index.html)

1. Added doc/example1, doc/example2
1. Added Makfiles to run the tests

### [V0.2](2/index.html)

1. Replaced the Saxon specific "saxon:nodeSet" extension by the EXSLT
generic "exsl:node-set" extension (same parameters and semantic).

### [V0.1](1/index.html)

1. Creation

----

## 8. Legal Statement

Copyright (c) 2001,2003 Eric van der Vlist</p>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
`Software`), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

1. The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

1. The name of the authors when specified in the source files shall be
kept unmodified.

THE SOFTWARE IS PROVIDED ``AS IS'', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL ERIC VAN DER VLIST BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
THE USE OR OTHER DEALINGS IN THE SOFTWARE.
