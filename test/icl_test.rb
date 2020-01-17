require_relative '../lib/icl.rb'
require "minitest/autorun"

class IclTest < Minitest::Test
  def test_transform_an_xml_using_one_stylesheet
    xml = <<~XML
      <?xml version="1.0"?>
      <name>
        <title>Dr.</title>
        <first>John</first>
        <last>Smith</last>
      </name>
    XML

    stylesheet = <<~XSLT
      <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

        <xsl:template match="name">
          <name>
            <xsl:copy-of select="title"/>
            <full><xsl:value-of select="concat(first, ' ', last)"/></full>
          </name>
        </xsl:template>

      </xsl:stylesheet>
    XSLT

    output = <<~XML
      <?xml version="1.0"?>
      <name>
        <title>Dr.</title>
        <full>John Smith</full>
      </name>
    XML

    assert_equal output, Icl.transform_from_strings(xml, stylesheet).to_s
  end

  def test_transform_an_xml_using_multiple_transforms
    xml = <<~XML
      <?xml version="1.0"?>
      <name>
        <title>Dr.</title>
        <first>John</first>
        <last>Smith</last>
      </name>
    XML

    stylesheet_1 = <<~XSLT
      <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

        <xsl:template match="name">
          <name>
            <full><xsl:value-of select="concat(first, ' ', last)"/></full>
            <xsl:copy-of select="title"/>
          </name>
        </xsl:template>

      </xsl:stylesheet>
    XSLT


    stylesheet_2 = <<~XSLT
      <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

        <xsl:template match="name">
          <name><xsl:value-of select="concat(title, ' ', full)"/></name>
        </xsl:template>

      </xsl:stylesheet>
    XSLT

    output = <<~XML
      <?xml version="1.0"?>
      <name>Dr. John Smith</name>
    XML

    assert_equal output, Icl.transform_from_strings(xml, stylesheet_1, stylesheet_2).to_s
  end
end
