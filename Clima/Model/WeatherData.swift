struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Decodable {
    let temp: Double
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Int
    let humidity: Int
}

