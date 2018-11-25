//
//  Sports.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/25/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import Foundation
import UIKit

class Sport {
    var name : String
    var icon : UIImage
    init(_ n : String, _ i : UIImage) {
        name = n
        icon = i
    }
    init() {
        name = ""
        icon = #imageLiteral(resourceName: "baseballIcon")
    }
    
}
