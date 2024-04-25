import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ weatherManager: WeatherManager, error: Error)
}

struct WeatherManager {
    let apiKey = ""
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let customURL = "\(weatherURL)&appid=\(apiKey)&q=\(cityName)"
        performRequest(with: customURL)
    }
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let customURL = "\(weatherURL)&appid=\(apiKey)&lat=\(lat)&lon=\(lon)"
        performRequest(with: customURL)
    }
    
    func performRequest(with customURL: String) {
        if let url = URL(string: customURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(self, error: error!)
                } else {
                    if let safeData = data {
                        if let weather = self.parseJSON(weatherData: safeData) {
                            delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let cityName = decodedData.name
            let cityTemp = decodedData.main.temp
            let cityConditionID = decodedData.weather[0].id
            
            let weather = WeatherModel(cityName: cityName, cityTemp: cityTemp, cityConditionID: cityConditionID)
            return weather
            
        } catch {
            delegate?.didFailWithError(self, error: error)
            return nil
        }
    }
}

