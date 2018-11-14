//
//  NotificationsViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 10/1/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    @IBOutlet weak var allowNotifications: UIButton!
    
    @IBOutlet weak var revealButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let reveal = self.revealViewController()
        reveal?.panGestureRecognizer().isEnabled = false
        revealButton.target = self
        revealButton.action = #selector(NotificationsViewController.revealToggle)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!]
        self.title = "Notifications"
        
        let noticationType = UIApplication.shared.currentUserNotificationSettings!.types
        if noticationType == [] { //no notifications
            print("none")
            allowNotifications.layer.borderWidth = 1
            allowNotifications.layer.borderColor = allowNotifications.tintColor.cgColor
            allowNotifications.layer.cornerRadius = 10
            allowNotifications.clipsToBounds = true
        } else {
            allowNotifications.setTitle("Notifications already enabled", for: .normal)
            allowNotifications.isUserInteractionEnabled = false
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func prompt(_ sender: UIButton) {
        //App-Prefs:root=NOTIFICATIONS_ID
        
        UIApplication.shared.openURL(URL(string:UIApplicationOpenSettingsURLString)!)
        /*UIApplication.shared.registerForRemoteNotifications()
        let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings) */
    }
    
    func revealToggle() {
        let reveal = self.revealViewController()
        reveal?.panGestureRecognizer().isEnabled = true
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        revealViewController().setFront(appDelegate?.mainViewController, animated: true)
        revealViewController().revealToggle(self) // Optional
        
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
