# needed extensions
* XSLT/XPath for Visual Studie Code (DeltaXML)
* Command Variable (convinient Tasks)
## useful extensions
* Live Preview
* Thunder Client
* Encode Decode
* XML (RedHat) (better code formater for XML than DeltaXML; no additional newlines created)

# TODO on initialization
* git clone
* npm init -y
* npm install --save-dev xslt3
* create directory xml and download xml for letter here
* Download your own letters to xsl_xml\
under /diverses is an excel file for generating cURL commands for letter and labels
  * notice for Windows (Powershell):\
  `del alias:curl`\
  `new-alias -name curl -value curl.exe`\
afterwards the generated links of the excel work also for windows.

# usage
* edit letter (xsl_xml/...)
* `Task:Run setenv` set labels- and xml-file
* `Task:Run render` generates all components and the html output\
`Task:Run render2` if not encoded (works also with encoded)
