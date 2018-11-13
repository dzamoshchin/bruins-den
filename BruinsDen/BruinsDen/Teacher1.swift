//
//  Teacher.swift
//  Teachers
//
//  Created by Student on 5/3/17.
//  Copyright © 2017 CCHS. All rights reserved.
//

import UIKit

class Teacher1: NSObject{
    let photo: UIImage?
    let uName: String?
    let fName: String?
    let lName: String?
    let office: String?
    let phone: String?
    let email: String?
    let schedule: String?
    
    init(un: String, fn: String, ln: String, p: UIImage, o: String, ph: String, e: String, s: String) {
        uName = un
        fName = fn
        lName = ln
        photo = p
        office = o
        phone = ph
        email = e
        schedule = s
    }
    
    override var description: String{
        return "\(uName!), \(fName!), \(lName!), \(office!), \(phone!), \(schedule!)"
    }
}
