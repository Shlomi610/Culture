//
//  NetworkManager.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import UIKit

protocol Network {
  func getArticles(completion: @escaping (Articles)->())
  func getImage(with url: URL, completion: @escaping (UIImage?)->())
}

enum urls: String {
    case articles = "https://cdn.theculturetrip.com/home-assignment/response.json"
}

class NetworkManager: NSObject, Network {
  private var articles: ArticlesProtocol?
  private var downloadImage: DownloadImageProtocol?

  func getArticles(completion: @escaping (Articles)->()) {
    articles = GetArticles()
    articles!.getArticles(with: .articles) { (articles) in
      completion(articles)
    }
  }

  func getImage(with url: URL, completion: @escaping (UIImage?)->()) {
    downloadImage = DownloadImage()
    downloadImage?.getImage(with: url, completion: { (image) in
      completion(image)
    })
  }
}
