//
//  DequeueBindMetadata.swift
//  Culture
//
//  Created by Shlomi Sharon on 04/11/2020.
//

import UIKit

struct DequeueBindMetadata<T> {
    let tableView: UITableView
    let object: T
    let indexPath: IndexPath
}
