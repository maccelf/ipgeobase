# frozen_string_literal: true

require "addressable/uri"
require "net/http"
require_relative "ipgeobase/version"
require_relative "ipgeobase/geolocation"

# main module
module Ipgeobase
  class Error < StandardError; end

  def self.lookup(hostname)
    uri = Addressable::URI.parse("http://ip-api.com/xml/#{hostname}")
    xml = Net::HTTP.get(uri)
    Geolocation.parse(xml)
  end
end
