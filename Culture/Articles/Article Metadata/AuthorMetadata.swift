//
//  AuthorMetadata.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import UIKit

protocol AuthorMetadata: Codable {
  var authorName: String {get}
  var authorAvatar: AuthorAvatar {get}
}

struct Author: AuthorMetadata {
  var authorName: String
  var authorAvatar: AuthorAvatar
}
