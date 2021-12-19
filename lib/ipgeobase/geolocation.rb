# frozen_string_literal: true

require "happymapper"

module Ipgeobase
  class Geolocation
    include HappyMapper

    tag :query
    has_one :city, String, tag: "city"
    has_one :country, String, tag: "country"
    has_one :countryCode, String, tag: "countryCode"
    has_one :lat, Float, tag: "lat"
    has_one :lon, Float, tag: "lon"
  end
end
