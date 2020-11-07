//
//  ArticlesDataController.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import Foundation

protocol ArticlesDataEvents: class {
  func update(event: ArticlesEventType)
}

enum ArticlesEventType {
  case newData
  case error(Error)
}

protocol ArticlesCommonCommunication {
	func loadData()
}

protocol ArticlesDataControllerProtocol: ArticlesCommonCommunication {
  func object(at indexPath: IndexPath) -> ArticlesMetadata?
  var numberOfObjects: Int {get}
}

class ArticlesDataController {
  //  MARK: - Properties
  private weak var delegateToViewController: ArticlesDataEvents?
  private var data: [ArticlesMetadata]
  private var networkManager: Network!

  //  MARK: - Constructors
  init(viewController: ArticlesDataEvents, data: [ArticlesMetadata] = []) {
    delegateToViewController = viewController
    self.data = data
  }
}

//  MARK: - ArticlesDataControllerProtocol Implementation
extension ArticlesDataController: ArticlesDataControllerProtocol {
  func object(at indexPath: IndexPath) -> ArticlesMetadata? {
    if data.isEmpty ||
        indexPath.row >= numberOfObjects {
      return nil
     }
    return data[indexPath.row]
  }

  var numberOfObjects: Int { return data.count }

  func loadData() {
    networkManager = NetworkManager()
    networkManager.getArticles { [self] (articles) in
      for article in articles.articles {
        let author = Author(authorName: article.author.authorName, authorAvatar: article.author.authorAvatar)
        let metaData = Metadata(creationTime: article.metaData.creationTime)
        let metadata = Article(metaData: metaData, title: article.title, imageUrl: article.imageUrl, isSaved: article.isSaved, isLiked: article.isLiked, likesCount: article.likesCount, category: article.category, author: author)
        data.append(metadata)
        delegateToViewController?.update(event: .newData)
      }
    }
  }
}
