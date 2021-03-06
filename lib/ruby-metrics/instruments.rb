require File.join(File.dirname(__FILE__), 'statistics', 'sample')
require File.join(File.dirname(__FILE__), 'statistics', 'uniform_sample')

require File.join(File.dirname(__FILE__), 'instruments', 'base')
require File.join(File.dirname(__FILE__), 'instruments', 'counter')
require File.join(File.dirname(__FILE__), 'instruments', 'meter')
require File.join(File.dirname(__FILE__), 'instruments', 'gauge')
require File.join(File.dirname(__FILE__), 'instruments', 'histogram')


require 'json'

module Metrics
  module Instruments
    @instruments = {}
    
    @types = {
      :counter   => Counter,
      :meter     => Meter,
      :gauge     => Gauge,
      :histogram => Histogram
    }
    
    def self.register(type, name, &block)
      @instruments[name] = @types[type].new(&block)
    end
    
    def self.unregister_all
      @instruments = {}
    end
    
    def self.registered
      @instruments
    end
    
    def self.to_json
      @instruments.to_json 
    end
    
    module TypeMethods
      
      def register(type, name, &block)
        Metrics::Instruments.register(type, name, &block)
      end
      
      def counter(name)
        register(:counter, name)
      end
      
      def meter(name)
        register(:meter, name)
      end
      
      def gauge(name, &block)
        register(:gauge, name, &block)
      end
      
      def histogram(name)
        register(:histogram, name)
      end
    end
    
  end
end
