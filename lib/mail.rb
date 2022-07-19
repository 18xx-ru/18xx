# frozen_string_literal: true

require 'json'
require 'net/http'
require 'uri'

module Mail
  API_PATH = 'https://api.mailgun.net/v3/vansach.ru/messages'

  def self.send(user, subject, html)
    return unless ENV['RACK_ENV'] == 'production'

    uri = URI.parse(API_PATH)
    req = Net::HTTP::Post.new(uri)
    req.basic_auth 'API', ENV['MAILGUN_KEY']
    req.body = URI.encode_www_form(
      'subject' => subject,
      'from' => '18xx.vansach.ru <18xx-no-reply@vansach.ru>',
      'to' => user.email,
      'html' => html,
    )

    Net::HTTP.start(uri.hostname, uri.port, open_timeout: 5, use_ssl: true) do |http|
      http.request(req).body
    end
  end
end
