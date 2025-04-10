<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:output method="html" omit-xml-declaration="yes" indent="yes" encoding="UTF-8"/>

    <!-- transform the root element (TEI) into an HTML template -->
    <xsl:template match="tei:TEI">
        <html lang="en" xml:lang="en">
            <head>
                <title>
                    <!-- add the title from the metadata. This is what will be shown on your browsers tab-->
                    <xsl:apply-templates select="//tei:titleStmt/tei:title"/>
                </title>
                <!-- load bootstrap css (requires internet!) so you can use their pre-defined css classes to style your html -->
                <link rel="stylesheet"
                    href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
                    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
                    crossorigin="anonymous"/>
                <!-- load the stylesheets in the assets/css folder, where you can modify the styling of your website -->
                <link rel="stylesheet" href="assets/css/main.css"/>
            </head>
            <body>
                <header>
                    <h1>
                        <xsl:apply-templates select="//tei:titleStmt/tei:title"/>
                    </h1>
                </header>

                <nav id="sitenav">
                    <a href="test.html">Home</a> | <a href="diplomatic.html">Diplomatic
                        Transcription</a> | <a href="reading.html">Reading Text</a> | <a
                        href="toplayer.html">Top Layer</a> | </nav>

                <main id="manuscript">
                    <!-- bootstrap "container" class makes the columns look pretty -->
                    <div class="container">

                        <div class="index">

                            <!-- define a row layout with bootstrap's css classes (two columns) -->
                            <div class="row">
                                <!-- first column: load the image based on the IIIF link in the graphic above -->
                                <div class="col-sm">
                                    <!-- <xsl:for-each select="//tei:surface"> -->
                                    <xsl:for-each select="//tei:div[ends-with(@n, 'r')]">
                                        <!-- save the value of each page's @facs attribute in a variable -->
                                        <xsl:variable name="facs" select="@facs"/>
                                        
                                            
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:text>&#35;</xsl:text>
                                                <!-- <xsl:value-of
                                                  select="replace(tei:figure/tei:label, ' ', '')"/> -->
                                                <xsl:value-of select="$facs"/>
                                            </xsl:attribute>
                                            <img class="thumbnail">
                                                <!-- <xsl:attribute name="src">
                                                  <xsl:value-of
                                                  select="tei:figure/tei:graphic[2]/@url"/>
                                                </xsl:attribute> -->
                                                <xsl:attribute name="src">
                                                    <xsl:value-of select="//tei:surface[@xml:id=$facs]/tei:figure/tei:graphic[2]/@url"/>
                                                </xsl:attribute>
                                                <!-- <xsl:attribute name="title">
                                                  <xsl:value-of select="tei:figure/tei:label"/>
                                                </xsl:attribute> -->
                                                <xsl:attribute name="title">
                                                    <xsl:value-of
                                                        select="//tei:surface[@xml:id = $facs]/tei:figure/tei:label"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="alt">
                                                  <xsl:value-of select="tei:figure/tei:figDesc"/>
                                                </xsl:attribute>
                                            </img>
                                        </a>
                                    </xsl:for-each>
                                </div>
                                <!-- second column: apply matching templates for anything nested underneath the tei:text element -->
                                <div class="col-md">
                                    <xsl:for-each select="//tei:div[ends-with(@n, 'r')]">
                                        <xsl:apply-templates/>
                                    </xsl:for-each>
                                </div>
                            </div>
                            <!-- <p>
                                <strong>Description:</strong> &#160; <xsl:apply-templates
                                    select="//tei:sourceDesc/tei:p/text()"/>
                            </p> -->
                        </div>

                        <!-- set up an image-text pair for each page in your document, and start a new 'row' for each pair -->
                        <div class="diplomatic">
                            <xsl:for-each select="//tei:div[@type = 'page']">
                                
                            <!--<xsl:for-each select="//tei:div[ends-with(@n, 'r')]">-->
                                <!-- save the value of each page's @facs attribute in a variable, so we can use it later -->
                                <xsl:variable name="facs" select="@facs"/>
                                <xsl:variable name="number" select="substring(@n, 1, 2)"/>
                                <div class="row">

                                    <!-- fill the first column with this page's image -->

                                    <div class="col-">

                                        <!-- make an HTML <img> element, with a maximum width of 100 pixels -->

                                        <img class="thumbnail">
                                            <!-- give this HTML <img> attribute three more attributes:
                                            @src to locate the image file
                                            @title for a mouse-over effect
                                            @alt for alternative text (in case the image fails to load,
                                            and so people with a visual impairment can still understant what the image displays 
                                            
                                            in the XPath expressions below, we use the variable $facs (declared above)
                                            so we can use this page's @facs element with to find the corresponding <surface>
                                            (because it matches with the <surface's @xml:id) -->
                                            <xsl:attribute name="id">
                                                <xsl:text>sida</xsl:text><xsl:value-of select="$number"/>
                                                <!-- <xsl:value-of select="replace(//tei:surface[@xml:id=$facs]/tei:figure/tei:label, ' ', '')"/> -->
                                            </xsl:attribute>
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
                                                <xsl:value-of select="//tei:surface[@xml:id=$facs]/tei:figure/tei:figDesc"/>
                                            </xsl:attribute>
                                        </img>
                                        <p class="number"><xsl:value-of
                                            select="//tei:surface[@xml:id = $facs]/tei:figure/tei:label"/>
                                        </p>   
                                    </div>

                                    <!-- for diplomatic, etc - fill the second column with our transcription -->

                                    <div class="col-md">
                                        <div class="page">
                                            <xsl:apply-templates/>
                                        </div>
                                    </div>
                                </div>
                            </xsl:for-each>
                        </div>

                        <!-- for toplayer, etc - select only right-hand (recto) pages -->

                        <div class="toplayer">
                            <xsl:for-each select="//tei:div[ends-with(@n, 'r')]">
                                <xsl:apply-templates/>
                            </xsl:for-each>
                        </div>

                        <div class="row">
                            <div class="col-sm">
                                <p>
                                    <strong>Författare:</strong>
                                    <br/>
                                    <xsl:apply-templates select="//tei:titleStmt/tei:author"/>
                                </p>
                                <p>
                                    <strong>Transkriberat av:</strong>
                                    <br/>
                                    <xsl:apply-templates select="//tei:titleStmt/tei:principal"/>
                                </p>
                            </div>
                        </div>
                    </div>
                </main>

                <footer>
                    <div class="row" id="footer">
                        <div class="col-sm copyright">
                            <div class="copyright_logos">
                                <a href="https://creativecommons.org/licenses/by/4.0/legalcode">
                                    <img src="assets/img/logos/cc.svg" class="copyright_logo"
                                        alt="Creative Commons License"/>
                                    <img src="assets/img/logos/by.svg" class="copyright_logo"
                                        alt="Attribution 4.0 International"/>
                                </a>
                            </div>
                            <div class="copyright_text"> 2025 Emilia, Peeter och Rebecca. </div>
                        </div>
                    </div>
                </footer>
<!--                <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"/>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"/>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"/>-->
            </body>
        </html>
    </xsl:template>

    <!-- by default all text nodes are printed out, unless something else is defined.
    We don't want to show the metadata. So we write a template for the teiHeader that
    stops the text nodes underneath (=nested in) teiHeader from being printed into our
    html-->
    <xsl:template match="tei:teiHeader"/>

    <!-- we turn the tei head element (headline) into an html h2 element-->
    <xsl:template match="tei:head">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <!-- <xsl:template match="tei:div[@type = 'page']">
        <xsl:choose>
            <xsl:when test="tei:p[@rend='func']">
              <p>
                  <xsl:apply-templates select="tei:p[@rend='func']" />
              </p>  
            </xsl:when>
        </xsl:choose>
    </xsl:template> -->
    
    <!-- transform tei paragraphs into html paragraphs -->
    <xsl:template match="tei:p">
        <p>
            <xsl:choose>
                <xsl:when test="@rend">
                    <xsl:attribute name="class">
                        <xsl:value-of select="@rend"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="tei:lg">
                    <xsl:attribute name="class">verse</xsl:attribute>
                </xsl:when>
            </xsl:choose>
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
    <xsl:template match="tei:unclear">
        [<xsl:apply-templates/>]?
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

    <xsl:template match="tei:note">
        <span class="note">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- do not show del in toplayer transcription -->
    <xsl:template match="tei:del"/>

    <!-- do not show superfluous characters in toplayer transcription -->
    <xsl:template match="tei:pc"/>

    <!-- add editorially supplied amendments in toplayer transcription -->
    <xsl:template match="tei:supplied">
        <span class="choice" data-title="Saknas i originalet">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- do not show original spellings in toplayer transcription
    <xsl:template match="tei:orig">
        <span style="display:none">
            <xsl:apply-templates/>
        </span>
    </xsl:template>-->

    <!-- do not show abbreviations in toplayer transcription
    <xsl:template match="tei:abbr">
        <span class="display:none">
            <xsl:apply-templates/>
        </span>
    </xsl:template>-->

    <!-- transform tei emph into html emphasis-->
    <xsl:template match="tei:emph">
        <em>
            <xsl:apply-templates/>
        </em>
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
