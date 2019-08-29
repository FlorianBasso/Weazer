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
    
    var mockGetAll: Result<[Codable], DatabaseError>?
    func getAll<T>(type: T.Type) -> Result<[T], DatabaseError> where T : Codable {
        
        guard let mockGetAll = self.mockGetAll?.map({$0 as! [T]}) else {
            return Result.failure(.noEntity)
        }
        
        return mockGetAll
    }
    
    var mockGetBy: Result<Codable, DatabaseError>?
    func getById<T>(id: Int, type: T.Type) -> Result<T, DatabaseError> where T : Codable {
        
        guard let mockGetBy = self.mockGetBy?.map({$0 as! T}) else {
            return Result.failure(.noEntity)
        }
        
        return mockGetBy
    }
    
    func getByPredicate<T>(predicate: NSPredicate, type: T.Type) -> Result<T, DatabaseError> where T : Codable {
        guard let mockGetBy = self.mockGetBy?.map({$0 as! T}) else {
            return Result.failure(.noEntity)
        }
        
        return mockGetBy
    }
    
    var itemInserted: Codable?
    func insertOrUpdate<T>(item: T) -> Result<T, DatabaseError> where T : Codable {
        self.itemInserted = item
        return Result.success(item)
    }
    
    var entityString: String?
    func deleteAll<T>(type: T.Type) -> Result<Void, DatabaseError> where T : Codable {
        self.entityString = String(describing: type)
        return Result.success(())
    }
    
    var idToDelete: Int = 0
    var classToDelete: Codable.Type?
    func deleteById<T>(remoteKey: Int, type: T.Type) -> Result<Void, DatabaseError> where T : Codable {
        self.idToDelete = remoteKey
        self.classToDelete = type
        return Result.success(())
    }
    
}
