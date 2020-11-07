//
//  DownloadImage.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import UIKit
import Alamofire

protocol DownloadImageProtocol {
  func getImage(with url: URL, completion: @escaping (UIImage?)->())
}

class DownloadImage: NSObject, DownloadImageProtocol {
  func getImage(with url: URL, completion: @escaping (UIImage?) -> ()) {
    AF.request(url).response { response in
      guard let data = response.data else { return }
      let image = UIImage(data: data, scale: 1)
      completion(image)
    }
  }
}
