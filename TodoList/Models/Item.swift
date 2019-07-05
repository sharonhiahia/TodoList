//
//  Item.swift
//  TodoList
//
//  Created by Rong Xiao on 7/5/19.
//  Copyright © 2019 Rong Xiao. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    // @objc
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
