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
                    <xsl:apply-templates select="//tei:titleStmt/tei:title"/>: Diplomatic View
                </title>
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
                    <a href="index.html">Hem</a> |
                    <a href="diplomatic.html">Diplomatarisk transkription</a> |
                    <a href="reading.html">Lästext</a> |
                </nav>
                <main id="manuscript">
                    <!-- bootstrap "container" class makes the columns look pretty -->
                    <div class="container">
                    <!-- define a row layout with bootstrap's css classes (two columns with content, and an empty column in between) -->
                        <div class="row">
                            <div class="col-sm">
                                <h3>Bilder</h3>
                            </div>
                            <div class="col-sm">
                            </div>
                            <div class="col-sm">
                                <h3>Transkription</h3>
                            </div>
                        </div>
                        <!-- set up an image-text pair for each page in your document, and start a new 'row' for each pair -->
                        <xsl:for-each select="//tei:div[@type='page']">
                            <!-- save the value of each page's @facs attribute in a variable, so we can use it later -->
                            <xsl:variable name="facs" select="@facs"/>
                            <div class="row">
                                <!-- fill the first column with this page's image -->
                                <div class="col-sm">
                                        <!-- make an HTML <img> element, with a maximum width of 400 pixels -->
                                    <div class="click-zoom">
                                        <label>
                                            <input type="checkbox"/>
                                            <img class="img-full">
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
                                            
                                            <!-- create an id for each image, so that other pages can link to a specific image --> 
                                            <!-- <xsl:attribute name="id">
                                                <xsl:value-of select="replace(//tei:surface[@xml:id=substring-after($facs, '#')]/tei:figure/tei:label, ' ', '')"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:figure/tei:graphic[1]/@url"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="title">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:figure/tei:label"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="alt">
                                                <xsl:value-of select="//tei:surface[@xml:id=substring-after($facs, '#')]/tei:figure/tei:figDesc"/>
                                            </xsl:attribute> -->
                                            <xsl:attribute name="id">
                                                <!-- <xsl:value-of select="replace(//tei:surface[@xml:id=$facs]/tei:figure/tei:label, ' ', '')"/> -->
                                                <xsl:value-of select="$facs"/>
                                            </xsl:attribute>
                                            <xsl:attribute name="src">
                                                <xsl:value-of
                                                    select="//tei:surface[@xml:id = $facs]/tei:figure/tei:graphic[1]/@url"
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
                                        </label>
                                    </div>
                                </div>
                                <!-- fill the second column with our transcription -->
                                <div class='col-sm'>
                                        <!-- add page numbers -->
                                    <p>[<xsl:value-of select="//tei:surface[@xml:id = $facs]/tei:figure/tei:label"/>]</p>
                                        <xsl:apply-templates/>                                      
                                </div>
                            </div>
                        </xsl:for-each>
                        </div>
                </main>
                <footer>
                <div class="row" id="footer">
                  <div class="col-sm copyright">
                      <div>
                        <a href="https://creativecommons.org/licenses/by/4.0/legalcode">
                          <img src="assets/img/logos/cc.svg" class="copyright_logo" alt="Creative Commons License"/><img src="assets/img/logos/by.svg" class="copyright_logo" alt="Attribution 4.0 International"/>
                        </a>
                      </div>
                      <div>
                         2025 Emilia, Peeter och Rebecca.
                      </div>
                    </div>
                </div>
                </footer>
<!--                <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script> -->
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
        
    <!-- turn tei linebreaks (lb) into html linebreaks (br) -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <!-- note: in the previous template there is no <xsl:apply-templates/>. This is because there is nothing to
    process underneath (nested in) tei lb's. Therefore the XSLT processor does not need to look for templates to
    apply to the nodes nested within it.-->
    
    <!-- turn <lb rend="something"> into <span class="something"> after linebreak-->
    <xsl:template match="tei:lb[@rend='indent']">
        <br/><span class="indent" />
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
            <xsl:apply-templates/>
        </sup>
    </xsl:template>
    
    <!-- transform tei unclear to brackets -->
    <xsl:template match="tei:unclear">
        [<xsl:apply-templates/>]?
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
    
    <!-- make delSpan into a span with class delSpan - a bit of a kludge, but works -->
    <xsl:template match="tei:delSpan">
        <xsl:text disable-output-escaping="yes">&lt;span class="delSpan"&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:anchor">
        <xsl:text disable-output-escaping="yes">&lt;/span&gt;</xsl:text>
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
