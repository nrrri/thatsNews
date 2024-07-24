import UIKit

public class Constants {
    static let apiKey = URLQueryItem(name: "apiKey", value: "7fc04c9461f344a88df679e902356464")
    
    static var baseURL: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        return components
    }

    //static let baseURL = URLComponents(string: "https://newsapi.org/v2/top-headlines")!
    // shouldn't do like this (force upwrap)
}
