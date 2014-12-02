<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" indent="yes"/>
    
    
    <!-- gestion de la map -->
    <xsl:template match="map">
        <project name="DITA_to_hdoc" default="convert">
            <target name="convert">
            <xsl:apply-templates select="topic"></xsl:apply-templates>
            </target>
        </project>
    </xsl:template>
    
    <xsl:template match="topic">
        <xsl:apply-templates select="concept/conbody/p/image"/>
        <xsl:apply-templates select="task/conbody/p/image"/>
    </xsl:template>
    
    
    <xsl:template match="image">
        
        
        <!-- gestion de la position du fichier actuel -->
        
        <xsl:variable name="p1" select="../../../../@dir"></xsl:variable>
        <xsl:variable name="p2" select="@href"></xsl:variable>
        <xsl:variable name="p3" select="'/'"></xsl:variable>
        <xsl:variable name="p4" select="concat($p3,$p2)"></xsl:variable>
        
        
        <!-- gestion du nom du fichier -->
        <xsl:variable
            name="asupr"
            select="'/'">        
        </xsl:variable>
        
        <copy file="{concat($p1,$p4)}" tofile="src/{translate(@href,$asupr,'')}"/>
      
          
    </xsl:template>
   
</xsl:stylesheet>