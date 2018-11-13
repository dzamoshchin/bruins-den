//
//  Event.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 6/16/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import Foundation

class Event: NSObject, NSCopying, NSCoding  {
    
    
    var title : String
    var message : String
    var hour : Int
    var minute : Int
    var AM : String
    var endTime = ""
    var location = ""
    var startDate = DateComponents()
    var lastDay : String?
    init(_ t : String, _ m : String, _ time : String) {
        title = t
        message = m
        let timeArr = time.components(separatedBy: " ")
        hour = Int(timeArr[0])!
        minute = Int(timeArr[1])!
        AM = timeArr[2]
        
        
        
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(message, forKey: "message")
        aCoder.encode(hour, forKey: "hour")
        aCoder.encode(minute, forKey: "minute")
        aCoder.encode(AM, forKey: "AM")
        aCoder.encode(endTime, forKey: "endTime")
        aCoder.encode(location, forKey: "location")
        aCoder.encode(startDate, forKey: "start")
        aCoder.encode(lastDay, forKey: "last")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        message = aDecoder.decodeObject(forKey: "message") as! String
        hour = aDecoder.decodeInteger(forKey: "hour")
        minute = aDecoder.decodeInteger(forKey: "minute")
        AM = aDecoder.decodeObject(forKey: "AM") as! String
        endTime = aDecoder.decodeObject(forKey: "endTime") as! String
        location = aDecoder.decodeObject(forKey: "location") as! String
        startDate = aDecoder.decodeObject(forKey: "start") as! DateComponents
        lastDay = aDecoder.decodeObject(forKey: "last") as? String
        
    }
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Event(title, message, "12 00 AM")
        copy.hour = hour
        copy.minute = minute
        copy.AM = AM
        copy.endTime = endTime
        copy.location = location
        copy.startDate = startDate
        copy.lastDay = lastDay
        return copy
    }
   
}
