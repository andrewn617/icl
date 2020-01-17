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
  def self.generate(event_file, *transform_files)
    event_string = File.open("#{event}")
    transform_strings = transform_files.map { |transform_file| File.open("#{transform}") }

    puts generate_from_strings(event_string, *transform_strings)
  end

  def self.generate_from_strings(event_string, *transform_strings)
    event = Nokogiri::XML(event_string)
    output = event

    transform_strings.each do |transform_string|
      transform = Nokogiri::XSLT(transform_string)
      output = transform.transform(output)
    end

    output
  end
end
