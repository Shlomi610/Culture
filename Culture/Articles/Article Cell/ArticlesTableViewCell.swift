//
//  ArticlesTableViewCell.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import UIKit

protocol ArticlesIdentifierableTableCell: IdentifierableNib {
    var item: ArticlesMetadata! {get set}
}

class ArticlesTableViewCell: UITableViewCell, ArticlesIdentifierableTableCell {

	//	MARK: - Properties
  var item: ArticlesMetadata! {
		didSet {
			bind(item as? Article)
		}
	}
  var networkManager: Network!

	//	MARK: - Outlets
  @IBOutlet weak var articleImage: UIImageView!
  @IBOutlet weak var save: UIButton!
  @IBOutlet weak var like: UIButton!
  @IBOutlet weak var likesCount: UILabel!
  @IBOutlet weak var category: UILabel!
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var authorImage: UIImageView!
  @IBOutlet weak var authorName: UILabel!
  @IBOutlet weak var date: UILabel!
}

//  MARK: - Draw rect method
extension ArticlesTableViewCell {
  override func draw(_ rect: CGRect) {
    setAuthorImage()
  }

  func setAuthorImage() {
    authorImage.layer.cornerRadius = authorImage.bounds.height / 2
  }
}

//  MARK: - Private methods
private extension ArticlesTableViewCell {
  func bind(_ item: ArticlesMetadata?) {
    guard let item = item else {
      print("TimeTable: Unsupported type")
      return
    }
    date.text = createDate(string: item.metaData.creationTime)
    loadImage(from: item.imageUrl) { (image) in
      self.articleImage.image = image
    }
    item.isSaved ? save.setImage(UIImage(named: "saved"), for: .normal) :
      save.setImage(UIImage(named: "save"), for: .normal)
    item.isLiked ? like.setImage(UIImage(named: "liked"), for: .normal) :
      like.setImage(UIImage(named: "like"), for: .normal)
    likesCount.text = String(item.likesCount)
    category.text = item.category
    title.text = item.title
    loadImage(from: item.author.authorAvatar.imageUrl) { (image) in
      self.authorImage.image = image
    }
    authorName.text = item.author.authorName
  }

  func loadImage(from imageUrl:String, completion: @escaping (UIImage?) -> ()) {
    let url = URL(string: imageUrl)
    guard (url != nil) else { return }
    networkManager = NetworkManager()
    networkManager.getImage(with: url!) { (image) in
      completion(image)
    }
  }

  func createDate(string date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.sssZ"
    let date = dateFormatter.date(from: date)!
    dateFormatter.dateFormat = "d MMM, yyyy"
    let dateString = dateFormatter.string(from: date)
    return dateString
  }
}


protocol IdentifierableNib {
    static var nib: UINib {get}
}

extension IdentifierableNib {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }
}
