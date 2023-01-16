<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <!-- 2018-01-19: WA: prefer billing address (if available) over default (primary) address -->
  <!-- 2018-01-19: WA: show email address (adress line 4) only in OrderListLetters -->
  <!-- 2018-02-02: WA: user address: print lines containing address2 to address5 only if defined -->
  <!-- 2019-06-11: WA: sender: added email -->
  
  <xsl:template name="senderReceiver">
    <table cellspacing="0" cellpadding="5" border="0" width="100%">
      <tr>
        <td width="50%">
          
          <xsl:choose>
            <xsl:when test="notification_data/user_for_printing">
              <table cellspacing="0" cellpadding="5" border="0">
                <xsl:attribute name="style">
                  <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                </xsl:attribute>
                <tr><td><b><xsl:value-of select="notification_data/user_for_printing/name"/></b></td></tr>
                <tr><td><xsl:value-of select="notification_data/user_for_printing/address1"/></td></tr>
                <xsl:if test="notification_data/user_for_printing/address2!=''">
                  <tr><td><xsl:value-of select="notification_data/user_for_printing/address2"/></td></tr>
                </xsl:if>
                <xsl:if test="notification_data/user_for_printing/address3!=''">
                  <tr><td><xsl:value-of select="notification_data/user_for_printing/address3"/></td></tr>
                </xsl:if>
                <xsl:if test="notification_data/user_for_printing/address4!=''">
                  <tr><td><xsl:value-of select="notification_data/user_for_printing/address4"/></td></tr>
                </xsl:if>
                <xsl:if test="notification_data/user_for_printing/address5!=''">
                  <tr><td><xsl:value-of select="notification_data/user_for_printing/address5"/></td></tr>
                </xsl:if>
                <xsl:if test="notification_data/user_for_printing/city!=''">
                  <tr><td><xsl:value-of select="notification_data/user_for_printing/postal_code"/>
                      &#160;<xsl:value-of select="notification_data/user_for_printing/city"/></td></tr>
                  <!--tr><td><xsl:value-of select="notification_data/user_for_printing/state"/>&#160;<xsl:value-of select="notification_data/user_for_printing/country"/></td></tr-->
                  <xsl:if test="notification_data/user_for_printing/country!='AUT'">
                    <tr><td><xsl:value-of select="notification_data/user_for_printing/country"/></td></tr>
                  </xsl:if>
                </xsl:if>
              </table>
            </xsl:when>
            <xsl:when test="notification_data/receivers/receiver/user">
              <xsl:for-each select="notification_data/receivers/receiver/user">
                <table>
                  <xsl:attribute name="style">
                    <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                  </xsl:attribute>
                  <tr><td><b><xsl:value-of select="last_name"/>&#160;<xsl:value-of select="first_name"/></b></td></tr>
                  <tr><td><xsl:value-of select="user_address_list/user_address/line1"/></td></tr>
                  <tr><td><xsl:value-of select="user_address_list/user_address/line2"/></td></tr>
                  <xsl:if test="user_address_list/user_address/city!=''">
                    <tr><td><xsl:value-of select="user_address_list/user_address/postal_code"/>&#160;<xsl:value-of select="user_address_list/user_address/city"/></td></tr>
                    <xsl:if test="user_address_list/user_address/country!='AUT'">
                      <tr><td><xsl:value-of select="user_address_list/user_address/country"/></td></tr>
                    </xsl:if>
                  </xsl:if>
                  <!--tr><td><xsl:value-of select="user_address_list/user_address/state_province"/>&#160;<xsl:value-of select="user_address_list/user_address/country"/></td></tr-->
                  
                </table>
              </xsl:for-each>
              
            </xsl:when>
            <xsl:otherwise>
              
            </xsl:otherwise>
          </xsl:choose>
          
        </td>
        <td width="50%" align="right">
          <xsl:choose>
            <!-- force generic jku-address for overdue letters -->
            <xsl:when test="/notification_data/general_data/letter_type='FulOverdueAndLostLoanNotificationLetter'">
              <table>
                <xsl:attribute name="style">
                  <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                </xsl:attribute>
                <xsl:choose>
                  <xsl:when test="/notification_data/general_data/letter_name='Mahnung'">
                    <tr><td>Johannes Kepler Universität Linz<br/>Universitätsbibliothek</td></tr>
                  </xsl:when>
                  <xsl:otherwise>
                    <tr><td>Johannes Kepler University Linz<br/>University Library</td></tr>
                  </xsl:otherwise>
                </xsl:choose>
                <tr><td>Altenberger Straße 69</td></tr>
                <tr><td>A-4040 Linz</td></tr>
              </table>
            </xsl:when>
            <xsl:otherwise>
              <!-- prefer billing address over default address -->
              <xsl:choose>
                <xsl:when test="/notification_data/po/bill_to_address">
                  <xsl:for-each select="notification_data/po/bill_to_address">
                    <table>
                      <xsl:attribute name="style">
                        <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                      </xsl:attribute>
                      <tr><td><xsl:value-of select="line1"/></td></tr>
                      <tr><td><xsl:value-of select="line2"/></td></tr>
                      <tr><td><xsl:value-of select="line3"/></td></tr>
                      <!-- email address only with OrderListLetters -->
                      <xsl:if test="/notification_data/general_data/letter_type='OrderListLetter'">
                        <tr><td><xsl:value-of select="line4"/></td></tr>
                      </xsl:if>
                      <tr><td><xsl:value-of select="postal_code"/>&#160;<xsl:value-of select="city"/></td></tr>
                      <tr><td><xsl:value-of select="country_display"/></td></tr>
                    </table>
                  </xsl:for-each>
                </xsl:when>
                <xsl:when test="/notification_data/organization_unit/address=''">
                  <xsl:for-each select="/notification_data/library">
                    <table>
                      <xsl:attribute name="style">
                        <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                      </xsl:attribute>
                      <xsl:comment>Hack Herwig</xsl:comment>
                      <xsl:if test="name != address/line1">
                        <tr><td><xsl:value-of select="name"/></td></tr>
                      </xsl:if>
                      <xsl:if test="address/line1!=''">
                        <tr><td><xsl:value-of select="address/line1"/></td></tr>
                      </xsl:if>
                      <xsl:if test="address/line2!=''">
                        <tr><td><xsl:value-of select="address/line2"/></td></tr>
                      </xsl:if>
                      <xsl:if test="address/line3!=''">
                        <tr><td><xsl:value-of select="address/line3"/></td></tr>
                      </xsl:if>
                      <!--xsl:if test="address/line4!=''">
                           <tr><td><xsl:value-of select="address/line4"/></td></tr>
                           </xsl:if-->
                      <!--tr><td><xsl:value-of select="address/city"/></td></tr-->
                      <!--tr><td><xsl:value-of select="address/postal_code"/></td></tr-->
                      <!--tr><td><xsl:value-of select="address/country"/></td></tr-->
                    </table>
                  </xsl:for-each>
                  
                </xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select="notification_data/organization_unit">
                    <table>
                      <xsl:attribute name="style">
                        <xsl:call-template name="listStyleCss" /> <!-- style.xsl -->
                      </xsl:attribute>
                      <xsl:if test="name != address/line1">
                        <tr><td><xsl:value-of select="name"/></td></tr>
                      </xsl:if>
                      <xsl:if test="address/line1!=''">
                        <tr><td><xsl:value-of select="address/line1"/></td></tr>
                      </xsl:if>
                      <xsl:if test="address/line2!=''">
                        <tr><td><xsl:value-of select="address/line2"/></td></tr>
                      </xsl:if>
                      <xsl:if test="address/line3!=''">
                        <tr><td><xsl:value-of select="address/line3"/></td></tr>
                      </xsl:if>
                      <xsl:if test="address/city!=''">
                        <tr><td><xsl:value-of select="address/postal_code"/>&#160;<xsl:value-of select="address/city"/></td></tr>
                      </xsl:if>
                      <xsl:if test="email">
                        <tr><td><xsl:value-of select="email/email"/></td></tr>
                      </xsl:if>
                      <!--tr><td><xsl:value-of select="address/city"/></td></tr-->
                      <!--tr><td><xsl:value-of select="address/postal_code"/></td></tr-->
                      <!--tr><td><xsl:value-of select="address/country"/></td></tr-->
                    </table>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </td>
      </tr>
    </table>
  </xsl:template>
</xsl:stylesheet>