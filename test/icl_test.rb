require_relative '../lib/icl.rb'
require "minitest/autorun"

class IclTest < Minitest::Test
  def test_transform_an_event_using_one_transform
    event = <<~XML
      <?xml version="1.0"?>
      <name>
        <title>Dr.</title>
        <first>John</first>
        <last>Smith</last>
      </name>
    XML

    transform = <<~XSLT
      <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

        <xsl:template match="name">
          <name>
            <xsl:copy-of select="title"/>
            <full><xsl:value-of select="concat(first, ' ', last)"/></full>
          </name>
        </xsl:template>

      </xsl:stylesheet>
    XSLT

    document = <<~XML
      <?xml version="1.0"?>
      <name>
        <title>Dr.</title>
        <full>John Smith</full>
      </name>
    XML

    assert_equal document, Icl.generate_from_strings(event, transform).to_s
  end

  def test_transform_an_event_using_multiple_transforms
    event = <<~XML
      <?xml version="1.0"?>
      <name>
        <title>Dr.</title>
        <first>John</first>
        <last>Smith</last>
      </name>
    XML

    transform_1 = <<~XSLT
      <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

        <xsl:template match="name">
          <name>
            <full><xsl:value-of select="concat(first, ' ', last)"/></full>
            <xsl:copy-of select="title"/>
          </name>
        </xsl:template>

      </xsl:stylesheet>
    XSLT


    transform_2 = <<~XSLT
      <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

        <xsl:template match="name">
          <name><xsl:value-of select="concat(title, ' ', full)"/></name>
        </xsl:template>

      </xsl:stylesheet>
    XSLT

    document = <<~XML
      <?xml version="1.0"?>
      <name>Dr. John Smith</name>
    XML

    assert_equal document, Icl.generate_from_strings(event, transform_1, transform_2).to_s
  end
end
