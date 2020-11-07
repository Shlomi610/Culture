//
//  GetArticles.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import UIKit
import Alamofire

protocol ArticlesProtocol {
    func getArticles(with url: urls, completion: @escaping (Articles)->())
}

class GetArticles: NSObject, ArticlesProtocol {
  func getArticles(with url: urls, completion: @escaping (Articles) -> ()) {
    AF.request(url.rawValue).response { response in
      guard let data = response.data else { return }
      let str = String(decoding: data, as: UTF8.self)
      print(str)
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let articles = try decoder.decode(Articles.self, from: data)
        completion(articles)
      } catch {
          print("error: \(error.localizedDescription)")
      }
    }
  }
}
