//
//  Club.swift
//  Clubs
//
//  Created by J Lee on 7/26/17.
//  Copyright © 2017 J Lee. All rights reserved.
//

import UIKit

class Club: NSObject {
    var name: String?
    var sponsor: String?
    var office: String?
    var location: String?
    var days: String?
    var times: String?
    var desc: String?
    var email: String?
    
    init(n: String, s: String, o: String, l: String, d: String, t: String, de: String, e: String){
        name = n
        sponsor = s
        office = o
        location = l
        days = d
        times = t
        desc = de
        email = e
    }
}
