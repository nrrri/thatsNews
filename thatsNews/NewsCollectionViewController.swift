//
//  ViewController.swift
//  thatsNews
//
//  Created by Narissorn Chowarun on 2024-06-24.
// 

import UIKit

class NewsCollectionViewController: UICollectionViewController {
    let viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await viewModel.refreshArticles()
        }
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.articles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath)
                as? NewsCollectionViewCell, self.viewModel.articles.count > indexPath.row
        else {
            print("Error creating Cell.")
            return UICollectionViewCell()
        }
        
        cell.setNewsItem(newsItem: self.viewModel.articles[indexPath.row])
        return cell
    }


}

// make extension is easier to adjust
extension NewsCollectionViewController: NewsViewModelDelegate {
    func refreshUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
