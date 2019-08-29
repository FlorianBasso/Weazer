//
//  RealmDatabase.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmDatabase: Database {
    
    static let defaultRealmFilename = "default.realm"
    static let realmFileUrl = Realm.Configuration.defaultConfiguration.fileURL
    static let realmConfig: Realm.Configuration = {
        var config = Realm.Configuration(fileURL: RealmDatabase.realmFileUrl)
        
        if let infoBundle = Bundle.main.infoDictionary,
            let buildNumberString = infoBundle[kCFBundleVersionKey as String] as? String,
            let buildNumber = Int(buildNumberString) {
            config.schemaVersion = UInt64(buildNumber)
        }
        
        config.migrationBlock = { migration, oldSchemaVersion in
            // If migration needed
        }
        
        return config
    }()
    
    private var realm: Realm? {
        var tempRealm: Realm?
        do {
            tempRealm = try Realm(configuration: RealmDatabase.realmConfig)
        } catch {
            do {
                guard let url = RealmDatabase.realmFileUrl else {
                    return nil
                }
                try FileManager.default.removeItem(at: url)
                tempRealm = try Realm(configuration: RealmDatabase.realmConfig)
            } catch {}
        }
        return tempRealm
    }
    
    let entityMapping: [String: RealmModel.Type] = [String(describing:Forecast.self): RealmForecast.self,
                                                    String(describing:Weather.self): RealmWeather.self,
                                                    String(describing:SunInfo.self): RealmSunInfo.self,
                                                    String(describing:Wind.self): RealmWind.self,
                                                    String(describing:ForecastMainInfo.self): RealmForecastMainInfo.self]
    
    func getAll<T: Model>(type: T.Type) -> Result<[T], DatabaseError> {
        let entityString = String(describing:type.self)
        guard let realmEntityType = self.entityMapping[entityString],
            let results = realm?.objects(realmEntityType) else {
                return Result.failure(DatabaseError.unknownEntity)
        }
        
        let array: [T] = results.map {$0.entity(forType: T.self)}
        return Result.success(array)
    }
    
    func getById<T: Model>(id: Int, type: T.Type) -> Result<T, DatabaseError> {
        let predicate = NSPredicate(format: "id == %d", id)
        return self.getByPredicate(predicate: predicate, type: T.self)
    }
    
    func getByPredicate<T: Model>(predicate: NSPredicate, type: T.Type) -> Result<T, DatabaseError> {
        let entityString = String(describing:type.self)
        guard let realmEntityType = self.entityMapping[entityString] else {
            return Result.failure(DatabaseError.unknownEntity)
        }
        guard let resultEntity = realm?.objects(realmEntityType).filter(predicate).first?.entity(forType: T.self) else {
            return Result.failure(DatabaseError.noEntity)
        }
        
        return Result.success(resultEntity)
    }
    
    func insertOrUpdate<T: Model>(item: T) -> Result<T, DatabaseError> {
        let entityString = String(describing: type(of:item).self)
        
        guard let realmEntityType = self.entityMapping[entityString] else {
            return Result.failure(DatabaseError.unknownEntity)
        }
        
        try? realm?.write {
            let realmEntity = realmEntityType.init()
            realmEntity.updatePropertiesToDatabase(from: item)
            realm?.add(realmEntity, update: true)
        }
        
        return Result.success(item)
    }
    
    func deleteAll<T: Model>(type: T.Type) -> Result<Void, DatabaseError> {
        
        let entityString = String(describing: type.self)
        guard let realmEntityType = self.entityMapping[entityString] else {
            return Result.failure(DatabaseError.unknownEntity)
        }
        guard let objects = realm?.objects(realmEntityType) else {
            return Result.failure(DatabaseError.noEntity)
        }
        
        try? realm?.write {
            realm?.delete(objects)
        }
        
        return Result.success(())
    }
    
    func deleteById<T: Model>(remoteKey: Int, type: T.Type) -> Result<Void, DatabaseError> {
        
        let entityString = String(describing:type.self)
        guard let realmEntityType = self.entityMapping[entityString] else {
            return Result.failure(DatabaseError.unknownEntity)
        }
        let predicate = NSPredicate(format: "id == %d", remoteKey)
        guard let results = realm?.objects(realmEntityType).filter(predicate) else {
            return Result.failure(DatabaseError.noEntity)
        }
        
        try? realm?.write {
            realm?.delete(results)
        }
        
        return Result.success(())
    }
    
}
