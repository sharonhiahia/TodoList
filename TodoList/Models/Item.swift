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
    // @objc is actually required here.
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
