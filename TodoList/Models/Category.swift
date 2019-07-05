//
//  Category.swift
//  TodoList
//
//  Created by Rong Xiao on 7/5/19.
//  Copyright © 2019 Rong Xiao. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
