//
//  ArticlesMetadata.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import Foundation

protocol ArticlesMetadata: Codable {
  var type: ArticlesItemType {get}
  var metaData: Metadata {get}
  var title: String {get}
  var imageUrl: String {get}
  var isSaved: Bool {get}
  var isLiked: Bool {get}
  var likesCount: Int {get}
  var category: String {get}
  var author: Author {get}
}

enum ArticlesItemType: String, Codable {
  case articles
}

struct Article: ArticlesMetadata {
  var metaData: Metadata
  var title: String
  var imageUrl: String
  var isSaved: Bool
  var isLiked: Bool
  var likesCount: Int
  var category: String
  var author: Author
}

struct Articles: Decodable {
  var articles: [Article]

  enum CodingKeys: String, CodingKey {
    case articles = "data"
  }
}

extension ArticlesMetadata {
  var type: ArticlesItemType {
    return .articles
  }
}
