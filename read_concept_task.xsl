<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    
    <!-- gestion de la map -->
    
    <xsl:template match="map">
        <html xmlns="http://www.utc.fr/ics/hdoc/xhtml">
            <head>
                <title><xsl:value-of select="@title"></xsl:value-of></title>
                <meta charset="utf-8"/>
                <meta name="generator" content="DITA_to_Hdoc"/>
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
        <section data-hdoc-type="OpaleUc">
            <header>
                <h1><xsl:value-of select="title"></xsl:value-of></h1>
            </header>
            <div>
                <xsl:apply-templates select="conbody"/>
            </div>
            
            <!-- gestion des références -->
            
                <xsl:apply-templates select="related-links"/>
        </section>
    </xsl:template>
    
    <!-- gestion des paragraphes -->
    <xsl:template match="p">
        <p><xsl:apply-templates></xsl:apply-templates></p>
    </xsl:template>
    
    <!-- image -->
    <xsl:variable
        name="asupr"
        select="'/'">        
    </xsl:variable>
    <xsl:template match="image"><img src="src/{translate(@href,$asupr,'')}" alt="{@alt}"/></xsl:template>
    
    <!-- liens -->
    
    <xsl:template match="related-links">
        <div>
            <p>
                <h3>Related Concepts</h3>
            </p>
            <p>
                <xsl:apply-templates select="link"></xsl:apply-templates>
            </p>
        </div>
    </xsl:template>
    
    <xsl:template match="link">
        <a href="{@href}"><xsl:value-of select="linktext"></xsl:value-of></a>
    </xsl:template>
    
    <!-- exemple -->
    <xsl:template match="example">
        <br/>
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
    
    
    
    
    <!-- gestion des tasks -->
    
    <xsl:template match="task">
        <section data-hdoc-type="OpaleUc">
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
                <xsl:apply-templates select="cmd"></xsl:apply-templates>
            </li>
    </xsl:template>
    
    <!-- prerequis -->
    <xsl:template match="prereq">
        <div>
            <xsl:apply-templates></xsl:apply-templates>
        </div>
    </xsl:template>
    
    
    <!-- note -->
    <xsl:template match="note">
        <h6>
            <xsl:value-of select="@type"></xsl:value-of>:
            <xsl:apply-templates></xsl:apply-templates>
        </h6>
    </xsl:template>
    
    <!-- contexte -->
    <xsl:template match="context">
        <div>
            <i>
                <xsl:apply-templates></xsl:apply-templates>
            </i>
        </div>
    </xsl:template>
    
    
    
</xsl:stylesheet>