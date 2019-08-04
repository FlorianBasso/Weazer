//
//  MockDatabase.swift
//  WeazerTests
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
@testable import Weazer

class MockDatabase: Database {
    
    var mockGetAll: [Any]?
    func getAll(type: AnyClass) -> [Any]? {
        return mockGetAll
    }
    
    var mockGetBy: Any?
    func getById(id: Int, type: AnyClass) -> Any? {
        return mockGetBy
    }
    
    func getByPredicate(predicate: NSPredicate, type: AnyClass) -> Any? {
        return mockGetBy
    }
    
    var itemInserted: Any?
    func insertOrUpdate(item: Any) {
        self.itemInserted = item
    }
    
    var entityString: String?
    func clean(entityString: String) {
        self.entityString = entityString
    }
    
    var idToDelete: String = "0"
    var classToDelete: AnyClass?
    func deleteById(idString: String, type: AnyClass) {
        self.idToDelete = idString
        self.classToDelete = type
    }
    
}
