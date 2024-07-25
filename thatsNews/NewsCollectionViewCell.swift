//
//  NewsCollectionViewCell.swift
//  thatsNews
//
//  Created by Narissorn Chowarun on 2024-07-20.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var authorName: UILabel!
    
    func setNewsItem(newsItem: Article) {
        Task {
            // try to retrieve data
            
             await self.imageView.loadImage(url: URL(string: newsItem.urlToImage ?? ""))

        }
        self.headlineLabel.text = newsItem.title
        self.authorName.text = newsItem.author
    }
    
}
