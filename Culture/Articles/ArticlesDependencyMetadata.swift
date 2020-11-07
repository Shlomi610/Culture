//
//  ArticlesDependencyMetadata.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import Foundation


// Receiving object will implement this protocol
protocol ArticlesDependencyMetadataInput {
	var data: ArticlesDependencyMetadataProtocol! {get set}
}

// A concrete type that will implement this protocol, will be passed to the receiving object
protocol ArticlesDependencyMetadataProtocol {}

// The concrete type
struct ArticlesDependencyMetadata: ArticlesDependencyMetadataProtocol {}

