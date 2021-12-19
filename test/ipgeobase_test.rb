# frozen_string_literal: true

require "test_helper"

class IpgeobaseTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def setup
    stub_request(:get, "http://ip-api.com/xml/8.8.8.8")
      .with(
        headers: {
          "Accept" => "*/*",
          "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent" => "Ruby"
        }
      )
      .to_return(status: 200, body: '<?xml version="1.0" encoding="UTF-8"?>
        <query>
          <status>success</status>
          <country>Canada</country>
          <countryCode>CA</countryCode>
          <region>QC</region>
          <regionName>Quebec</regionName>
          <city>Montreal</city>
          <zip>H1K</zip>
          <lat>45.6085</lat>
          <lon>-73.5493</lon>
          <timezone>America/Toronto</timezone>
          <isp>Le Groupe Videotron Ltee</isp>
          <org>Videotron Ltee</org>
          <as>AS5769 Videotron Telecom Ltee</as>
          <query>24.48.0.1</query>
       </query>')
    @ip_meta = Ipgeobase.lookup("8.8.8.8")
  end

  def test_country
    assert_respond_to @ip_meta, :country
    refute_empty @ip_meta.country
    assert_instance_of String, @ip_meta.country
    assert_equal @ip_meta.country, "Canada"
  end

  def test_city
    assert_respond_to @ip_meta, :city
    refute_empty @ip_meta.city
    assert_instance_of String, @ip_meta.city
    assert_equal @ip_meta.city, "Montreal"
  end

  def test_countryCode
    assert_respond_to @ip_meta, :countryCode
    refute_empty @ip_meta.countryCode
    assert_instance_of String, @ip_meta.countryCode
    assert_equal @ip_meta.countryCode, "CA"
  end

  def test_lat
    assert_respond_to @ip_meta, :lat
    assert_instance_of Float, @ip_meta.lat
    assert_equal @ip_meta.lat, 45.6085
  end

  def test_lon
    assert_respond_to @ip_meta, :lon
    assert_instance_of Float, @ip_meta.lon
    assert_equal @ip_meta.lon, -73.5493
  end
end
