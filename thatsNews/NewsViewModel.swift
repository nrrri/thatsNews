//
//  NewsViewModel.swift
//  thatsNews
//
//  Created by Narissorn Chowarun on 2024-06-24.
//

import Foundation
import UIKit


// protocol ... : AnyObject -> nice to have
protocol NewsViewModelDelegate: AnyObject {
    func refreshUI() 
}

class NewsViewModel {
    var articles = [Article]() {
        didSet {
            self.delegate?.refreshUI()
        }
    }
    
    // include delegate in the scope and make it optaional (make sure that we have delegate)
    var delegate: NewsViewModelDelegate?
    
    // can init just delegate
    init(delegate: NewsViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func refreshArticles() async {
        guard let url = self.prepareArticlesURL() else {
            return
        }
        guard let data = await self.getData(contentsOf: url) else {
            return
        }
        self.articles = decodeItems(data: data)
    }
    
    // recieve data from get data function and decode data
    private func decodeItems(data: Data) -> [Article] {
        
        let decoder = JSONDecoder()
        do {
            let apiResponse = try decoder.decode(NewsAPIResponse.self, from: data)
            return apiResponse.articles
        } catch {
            print("Error decoding the news data \(error.localizedDescription)")
            return [Article]()
        }
    }
    
    // prepare article URL method
    private func prepareArticlesURL() -> URL? {
        let queryItems = [Constants.apiKey, URLQueryItem(name: "country", value: "ca")]
        var urlComponents = Constants.baseURL
        urlComponents.queryItems = queryItems
        
        // check url valid
        if let url = urlComponents.url {
            return url
        } else {
            print("Error preparing URL for Country: Canada")
            return nil
        }
    }
    
    // get data from api
    func getData(contentsOf url: URL) async -> Data? {
        let session = URLSession.shared
        // check if data available
        do {
            let (data, response) = try await session.data(from: url)
            print("Recieved HTTP Response from the server: \(response)")
            return data
        } catch {
            print("Error downloading the news data: \(error.localizedDescription)")
            return nil
        }
    }
    
}

extension UIImageView {
    func loadImage(url: URL?) async {
        // Creates a placeholder image
        self.image = UIImage(systemName: "photo")
        
        // check valid url for image
        guard let url = url else {
            print("Couldn't find a valid URL for the Image")
            self.image = UIImage(systemName: "cloud.moon.rain")
            return
        }
        
        let session = URLSession.shared
        
        do {
            let (data, _) = try await session.data(from: url)
            if let image = UIImage(data: data) {
                self.image = image
            }
        } catch {
            self.image = UIImage(systemName: "xmark.octagon")
            print("There was an error: \(error.localizedDescription)")
        }
    }
}

//struct myTest: Codable {
//    // codable = decodable + encodable
//}
