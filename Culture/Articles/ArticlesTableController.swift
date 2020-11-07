//
//  ArticlesTableController.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import UIKit

protocol ArticlesTableControllerProtocol: ArticlesCommonCommunication {
    func registerCells(using collectionView: UITableView)
}

class ArticlesTableController: NSObject {
    //  MARK: - Properties
    let dataController: ArticlesDataControllerProtocol
    
    //  MARK: - Constructors
    init(dataController: ArticlesDataControllerProtocol) {
      self.dataController = dataController
    } 
}


//  MARK: - UITableViewDelegate, UITableViewDataSource implementation
extension ArticlesTableController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let object = dataController.object(at: indexPath) else { return UITableViewCell() }
        let metadata = DequeueBindMetadata(tableView: tableView, object: object, indexPath: indexPath)
        
        switch object.type {
        case .articles: return generateCell(using: metadata, cellType: ArticlesTableViewCell.self)
        }
    }

  private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableView.automaticDimension
      }
}

//  MARK: - Private methods
private extension ArticlesTableController {
    func generateCell<T: ArticlesIdentifierableTableCell>(using metadata: DequeueBindMetadata<ArticlesMetadata>,
                                                           cellType: T.Type) -> T {
        var cell: T = metadata.tableView.dequeueReusableCell(withIdentifier: T.identifier, for: metadata.indexPath) as! T
        cell.item = metadata.object
        return cell
    }
}

//  MARK: - ArticlesTableControllerProtocol implementation
extension ArticlesTableController: ArticlesTableControllerProtocol {
  func loadData() {
    dataController.loadData()
  }

  func registerCells(using tableView: UITableView) {
    tableView.register(ArticlesTableViewCell.nib, forCellReuseIdentifier: ArticlesTableViewCell.identifier)
  }
}
