class SearchFacade
  def self.nearest_atm(lat, lon)
    data = SearchService.nearest_atm(lat, lon)
    results = data[:results].map do |atm_data|
      Atm.new(atm_data)
    end
    results
  end
end