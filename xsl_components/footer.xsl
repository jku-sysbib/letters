<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:template name="salutation">
		
	</xsl:template>
	<xsl:template name="lastFooter">
		<table>
			<xsl:attribute name="style">
				<xsl:call-template name="footerTableStyleCss" /> <!-- style.xsl -->
			</xsl:attribute>
			<tr>
				<xsl:for-each select="notification_data/organization_unit">
					
					<xsl:attribute name="style">
						<xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
					</xsl:attribute>
					<td align="center">
						<!--HW Wenn assigned_unit_name vorhanden ist soll dieser angezeigt werden und sonst der name-->
						<!--HW assigned_unit_name auf calculated_destination_name geändert, da bei Fernleihe physical non-returnable nur dieses Feld befüllt ist.-->
						<xsl:choose >
							<xsl:when test="/notification_data/request/calculated_destination_name">
								<xsl:value-of select="/notification_data/request/calculated_destination_name"/>
							</xsl:when>
							<xsl:otherwise><xsl:value-of select="name"/></xsl:otherwise>
						</xsl:choose> &#160;<xsl:value-of select="line1"/>&#160;<xsl:value-of select="line2"/>&#160;<xsl:value-of select="city"/>&#160;<xsl:value-of select="postal_code"/>&#160;<xsl:value-of select="country"/></td>
					
				</xsl:for-each>
			</tr>
		</table>
	</xsl:template>
	<xsl:template name="contactUs">
		<table align="left">
			<tr>
				<td align="left">
					<a>
						<xsl:attribute name="href">
							@@email_contact_us@@
						</xsl:attribute>
						@@contact_us@@
					</a>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template name="myAccount">
		<table align="right">
			<tr>
				<td align="right">
					<a>
						<xsl:attribute name="href">
							@@email_my_account@@
						</xsl:attribute>
						@@my_account@@
					</a>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	
	
</xsl:stylesheet>