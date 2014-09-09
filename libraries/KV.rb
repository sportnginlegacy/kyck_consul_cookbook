require 'base64'
require 'json'
require 'rest_client'

module Chef::Recipe::Consul
  class KV
    URL = "http://localhost:8500/v1/kv"

    attr_reader :key,
                :create_index,
                :modify_index,
                :lock_index,
                :flags,
                :value

    def initialize(key, value_if_unset)
      @key  = key
      @value_if_unset = value_if_unset
      update!
    end

    def set(value)
      client.put url, value
      update!
    end

    def cas(value)
      client.put cas_url, value
      update!
    end

    def get
      parser.parse(raw_get).first
    end

    def delete
      client.delete url
      nil_out_values!
    end

    private

    def update!
      parse get
    end

    def parse(data)
      @create_index = data["CreateIndex"]
      @modify_index = data["ModifyIndex"]
      @lock_index   = data["LockIndex"]
      @flags        = data["Flags"]
      @value        = decode_value data["Value"]
    end

    def client
      RestClient
    end

    def parser
      JSON
    end

    def decode_value(value)
      if value.nil?
        nil
      else
        Base64.decode64(value)
      end
    end

    def nil_out_values!
      parse(Hash.new)
    end

    def raw_get
      begin
        client.get url
      rescue client::ResourceNotFound
        cas @value_if_unset
        client.get url
      end
    end

    def url
      @url ||= "#{URL}/#{key}"
    end

    def cas_url
      index = @modify_index || 0
      "#{@url}?cas=#{index}"
    end
  end
end
