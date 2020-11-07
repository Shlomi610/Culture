//
//  Metadata.swift
//  Culture
//
//  Created by Shlomi Sharon on 07/11/2020.
//

import Foundation

protocol MetadataMetadata: Codable {
  var creationTime: String {get}
}


struct Metadata: MetadataMetadata {
  var creationTime: String
}
