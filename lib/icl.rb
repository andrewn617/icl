require 'icl/version.rb'
require 'nokogiri'

# to do
# => add tests
# => code smells?
# => how do i get faster feedback without publish gem
# => make the path less specific
# => command to set up a project
# => command to set up a document type
# => support multiple transform per doc type
# => support multiple events per doc type

module Icl
  def self.transform(event_file, *stylesheet_files)
    event_string = File.open("#{event_file}")
    stylesheet_strings = stylesheet_files.map { |stylesheet_file| File.open("#{stylesheet_file}") }

    puts transform_from_strings(event_string, *stylesheet_strings)
  end

  def self.transform_from_strings(event_string, *stylesheet_strings)
    event = Nokogiri::XML(event_string)
    output = event

    stylesheet_strings.each do |stylesheet_string|
      stylesheet = Nokogiri::XSLT(stylesheet_string)
      output = stylesheet.transform(output)
    end

    output
  end
end
