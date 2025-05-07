<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:html="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei html" version="2.0">
    <xsl:output method="html"/>

    <!-- transform the root element (TEI) into an HTML template -->
    <xsl:template match="tei:TEI">
        <html lang="en" xml:lang="en">
            <head>
                <title>
                    <!-- add the title from the metadata. This is what will be shown on your browsers tab -->
                    <xsl:apply-templates select="//tei:titleStmt/tei:title"/>: lästext </title>
                <!-- load the stylesheets in the ../assets/css folder, where you can modify the styling of your website -->
                <link rel="stylesheet" href="../assets/css/main.css"/>
            </head>
            <body>
                <header>
                    <h1>
                        <xsl:apply-templates select="//tei:titleStmt/tei:title"/>
                    </h1>
                </header>
                <nav id="sitenav">
                    <a href="../index.html">Hem</a> | 
                    <a href="index.html"><xsl:apply-templates select="//tei:titleStmt/tei:title"/></a> | 
                    <a href="diplomatic.html">Diplomatarisk transkription</a> | 
                    <b><a href="reading.html">Lästext</a></b> | 
                </nav>
                <main>
                    <!-- bootstrap "container" class makes the columns look pretty -->
                    <div class="container">
                        <!-- define a row layout with bootstrap's css classes (two columns with content, and an empty column in between) -->
                        <div class="row">
                            <div class="col-s">
                                <h3>Bilder</h3>
                            </div>
                            <div class="col-md">
                                <h3>Transkription</h3>
                            </div>
                        </div>
                        <!-- set up an image-text pair for each page in your document, and start a new 'row' for each pair -->
                        <xsl:for-each select="//tei:div[ends-with(@n, 'r')]">
                        <!-- <xsl:for-each select="//tei:div[@type = 'page']"> -->

                            <!-- save the value of each page's @facs attribute in a variable, so we can use it later -->
                            <xsl:variable name="facs" select="@facs"/>
                            <div class="row">
                                <!-- fill the first column with this page's image -->
                                <div class="col-s">
                                    <!-- make an HTML <img> element, with a maximum width of 100 pixels -->
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="'./diplomatic.html#'"/>
                                            <xsl:value-of select="$facs"/>
                                        </xsl:attribute>
                                        <img class="thumbnail">
                                            <!-- give this HTML <img> attribute three more attributes:
                                                    @src to locate the image file
                                                    @title for a mouse-over effect
                                                    @alt for alternative text (in case the image fails to load, 
                                                        and so people with a visual impairment can still understant what the image displays 
                                                  
                                                  in the XPath expressions below, we use the variable $facs (declared above) 
                                                        so we can use this page's @facs element with to find the corresponding <surface>
                                                        (because it matches with the <surface's @xml:id) 
                                            
                                                  we use the substring-after() function because when we match our page's @facs with the <surface>'s @xml:id,
                                                        we want to disregard the hashtag in the @facs attribute-->

                                            <!-- <xsl:attribute name="src">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:figure/tei:graphic[2]/@url"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="title">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:figure/tei:label"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:figure/tei:figDesc"/>
                                            </xsl:attribute> -->
                                            <xsl:attribute name="src">
                                                <xsl:value-of
                                                  select="//tei:surface[@xml:id = $facs]/tei:figure/tei:graphic[2]/@url"
                                                />
                                            </xsl:attribute>
                                            <xsl:attribute name="title">
                                                <xsl:value-of
                                                  select="//tei:surface[@xml:id = $facs]/tei:figure/tei:label"
                                                />
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:value-of
                                                  select="//tei:surface[@xml:id = $facs]/tei:figure/tei:figDesc"
                                                />
                                            </xsl:attribute>
                                        </img>
                                    </a>
                                    <p class="pagenumber">
                                        [<xsl:value-of select="//tei:surface[@xml:id = $facs]/tei:figure/tei:label"/>]
                                    </p>
                                </div>
                                <!-- fill the second column with our transcription -->
                                <div class="col-md">
                                    <div class="reading">
                                        <xsl:apply-templates/>
                                    </div>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </main>
                <footer>
                    <div class="row" id="footer">
                        <div class="col-sm copyright">
                            <div class="copyright_logos">
                                <a href="https://creativecommons.org/licenses/by/4.0/legalcode">
                                    <img src="../assets/img/logos/cc.svg" class="copyright_logo"
                                        alt="Creative Commons License"/>
                                    <img src="../assets/img/logos/by.svg" class="copyright_logo"
                                        alt="Attribution 4.0 International"/>
                                </a>
                            </div>
                            <div class="copyright_text"> 2025 <xsl:apply-templates select="//tei:titleStmt/tei:principal"/>. </div>
                        </div>
                    </div>
                </footer>
            </body>
        </html>
    </xsl:template>

    <!-- by default all text nodes are printed out, unless something else is defined.
    We don't want to show the metadata. So we write a template for the teiHeader that
    stops the text nodes underneath (=nested in) teiHeader from being printed into our
    html-->
    <xsl:template match="tei:teiHeader"/>

    <!-- we turn the tei head element (headline) into an html h3 element-->
    <xsl:template match="tei:head">
        <h3>
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

    <!-- transform tei paragraphs into html paragraphs -->
    <xsl:template match="tei:p">
        <p>
            <!-- <xsl:choose>
                <xsl:when test="@rend">
                    <xsl:attribute name="class">
                        <xsl:value-of select="@rend"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose> -->
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- transform tei lg into html paragraphs -->
    <xsl:template match="tei:lg">
        <p>
            <xsl:attribute name="class">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- transform tei l into html linebreaks -->
    <xsl:template match="tei:l">
        <br/>
        <span class="indent">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- transform tei unclear to brackets-->
    <xsl:template match="tei:unclear"><span class="unclear"><xsl:apply-templates/></span>
    </xsl:template>

    <!-- make choices into spans with class:choice and only show the relevant choice-->
    <xsl:template match="tei:choice">
        <xsl:choose>
            <xsl:when test="tei:abbr">
                <span class="choice" data-title="{tei:abbr}">
                    <xsl:apply-templates select="tei:expan"/>
                </span>
            </xsl:when>
            <xsl:when test="tei:orig">
                <span class="choice" data-title="{tei:orig}">
                    <xsl:apply-templates select="tei:reg"/>
                </span>
            </xsl:when>
            <xsl:when test="tei:sic">
                <span class="choice" data-title="{tei:sic}">
                    <xsl:apply-templates select="tei:corr"/>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- do not show del in reading transcription-->
    <xsl:template match="tei:del"/>

    <!-- do not show superfluous characters in reading transcription-->
    <xsl:template match="tei:pc"/>

    <!-- do not show sic in reading transcription-->
    <xsl:template match="tei:sic"/>

    <!-- do not show editorial notes in reading transcription 
    <xsl:template match="tei:note"/> -->

    <!-- add editorially supplied amendments in reading transcription -->
    <xsl:template match="tei:supplied">
        <span class="choice" data-title="Saknas i originalet">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- transform tei emph into html emphasis-->
    <xsl:template match="tei:emph">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>

    <!-- make delSpan into a span with class delPencil or delInk - a bit of a kludge, but works -->
    <xsl:template match="tei:delSpan[@rend='pencil']">
        <xsl:text disable-output-escaping="yes">&lt;span class="delPencil"&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:delSpan[@rend='ink']">
        <xsl:text disable-output-escaping="yes">&lt;span class="delInk"&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:anchor">
        <xsl:text disable-output-escaping="yes">&lt;/span&gt;</xsl:text>
    </xsl:template>
    
    <!-- add sidenotes -->
    <xsl:template match="tei:note">
        <label>
            <xsl:attribute name="for">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>margin-toggle sidenote-number</xsl:text>
            </xsl:attribute>
        </label>
        <input>
            <xsl:attribute name="type">
                <xsl:text>checkbox</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="id">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:attribute name="class">
                <xsl:text>margin-toggle</xsl:text>
            </xsl:attribute>
        </input>
        <span class="sidenote">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

    <!-- remove hyphens and line breaks if <lb> has break="no"-->
    <xsl:template match="text()[following-sibling::*[1][self::tei:lb[@break = 'no']]]">
        <!--<span style="color:green">
            <xsl:value-of select="substring(string(), 1, string-length()-1)"/>
            <xsl:value-of select="substring-before(string(), '-')"/>
            </span>-->
        <!--
            <xsl:value-of select="(substring-before(string(), '-'))"/></span>
        <span style="color:green"><xsl:value-of select="(substring-before(string(), '='))"/></span>-->
    </xsl:template>

</xsl:stylesheet>
