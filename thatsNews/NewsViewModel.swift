//
//  NewsViewModel.swift
//  thatsNews
//
//  Created by Narissorn Chowarun on 2024-06-24.
//

import Foundation
import UIKit
// protocol ... : AnyObject -> nice to have

class NewsViewModel {
    
    // prepare article URL method
    private func prepareArticlesURL() -> URL? {
    let queryItems = [Constants.apiKey, URLQueryItem(name: "country", value: "ca")]
    var urlComponents = Constants.baseURL
    urlComponents.queryItems = queryItems
    if let url = urlComponents.url {
    return url
    } else {
    print("Error preparing URL for Country: Canada")
    return nil
    }
    }
 
    
    func getData(contentsOf url: URL) async -> Data? {
    let session = URLSession.shared
    do {
    let (data, _) = try await session.data(from: url)
    print("Recieved HTTP Response from the server: (response)")
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
guard let url = url else {
print("Couldn't find a valid URL for the Image")
self.image = UIImage(systemName: "xmark.octagon")
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
