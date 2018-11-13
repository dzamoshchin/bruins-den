//
//  Department.swift
//  Teachers
//
//  Created by Student on 5/3/17.
//  Copyright © 2017 CCHS. All rights reserved.
//

import UIKit

class Department: NSObject {
    //MARK: Properties
    
    var name: String
    var teachers: [Teacher1]
    
    //MARK: Initialization
    
    init(n: String, t: [Teacher1]) {
        name = n
        teachers = t
    }
}
