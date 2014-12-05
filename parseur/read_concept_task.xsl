<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:param name="basedir" required="yes" as="xs:string"/>
    
    <!-- gestion de la map -->
     <xsl:template match="map">
       <xsl:text disable-output-escaping="yes"><![CDATA[<?xml-model href="http://ics.utc.fr/hdoc/schemas/xhtml/hdoc1-xhtml.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"?>]]></xsl:text>
            <html xmlns="http://www.utc.fr/ics/hdoc/xhtml">
            <head>
                <title><xsl:value-of select="@title"></xsl:value-of></title>
                <meta charset="utf-8"/>
                <meta name="generator" content="SimpleChain"/>
            </head>
            <body>
                <section>
                    <header>
                        <h1><xsl:value-of select="@title"/></h1>
                    </header>
                    <xsl:apply-templates select="topic/concept"/>
                    <xsl:apply-templates select="topic/task"/>
                </section>
               
            </body>
        </html>
    </xsl:template>
    
    <!-- gestion des concepts -->
    <xsl:template match="concept">
        <section data-hdoc-type="unit-of-content">
            <header>
                <h1><xsl:value-of select="title"></xsl:value-of></h1>
            </header>
            
                <xsl:apply-templates select="conbody"/>

            <!-- gestion des références -->
            
                <xsl:apply-templates select="related-links"/>
        </section>
    </xsl:template>
    
    <!-- gestion des paragraphes -->
    
    <xsl:template match="p">
        <!-- paragraphe basique -->
        <xsl:if test="not(*)">
            <div><p><xsl:value-of select="."/></p></div>
        </xsl:if>
        
        <!-- paragraphe contenant une image ou un prérequis -->
        <xsl:apply-templates select="image"></xsl:apply-templates>
        <xsl:apply-templates select="prereq"></xsl:apply-templates>
        
    </xsl:template>
    
    
    
    <!-- image -->
    <xsl:variable
        name="asupr"
        select="'/'">        
    </xsl:variable>
    <xsl:template match="image">
        <div>
            <img src="src/{translate(@href,$asupr,'')}" alt="{@alt}"/>
        </div>
    </xsl:template>
    
    <!-- liens -->
    
    <xsl:template match="related-links">
        <div>
            <h6>Related Concepts</h6>
            <p>
                <xsl:apply-templates select="link"></xsl:apply-templates>
            </p>
        </div>
    </xsl:template>
    
    <xsl:template match="link">
       - <xsl:value-of select="linktext"></xsl:value-of>
    </xsl:template>
    
    <!-- exemple -->
    <xsl:template match="example">
        <div>
            <h6>Exemple : </h6>
            <p><xsl:value-of select="p"></xsl:value-of></p>
        </div>
      
    </xsl:template>
    
    
    
    
    <!-- gestion des tasks -->
    
    <xsl:template match="task">
        <section data-hdoc-type="unit-of-content">
            <header>
                <h1><xsl:value-of select="title"></xsl:value-of></h1>
            </header>
            <xsl:apply-templates select="taskbody"/>
           
            
            <!-- gestion des références -->
            
            <xsl:apply-templates select="related-links"/>
        </section>
    </xsl:template>
    
    <!-- listes -->
    
    <xsl:template match="steps">
        <div>
            <ol>
            <xsl:apply-templates select="step"></xsl:apply-templates>
            </ol>
        </div>
    </xsl:template>
    
    <xsl:template match="step">
            <li>
                <p><xsl:apply-templates select="cmd"></xsl:apply-templates></p>
            </li>
    </xsl:template>
    
    <!-- prerequis -->
    <xsl:template match="prereq">
        <div>
            <xsl:apply-templates select="note"></xsl:apply-templates>
        </div>
    </xsl:template>
    
    
    <!-- note -->
    <xsl:template match="note">
        <h6>
            <xsl:value-of select="@type"></xsl:value-of>:
        </h6>
        <p><xsl:value-of select="p"></xsl:value-of></p>
    </xsl:template>
    
    <!-- contexte -->
    <xsl:template match="context">
        <div>
            <p>
                <i>
                    <xsl:value-of select="p"></xsl:value-of>
                </i>
            </p>
        </div>
    </xsl:template>
    
    
    
</xsl:stylesheet>