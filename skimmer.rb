# frozen_string_literal: true

require 'droplet_kit'

class Skimmer
  def self.client
    @client ||= DropletKit::Client.new(access_token: ENV['access_token'])
  end
end
