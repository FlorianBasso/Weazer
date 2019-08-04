//
//  Model.swift
//  Weazer
//
//  Created by Florian Basso on 14/04/2019.
//  Copyright © 2019 Roaflin. All rights reserved.
//

import Foundation

open class Model: NSObject {
    
    // MARK: - Properties
    
    open var remoteKey: Int = 0 // object id
    open var remoteKeyString : String = "0" // object id String

    
    public struct Constants {
        public static let id = "id"
    }
    
    // MARK: - Init
    
    required override public init() {
        // Allows to have a simple init without parameters
    }
    
    public convenience init?(remoteKey : Int) {
        if remoteKey != 0 {
            self.init(data: [Constants.id: remoteKey])
        } else {
            return nil
        }
    }
    
    public init(data: [AnyHashable: Any]) {
        super.init()
        self.commonInit(data: data)
    }
    
    func commonInit(data: [AnyHashable: Any]) {
        self.remoteKey = self.remoteKey(inRepresentation: data)
        self.parse(data: data)
    }
    
    func remoteKey(inRepresentation representation: [AnyHashable: Any]) -> Int {
        guard let remoteKey = representation[Constants.id] as? Int else {
                return 0
        }
        return remoteKey
    }
    
    open func parse(data: [AnyHashable:Any]) {
        // Override in subclasses
    }
    
    open class func parseArray(data:[[AnyHashable:Any]]?) -> [Model]?  {
        guard let json = data else {
            return nil
        }
        
        var array = [Model]()
        
        for objDict in json {
            let object = self.init()
            object.commonInit(data: objDict)
            array.append(object)
        }
        
        return array
    }
        
    override open func isEqual(_ object: Any?) -> Bool {
        guard let otherObject = object as? Model else {
            return false
        }
        
        if type(of: self) === type(of: otherObject) {
            return otherObject.remoteKey == self.remoteKey
        } else {
            return false
        }
    }
    
}
