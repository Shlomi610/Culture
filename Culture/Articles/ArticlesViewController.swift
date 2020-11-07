//
//  ArticlesViewController.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import UIKit

class ArticlesViewController: UIViewController, ArticlesDependencyMetadataInput {
  //  MARK: - Properties
  private var tableController: ArticlesTableControllerProtocol!
  var data                   : ArticlesDependencyMetadataProtocol!
  //  MARK: - Outlets
  @IBOutlet private weak var tableView     : UITableView!
  @IBOutlet private weak var loadingSpinner: UIActivityIndicatorView!

  //  MARK: - View Controller Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    mainSetup()
  }
}

//  MARK: - Private methods
private extension ArticlesViewController {
  func mainSetup() {
    bindDependencies()
    tableController.registerCells(using: tableView)
    setupLoadingSpinner()
    tableController.loadData()
  }

  func bindDependencies() {
    let data = ArticlesDataController(viewController: self)

    let table = ArticlesTableController(dataController: data)
    tableView.dataSource = table
    tableView.delegate = table
    tableController = table
  }

  func setupLoadingSpinner() {
    loadingSpinner.hidesWhenStopped = true
    loadingSpinner.startAnimating()
  }

  func handleNewData() {
    tableView.reloadData()
  }

  func handle(_ error: Error) {
    print(error.localizedDescription)
  }
}

//  MARK: - ArticlesDataEvents implementation
extension ArticlesViewController: ArticlesDataEvents {
  func update(event: ArticlesEventType) {
    loadingSpinner.stopAnimating()

    switch event {
    case .newData:          handleNewData()
    case .error(let error): handle(error)
    }
  }
}
