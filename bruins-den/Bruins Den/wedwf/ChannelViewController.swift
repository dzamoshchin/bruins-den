//
//  ChannelViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 10/1/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BBN Channel"
        webView.loadRequest(NSURLRequest(url: NSURL(string: "https://www.youtube.com/channel/UCdYMCaldtMZ5LnzMZvQujQA")! as URL) as URLRequest)

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
