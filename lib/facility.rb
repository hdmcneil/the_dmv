class Facility
  attr_reader :name, 
              :address, 
              :phone, 
              :services,
              :registered_vehicles, :collected_fees

  def initialize(info, collected_fees = 0)
    @name = info[:name]
    @address = info[:address]
    @phone = info[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = collected_fees
  end

  def add_service(service)
    @services << service
    
  end

  def register_vehicle(vehicle)
    if available_service?("Vehicle Registration")
    @registered_vehicles << vehicle
      if vehicle.antique?
        vehicle.plate_type = :antique
        @collected_fees += 25
      elsif vehicle.electric_vehicle?
        vehicle.plate_type = :ev
        @collected_fees += 200
      else
        @collected_fees += 100
      end
      vehicle.registration_date = Date.today 
    else
      puts "This facility does not offer vehicle registration services."
    end
  end

  def available_service?(service)
   @services.include?(service)
  end

  def administer_written_test(registrant)
    if available_service?("Written Test")
      if registrant.permit? && registrant.age >= 16
        registrant.license_data[:written] = true
      else
        registrant.license_data[:written] = false
      end
    else
      registrant.license_data[:written] = false 
      puts "This facility does not offer written test services."
      return false
    end
  end

  def administer_road_test(registrant)
    if available_service?("Road Test")
      if registrant.license_data[:written] == true
        registrant.license_data[:license] = true
        registrant.road_test = true
      else 
        registrant.license_data[:license] = false
      end
    else
      registrant.license_data[:license] = false
      puts "This facility does not offer road test services."
      return false
    end
  end

  def renew_drivers_license(registrant)
    if available_service?("Renew License")
      if registrant.road_test == true && registrant.license_data[:license] == true
        registrant.license_data[:renewed] = true
      else
        registrant.license_data[:renewed] = false
      end
    else
      registrant.license_data[:renewed] = false
      puts "This facility does not offer license renewal services."
      return false
    end
  end

end
