import UIKit

struct WeatherData : Decodable {
    let weather : [Weather]
    let main : Main
    let timezone : Int
    let id : Int64
    let name : String
    let cod : Int
}
struct Weather : Decodable {
    let id : Int
    let main : String
    let description : String
}

struct Main : Decodable {
    let temp : Double
    let feels_like : Double
    let temp_min : Double
    let temp_max : Double
}
