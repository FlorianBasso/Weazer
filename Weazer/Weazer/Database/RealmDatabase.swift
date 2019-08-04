//
//  RealmDatabase.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDatabase: Database {
    
    let realm = try! Realm()
    
    static let entityMapping: [String: RealmModel.Type] = [String(describing:Forecast.self): RealmForecast.self,
                                                           String(describing:Weather.self): RealmWeather.self,
                                                           String(describing:SunInfo.self): RealmSunInfo.self,
                                                           String(describing:Wind.self): RealmWind.self,
                                                           String(describing:ForecastMainInfo.self): RealmForecastMainInfo.self]
    
    // MARK: - YMMDatabase
    
    func getAll(type: AnyClass) -> [Any]? {
        let entityString = String(describing:type.self)
        guard let realmEntityType = RealmDatabase.entityMapping[entityString] else {return nil}
        let results = self.realm.objects(realmEntityType)
        return results.map { $0.entity }
    }
    
    func getById(id: Int, type: AnyClass) -> Any? {
        let entityString = String(describing:type.self)
        guard let realmEntityType = RealmDatabase.entityMapping[entityString] else {return nil}
        let results = self.realm.objects(realmEntityType).map { $0.entity }.filter { (aModel) -> Bool in
            return aModel.remoteKey == id
        }
        return results.first
    }
    
    func getByPredicate(predicate: NSPredicate, type: AnyClass) -> Any? {
        let entityString = String(describing:type.self)
        guard let realmEntityType = RealmDatabase.entityMapping[entityString],
            let result = self.realm.objects(realmEntityType).filter(predicate).first else {return nil}
        
        return result.entity
    }
    
    func insertOrUpdate(item: Any) {
        try? self.realm.write {
            let entityString = String(describing: type(of:item).self)
            
            guard let realmEntityType = RealmDatabase.entityMapping[entityString],
                let model = item as? Model else {return}
            let realmEntity = realmEntityType.init()
            realmEntity.configure(model: model)
            self.realm.add(realmEntity, update: true)
        }
    }
    
    func clean(entityString: String) {
        try? self.realm.write {
            guard let realmEntityType = RealmDatabase.entityMapping[entityString] else {return}
            let objects = self.realm.objects(realmEntityType)
            self.realm.delete(objects)
        }
    }
    
    func deleteById(idString: String, type: AnyClass) {
        let entityString = String(describing:type.self)
        guard let realmEntityType = RealmDatabase.entityMapping[entityString] else {return}
        let predicate = NSPredicate(format: "remoteKeyString == %@", idString)
        let results = self.realm.objects(realmEntityType).filter(predicate)
        try? self.realm.write {
            self.realm.delete(results)
        }
    }
}
