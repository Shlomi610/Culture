//
//  AuthorAvatar.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import Foundation

protocol AuthorAvatarMetadata: Codable {
  var imageUrl: String {get}
}

struct AuthorAvatar: AuthorAvatarMetadata {
  var imageUrl: String
}
