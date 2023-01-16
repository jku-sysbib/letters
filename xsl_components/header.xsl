<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- 2018-10-17: WA: addidtional tag after letter_name for certain letter types -->
  <!-- 2018-02-02: WA: Bei Mahnbriefen Ueberschrift nicht h1, sondern nur bold (wegen Sichtfenster bei Briefen fuer Mahnstufe 3) -->
  <!-- 2018-02-02: WA: Mehr Abstand rund um Adresse (Sichtfenster) -->
  
  <xsl:template name="head">
    <!--div style='visibility:hidden'>
         Letter_type:
         <xsl:value-of select="letter_type" />
         </div-->
    <xsl:comment>Letter_type: <xsl:value-of select="/notification_data/general_data/letter_type" /></xsl:comment>
    <table cellspacing="0" cellpadding="5" border="0">
      <xsl:attribute name="style">
        <xsl:call-template name="headerTableStyleCss" /> <!-- style.xsl -->
      </xsl:attribute>
      <!-- LOGO INSERT -->
      <tr>
        <xsl:attribute name="style">
          <xsl:call-template name="headerLogoStyleCss" /> <!-- style.xsl -->
        </xsl:attribute>
        <td colspan="2">
          <div id="mailHeader">
            <div id="logoContainer" class="alignLeft">
              <img src="cid:logo.jpg" alt="Johannes Kepler University" />
            </div>
          </div>
        </td>
      </tr>
      <!-- END OF LOGO INSERT -->
      <tr>
        
        <xsl:for-each select="notification_data/general_data">
          
          <!-- for certain letter types: add tag -->
          <xsl:variable name="letter_name_addtag">
            <xsl:choose>
              <!-- letter type is FulReasourceRequestSlipLetter -->
              <xsl:when test='letter_type="FulReasourceRequestSlipLetter"'>
                <!-- notification_data/operator_user_name = System: Aushebezettel, else: Fernleihe or Bereitstellung -->
                <xsl:choose>
                  <xsl:when test='/notification_data/operator_user_name="System"'>
                    Aushebezettel
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- if section with email-data: Fernleihbestellung, else: Aushebezettel -->
                    <xsl:choose>
                      <xsl:when test='/notification_data/organization_unit/email/create_date'>
                        Fernleihbestellung
                      </xsl:when>
                      <xsl:otherwise>
                        Bereitstellung
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <!-- all other letter types: no additional tag -->
              <xsl:otherwise>
                <xsl:text />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          
          <td>
            <xsl:choose>
              <xsl:when test='letter_type="FulOverdueAndLostLoanNotificationLetter"'>
                <b>
                  <xsl:value-of select="letter_name" />
                  <xsl:if test="$letter_name_addtag != ''">
                    &#160;-&#160;
                    <xsl:value-of select="normalize-space($letter_name_addtag)" />
                  </xsl:if>
                </b>
              </xsl:when>
              <xsl:otherwise>
                <h1>
                  <xsl:value-of select="letter_name" />
                  <xsl:if test="$letter_name_addtag != ''">
                    &#160;-&#160;
                    <xsl:value-of select="normalize-space($letter_name_addtag)" />
                  </xsl:if>
                </h1>
              </xsl:otherwise>
            </xsl:choose>
          </td>
          <td align="right">
            <xsl:value-of select="current_date" />
          </td>
        </xsl:for-each>
        
      </tr>
    </table>
    
    
  </xsl:template>
  
</xsl:stylesheet>