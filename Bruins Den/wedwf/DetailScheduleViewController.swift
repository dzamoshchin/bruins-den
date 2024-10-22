//
//  DetailScheduleViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/24/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class DetailScheduleViewController: UIViewController {
    var type = -1 //what bell schedule to display
    var container : BellScreenContainerViewController?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.imageView.translatesAutoresizingMaskIntoConstraints = true
        print("Type")
        print(type)
        switch(type){
        case 0:
            self.title = "Regular School Day"
        case 1:
            self.title = "Storm Delay Schedule"
        case 2:
            self.title = "Assembly"
        default:
            self.title = "Final Exams"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toSchedule" {
            container = segue.destination as? BellScreenContainerViewController
            print("TYPE: \(type)")
            container?.sc = type
        }
    }
    

}
