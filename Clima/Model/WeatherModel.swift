struct WeatherModel {
    // stored properties
    let cityName: String
    let cityTemp: Double
    let cityConditionID: Int
    
    //computed properties
    var conditionName: String {
        return getConditionName(cityConditionID: cityConditionID)
    }
    var temperatureString: String {
        return String(format: "%.1f", cityTemp)
    }
    
    func getConditionName(cityConditionID: Int) -> String {
        switch cityConditionID {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        }
    }
}
