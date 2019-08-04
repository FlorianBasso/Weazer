//
//  Database.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

public protocol Database {
    func getAll(type: AnyClass) -> [Any]?
    func getById(id: Int, type: AnyClass) -> Any?
    func getByPredicate(predicate: NSPredicate, type: AnyClass) -> Any?
    func insertOrUpdate(item: Any)
    func clean(entityString: String)
    func deleteById(idString: String, type: AnyClass)
}
