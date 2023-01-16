<?xml version="1.0" encoding="utf-8"?>
<!-- 2017-11-20: WA: inserted xsl-choose to be able to also handle letters that don't contain receivers/receiver/user/last_name -->
<!-- 2017-11-20: WA: added first_name to last_name -->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	
	<xsl:template name="toWhomIsConcerned">
		<table cellspacing="0" cellpadding="5" border="0">
			<tr>
				<td>
					<xsl:for-each select="notification_data">
						<xsl:choose>
							<xsl:when test="receivers/receiver/user">
								<h3>@@dear@@ &#160;<xsl:value-of select="receivers/receiver/user/first_name"/>&#160;<xsl:value-of select="receivers/receiver/user/last_name"/></h3>
							</xsl:when>
							<xsl:when test="user_for_printing/name">
								<h3>@@dear@@ &#160;<xsl:value-of select="user_for_printing/name"/></h3>
							</xsl:when>
							<xsl:otherwise>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
				</td>
			</tr>
		</table>
		
		
	</xsl:template>
	
</xsl:stylesheet>