//
//  SideBarViewController.swift
//  wedwf
//
//  Created by hari sowrirajan on 5/5/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class SideBarViewController: UIViewController {
    
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var versionLabel: UILabel!
    
    
    @IBOutlet weak var contact: UIButton!
    
    @IBAction func unwindToSideMenu(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navBar.shadowImage = UIImage()


        let line = UIView(frame: CGRect(x: 0, y: 0, width: contact.frame.size.width, height: 1))
        line.backgroundColor = UIColor.black
        contact.addSubview(line)
        versionLabel.layer.borderColor = UIColor.black.cgColor
        versionLabel.layer.borderWidth = 1
        
        
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
    
    func addLine(_ start: CGPoint, _ end:CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.black.cgColor
        line.lineWidth = 1
        line.lineJoin = CAShapeLayerLineJoin.round
        self.view.layer.addSublayer(line)
    }

}
