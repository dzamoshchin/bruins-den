//
//  SeasonsViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/25/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class SeasonsViewController: UIViewController {

    @IBOutlet weak var separator: UIView!
    
    @IBOutlet weak var fall: UIButton!
    
    @IBOutlet weak var winter: UIButton!
    
    
    @IBOutlet weak var spring: UIButton!
    var gender = -1 //0=man, 1=woman
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Seasons"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let line2 = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 1))
        line2.backgroundColor = UIColor.lightGray
        separator.addSubview(line2)
        
        fall.layer.cornerRadius = 10
        fall.clipsToBounds = true
        winter.layer.cornerRadius = 10
        winter.clipsToBounds = true
        spring.layer.cornerRadius = 10
        spring.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func click(_ sender: UIButton) {
        if sender.titleLabel?.text == "Fall Sports" {
            performSegue(withIdentifier: "toSubSports", sender: 1)
        } else if sender.titleLabel?.text == "Winter Sports" {
            performSegue(withIdentifier: "toSubSports", sender: 2)
        } else {
            performSegue(withIdentifier: "toSubSports", sender: 3)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toSubSports" {
            if let vc = segue.destination as? SubSportsTableViewController {
                vc.gender = self.gender
                vc.season = sender as! Int
            }
        }
    }
    

}
