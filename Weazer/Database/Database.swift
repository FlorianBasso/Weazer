//
//  Database.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

public protocol Database {
    func getAll<T: Model>(type: T.Type) -> Result<[T], DatabaseError>
    func getById<T: Model>(id: Int, type: T.Type) -> Result<T, DatabaseError>
    func getByPredicate<T: Model>(predicate: NSPredicate, type: T.Type) -> Result<T, DatabaseError>
    func insertOrUpdate<T: Model>(item: T) -> Result<T, DatabaseError>
    func deleteAll<T: Model>(type: T.Type) -> Result<Void, DatabaseError>
    func deleteById<T: Model>(remoteKey: Int, type: T.Type) -> Result<Void, DatabaseError>
}

public enum DatabaseError: Error {
    case unknownEntity
    case noEntity
}

