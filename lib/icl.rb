require 'icl/version.rb'
require 'nokogiri'

module Icl
  def self.transform(xml_file, *stylesheet_files)
    xml_string = File.open("#{xml_file}")
    stylesheet_strings = stylesheet_files.map { |stylesheet_file| File.open("#{stylesheet_file}") }

    puts transform_from_strings(xml_string, *stylesheet_strings)
  end

  def self.transform_from_strings(xml_string, *stylesheet_strings)
    xml = Nokogiri::XML(xml_string)
    output = xml

    stylesheet_strings.each do |stylesheet_string|
      stylesheet = Nokogiri::XSLT(stylesheet_string)
      output = stylesheet.transform(output)
    end

    output
  end
end
