//
//  EventViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/20/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    
    
    @IBOutlet weak var t: UILabel!
    var titleText = ""
    @IBOutlet weak var start: UILabel!
    var startText = ""
    @IBOutlet weak var end: UILabel!
    var endText = ""
    
    @IBOutlet weak var desc: UILabel!
    var descr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        t.text = titleText
        start.text = startText
        end.text = endText
        desc.text = descr

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
