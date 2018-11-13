//
//  EventDate.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 6/16/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import Foundation

class EventDate : NSObject, NSCoding{
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(date, forKey: "d")
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: event)
        aCoder.encode(encodedData, forKey: "ev")
        print("encode eventdate")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.date = aDecoder.decodeObject(forKey: "d") as! DateComponents
        //This probably needs to be fixed with the data hack
        let e = aDecoder.decodeObject(forKey: "ev") as! Data
        self.event = NSKeyedUnarchiver.unarchiveObject(with: e) as! [Event]
        print("decode eventdate")
        
    }
    
    var date : DateComponents
    var event = [Event]()
    init(_ d : DateComponents) {
        date = d
        
    }
    override var description : String {
        return String(date.month!) + "/" + String(date.day!) + "/" + String(date.year!)
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let rhs = object as? EventDate {
            return self.date == rhs.date
        }
        return false
        
    }
    
    
    
    
}

