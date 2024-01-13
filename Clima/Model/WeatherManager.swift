import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager, weather: WeatherModel)
    func didFailWithError(error : Error)
}
let apikey = ""
struct WeatherManager {
    var delegate : WeatherManagerDelegate?
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(apikey)&units=metric"
    func fetchWeather(cityName : String) {
        let stringURL = "\(weatherURL)&q=\(cityName)"
        performRequest(with: stringURL)
    }
    func fetchWeather(latitude : String, longitude : String) {
        let stringURL = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: stringURL)
    }
    func performRequest(with stringURL : String) {
        if let url = URL(string: stringURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if error == nil {
                        if let safeData = data {
                            if let weather = parseJSON(safeData) {
                                self.delegate?.didUpdateWeather(self, weather : weather)
                            }
                        }
                    } else {
                        self.delegate?.didFailWithError(error: error!)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let condition = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weatherModel = WeatherModel(condition: condition, cityName: name, temperature: temp)
            return weatherModel
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
