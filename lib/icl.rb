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
  def self.generate(event, transform)
    event = File.open("#{event}") { |f| Nokogiri::XML(f) }
    transform = File.open("#{transform}") { |f| Nokogiri::XSLT(f) }

    puts transform.transform(event)
  end
end

