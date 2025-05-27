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
                    <xsl:apply-templates select="//tei:titleStmt/tei:title"/>: diplomatarisk transkription
                </title>
                <!-- load the stylesheets in the assets/css folder, where you can modify the styling of your website -->
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet"/>
                <link rel="stylesheet" href="../assets/css/main.css"/>
                <link rel="shortcut icon" type="image/x-icon" href="../favicon.png"/>
            </head>
            <body>
                <header>
                    <div id="header">
                        <a href="https://aarkiv.se"><img src="../assets/img/logos/AArkiv%20Logga.png.jpg" title="Arbetarrörelsens arkiv i Skåne" alt="Logga för Arbetarrörelsens arkiv i Skåne" class="logga"/></a>
                        <a href="../index.html"><img src="../assets/img/Elma_fyrkant.png" title="Elma Danielsson 1911" alt="Elma Danielsson 1911" class="elma"/></a>
                        <h1><xsl:apply-templates select="//tei:titleStmt/tei:title"/></h1>
                    </div>
                    <div id="sitenav">
                        <a href="../index.html">Elma Danielssons tal</a> 
                        <a href="diplomatic.html" class="active">Diplomatarisk transkription</a>
                        <a href="text.html">Text</a>
                        <a href="index.html">Bilder</a>
                    </div>
                </header>
                <main id="manuscript">
                    <!-- bootstrap "container" class makes the columns look pretty -->
                    <div class="container">
                        <div class="diplomatic">
                            
                        <!-- set up an image-text pair for each page in your document, and start a new 'row' for each pair -->
                        <xsl:for-each select="//tei:div[ends-with(@n, 'r')]">
                            <!-- <xsl:for-each select="//tei:div[@type='page']"> -->
                            <!-- <xsl:sort select="[@n]"/> <!- to sort on page numbers as they are entered with recto pages first in the tei document -->
                            <!-- save the value of each page's @facs attribute in a variable, so we can use it later -->
                            <xsl:variable name="facs" select="@facs"/>
                            <xsl:variable name="facspreceding" select="preceding::tei:div[1]/@facs"/>
                            
                            <div class="row">
                                <!-- fill the first column with this page's image -->
                                <div class="col-sm">
                                    <xsl:if test="//tei:surface[@xml:id = $facspreceding]/tei:figure/tei:graphic[1]/@url">
                                        <a>
                                            <!-- tif format https://archive.org/download/aa-001964-f-v-elma-danielsson-a-1/AA001964_F_V_Elma_Danielsson_A1_Tal_Nora_1910/AA001964_F_V_Elma_Danielsson_A1_Tal_Nora_1910_sida01.tif -->
                                            <xsl:attribute name="href">
                                                <xsl:text>https://archive.org/download/aa-001964-f-v-elma-danielsson-a-1/</xsl:text>
                                                <xsl:value-of select="//tei:facsimile/@xml:id"/>
                                                <xsl:text>_</xsl:text>
                                                <xsl:value-of select="$facspreceding"/>
                                                <xsl:text>.tif</xsl:text>
                                            </xsl:attribute>
                                            <xsl:attribute name="target">
                                                <xsl:text>_blank</xsl:text>
                                            </xsl:attribute>
                                        <img class="img-full">
                                            <xsl:attribute name="id">
                                                <xsl:value-of select="$facspreceding"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="//tei:surface[@xml:id=$facspreceding]/tei:figure/tei:graphic[1]/@url"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="title">
                                                <xsl:value-of select="//tei:titleStmt/tei:title"/> – <xsl:value-of select="//tei:surface[@xml:id = $facspreceding]/tei:figure/tei:label"/> - Klicka för bild i full storlek.
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:value-of select="//tei:surface[@xml:id=$facspreceding]/tei:figure/tei:figDesc"/>
                                            </xsl:attribute>
                                        </img>
                                        </a>
                                        <!-- add page numbers -->
                                        <p class="pagenumber">[<xsl:value-of select="//tei:surface[@xml:id=$facspreceding]/tei:figure/tei:label"/>]</p>
                                    </xsl:if>
                                </div>
                                
                                <div class="col-sm">
                                    <!-- make an HTML <img> element, with a maximum width of 400 pixels -->
                                    <a>
                                        <!-- tif format https://archive.org/download/aa-001964-f-v-elma-danielsson-a-1/AA001964_F_V_Elma_Danielsson_A1_Tal_Nora_1910/AA001964_F_V_Elma_Danielsson_A1_Tal_Nora_1910_sida01.tif -->
                                        <xsl:attribute name="href">
                                            <xsl:text>https://archive.org/download/aa-001964-f-v-elma-danielsson-a-1/</xsl:text>
                                            <xsl:value-of select="//tei:facsimile/@xml:id"/>
                                            <xsl:text>_</xsl:text>
                                            <xsl:value-of select="$facs"/>
                                            <xsl:text>.tif</xsl:text>
                                        </xsl:attribute>
                                        <xsl:attribute name="target">
                                            <xsl:text>_blank</xsl:text>
                                        </xsl:attribute>
                                    <img class="img-full">
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="$facs"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="src">
                                            <xsl:value-of select="//tei:surface[@xml:id = $facs]/tei:figure/tei:graphic[1]/@url"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="title">
                                            <xsl:value-of select="//tei:titleStmt/tei:title"/> – <xsl:value-of select="//tei:surface[@xml:id = $facs]/tei:figure/tei:label"/> - Klicka för bild i full storlek.
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:value-of select="//tei:surface[@xml:id=$facs]/tei:figure/tei:figDesc"/>
                                        </xsl:attribute>
                                    </img>
                                    </a>
                                    <!-- add page numbers -->
                                    <p class="pagenumber">[<xsl:value-of select="//tei:surface[@xml:id=$facs]/tei:figure/tei:label"/>]</p>
                                </div>
                            </div>
                                
                            <div class="row">    
                                <div class='col-sm'>
                                    <xsl:apply-templates select="preceding::tei:div[1]"/>
                                </div>
                                <div class='col-sm'>
                                    <xsl:apply-templates/>
                                </div>
                            </div>
                        </xsl:for-each>
                        
                        <!-- check if there is a last left page -->
                        <xsl:if test="//tei:div[last()][@type='page'][ends-with(@n, 'v')]">
                            <xsl:variable name="facs" select="//tei:div[last()]/@facs"/>
                            <div class="row">
                                <div class="col-sm">
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:text>https://archive.org/download/aa-001964-f-v-elma-danielsson-a-1/</xsl:text>
                                            <xsl:value-of select="//tei:facsimile/@xml:id"/>
                                            <xsl:text>_</xsl:text>
                                            <xsl:value-of select="$facs"/>
                                            <xsl:text>.tif</xsl:text>
                                        </xsl:attribute>
                                        <xsl:attribute name="target">
                                            <xsl:text>_blank</xsl:text>
                                        </xsl:attribute>
                                    <img class="img-full">
                                        <xsl:attribute name="id">
                                            <xsl:value-of select="$facs"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="src">
                                            <xsl:value-of select="//tei:surface[@xml:id= $facs]/tei:figure/tei:graphic[1]/@url"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="title">
                                            <xsl:value-of select="//tei:titleStmt/tei:title"/> – <xsl:value-of select="//tei:surface[@xml:id=$facs]/tei:figure/tei:label"/> - Klicka för bild i full storlek.
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">
                                            <xsl:value-of select="//tei:surface[@xml:id=$facs]/tei:figure/tei:figDesc"/>
                                        </xsl:attribute>
                                    </img>
                                    </a>
                                    <!-- add page numbers -->
                                    <p class="pagenumber">[<xsl:value-of select="//tei:surface[@xml:id=$facs]/tei:figure/tei:label"/>]</p>
                                </div>
                                <div class="col-sm"/>
                            </div>
                            <div class="row">
                                <div class="col-sm">
                                    <xsl:apply-templates select="//tei:div[last()][@type='page'][ends-with(@n, 'v')]"/>
                                </div>
                                <div class="col-sm"/>
                            </div>
                        </xsl:if>
                        </div>
                        
                        <div class="row">
                            <div class="col-sm">
                                <p>
                                    <b>Författare:</b>
                                    <br/>
                                    <xsl:apply-templates select="//tei:titleStmt/tei:author"/>
                                </p>
                            </div>
                            <div class="col-sm">
                                <p>
                                    <b>Transkriberat av:</b>
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

    <!-- we turn the tei head element (headline) into an html h2 element-->
    <xsl:template match="tei:head">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    
    <!-- transform tei paragraphs into html paragraphs -->
    <xsl:template match="tei:p">
        <p>
            <xsl:choose>
                <xsl:when test="@rend">
                    <xsl:attribute name="class">
                        <xsl:value-of select="@rend"/>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- transform tei lg into html paragraphs -->
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
        <span class="indent">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- turn tei linebreaks (lb) into html linebreaks (br) -->
    <xsl:template match="tei:lb">
        <xsl:choose>
            <!-- if immediately preceded by <p>, do not add linebreak, so as not to get double linebreaks -->
            <xsl:when test="count(preceding-sibling::tei:lb) = 0 and local-name(parent::*) = 'p'"/>
            <xsl:otherwise>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
        <span class="linenumber">
            [<xsl:number level="any" from="tei:div[@type='page']" format="01"/>]
        </span>
        <!-- if there are @rend-attributes, add them as a class -->
        <xsl:if test="@rend">
            <span>
                <xsl:attribute name="class">
                    <xsl:value-of select="@rend"/>
                </xsl:attribute>
            </span>
        </xsl:if>
    </xsl:template>
    
    <!-- transform tei del into html del -->
    <xsl:template match="tei:del">
        <del>
            <xsl:apply-templates/>
        </del>
    </xsl:template>

    <!-- transform tei add into html sup -->
    <xsl:template match="tei:add">
        <sup>
            <xsl:if test="@rend">
                <xsl:attribute name="class">
                    <xsl:value-of select="@rend"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    
    <!-- transform tei unclear to brackets -->
    <xsl:template match="tei:unclear"><span class="unclear"><xsl:apply-templates/></span>
    </xsl:template>
    
    <!-- transform tei emph into underlines -->
    <xsl:template match="tei:emph">
        <u>
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    
    <!-- transform tei emph into double underlines-->
    <xsl:template match="tei:emph[@rend='double']">
        <u class="double">
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    
    <!-- transform tei emph into triple underlines-->
    <xsl:template match="tei:emph[@rend='triple']">
        <u class="triple">
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    
    <!-- add sidenotes -->
    <xsl:template match="tei:note">
        <xsl:if test="starts-with(@type, 'text')">
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
    
    <!-- transform tei handShift into html spans -->
    <xsl:template match="tei:handShift[@medium='pencil']">
        <xsl:text disable-output-escaping="yes">&lt;span class="pencil"&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:handShift[@medium='ink']">
        <xsl:text disable-output-escaping="yes">&lt;span class="ink"&gt;</xsl:text>
    </xsl:template>
    
    <!-- do not show expanded abbreviations -->
     <xsl:template match="tei:expan" />

    <!-- do not show regularized spellings -->
    <xsl:template match="tei:reg" />
    
    <!-- do not show editorial corrections -->
    <xsl:template match="tei:corr" />
    
    <!-- do not show editorially supplied amendments -->
    <xsl:template match="tei:supplied" />
    
</xsl:stylesheet>
