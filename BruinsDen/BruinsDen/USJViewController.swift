//
//  USJViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/19/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class USJViewController: UIViewController {

    
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        //self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "TopNavBarBackground2"), for: .default)
        //navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!]
        self.title = "USJ"
        webView.loadRequest(NSURLRequest(url: NSURL(string: "http://unionstreetjournal.com/")! as URL) as URLRequest)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        if isMovingFromParentViewController {
            let reveal = self.revealViewController()
            reveal?.panGestureRecognizer().isEnabled = true
        }
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