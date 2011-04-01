class RGData::Config

  configurations = [
    :client_id,     # https://code.google.com/apis/console, (click 'Identity' on left)
    :client_secret, # https://code.google.com/apis/console, (click 'Identity' on left)
  ]

  configurations.each do |configuration|
    define_method configuration, do |*new_value|
      instance_variable = :"@#{configuration}"
      if new_value.any?
        instance_variable_set instance_variable, new_value.first
      else
        instance_variable_get instance_variable
      end
    end
  end

end

module RGData

  class << self

    def config(&block)
      @config ||= RGData::Config.new
      @config.instance_eval &block if block_given?
      raise 'You need to set client_id and client_secret in configs' unless @config.client_id && @config.client_secret
      @config
    end

  end

end
