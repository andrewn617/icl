require_relative '../lib/icl.rb'
require "minitest/autorun"

class IclTest < Minitest::Test
  def test_transform_an_event_using_one_transform
    event = <<~XML
      <?xml version="1.0"?>
      <name>
        <first>John</first>
        <last>Smith</last>
      </name>
    XML

    transform = <<~XSLT
      <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

        <xsl:template match="name">
          <name><xsl:value-of select="concat(first, ' ', last)"/></name>
        </xsl:template>

      </xsl:stylesheet>
    XSLT

    document = <<~XML
      <?xml version="1.0"?>
      <name>John Smith</name>
    XML

    assert_equal document, Icl.generate_from_strings(event, transform).to_s
  end
end
