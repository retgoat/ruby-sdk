require "weship/util"
module Weship
  class Carrier
    include Weship::Error

    # creates carrier object for the shipment
    # see https://weship.io/#docs section `shipments'
    def self.create(params)
      carrier = {
        :name => params[:name].upcase,
        :service => params[:service],
        :credentials => params[:credentials].upcase
      }
      
      carrier
    end #carrier
    
  end #class
end #module
