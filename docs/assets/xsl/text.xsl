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
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"/>
                <link rel="stylesheet" href="../assets/css/main.css"/>
                <link rel="shortcut icon" type="image/x-icon" href="../favicon.png"/>
            </head>
            <body>
                <header>
                    <a href="https://aarkiv.se"><img src="../assets/img/logos/AArkiv%20Logga.png.jpg" title="Arbetarrörelsens arkiv i Skåne" alt="Logga för Arbetarrörelsens arkiv i Skåne" class="logga"/></a>
                    <h1>
                        <xsl:apply-templates select="//tei:titleStmt/tei:title"/>
                    </h1>
                </header>

                <nav id="sitenav">
                    <a href="../index.html">Hem</a>
                    <a href="index.html"><xsl:apply-templates select="//tei:titleStmt/tei:title"/></a>
                    <a href="diplomatic.html">Diplomatarisk transkription</a>
                    <a href="text.html" class="active">Text</a>
                </nav>

                <main id="manuscript">
                    <!-- bootstrap "container" class makes the columns look pretty -->
                    <div class="container">

                        <div class="fulltext">
                            <xsl:for-each select="//tei:div[ends-with(@n, 'r')]">
                            <!-- <xsl:for-each select="//tei:div[@type='manuscript']"> -->
                                <xsl:if test="tei:pb[not(@rend='empty')]"> <!-- exclude empty pages -->
                                    <xsl:apply-templates />
                                </xsl:if>
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
    
    <!-- create an image as a marginnote for fulltext view -->
    <xsl:template match="tei:pb[not(@rend='empty')]">
        <xsl:variable name="facs" select="@facs"/>
        <span class="marginnote">
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="'./diplomatic.html#'"/>
                    <xsl:value-of select="$facs"/>
                </xsl:attribute>
                <img class="thumbnail">
                    <xsl:attribute name="src">
                        <xsl:value-of select="//tei:surface[@xml:id = $facs]/tei:figure/tei:graphic[2]/@url"/>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                        <xsl:value-of select="//tei:surface[@xml:id = $facs]/tei:figure/tei:label"/>
                    </xsl:attribute>
                    <xsl:attribute name="alt">
                        <xsl:value-of select="//tei:surface[@xml:id = $facs]/tei:figure/tei:figDesc"/>
                    </xsl:attribute>
                </img>
            <br/>
                [<xsl:value-of select="//tei:surface[@xml:id = $facs]/tei:figure/tei:label"/>]
            </a>
        </span>
    </xsl:template>

    <!-- transform tei paragraphs into html paragraphs -->
    <xsl:template match="tei:p[@part='N']"> <!-- self-contained paragraphs -->
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:p[@part='I']"> <!-- start of a paragraph, needs a <p> tag -->
        <xsl:text disable-output-escaping="yes">&lt;p&gt;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:p[@part='M']"> <!-- middle of a paragraph, needs nothing -->
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:p[@part='F']"> <!-- end of a paragraph, needs closing </p> tag -->
        <xsl:apply-templates/>
        <xsl:text disable-output-escaping="yes">&lt;/p&gt;</xsl:text>
    </xsl:template>
    
    <!-- transform tei lg into html spans -->
    <xsl:template match="tei:lg">
        <span>
            <xsl:attribute name="class">
                <xsl:value-of select="@type"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- transform tei l into html linebreaks -->
    <xsl:template match="tei:l">
        <br/>
        <span class="indent">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- transform tei unclear to a span that we can style with css -->
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

    <!-- do not show del in reading transcription -->
    <xsl:template match="tei:del"/>

    <!-- do not show superfluous characters in reading transcription -->
    <xsl:template match="tei:pc"/>
    
    <!-- do not show sic in reading transcription-->
    <xsl:template match="tei:sic"/>

    <!-- add editorially supplied amendments in reading transcription -->
    <xsl:template match="tei:supplied">
        <span class="choice" data-title="Saknas i originalet">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- add sidenotes -->
    <xsl:template match="tei:note">
        <xsl:if test="starts-with(@type, 'gloss')">
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
        </xsl:if>
    </xsl:template>
    
    <!-- make links clickable -->
    <xsl:template match="tei:ref">
        <a>
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </a>
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
    
    <!-- transform tei emph into html emphasis-->
    <xsl:template match="tei:emph">
        <em>
            <xsl:apply-templates/>
        </em>
    </xsl:template>

    <!-- remove hyphens and line breaks if <lb> has break="no"-->
    <xsl:template match="text()[following-sibling::*[1][self::tei:lb[@break = 'no']]]">
            <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
</xsl:stylesheet>
