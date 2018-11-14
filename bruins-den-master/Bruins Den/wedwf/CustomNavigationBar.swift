//
//  CustomNavigationBar.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 9/30/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("in")
        if #available(iOS 11.0, *) {
            print("new")
            for subview in self.subviews {
                let stringFromClass = NSStringFromClass(subview.classForCoder)
                if stringFromClass.contains("BarContentView") {
                    subview.backgroundColor = UIColor.clear
                    print("new2.0")
                    subview.frame.size.height = 200
                }
            }
        }
        
    }

}
