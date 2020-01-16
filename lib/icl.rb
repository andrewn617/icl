require 'icl/version.rb'
require 'nokogiri'

module Icl
  def self.output(document_type)
    event = File.open("document_types/#{document_type}/event.xml") { |f| Nokogiri::XML(f) }
    transform = File.open("document_types/{document_type}/transform_1.xml") { |f| Nokogiri::XSLT(f) }

    File.write("document_types/#{document_type}/output.xml", transform.transform(event))
  end
end

