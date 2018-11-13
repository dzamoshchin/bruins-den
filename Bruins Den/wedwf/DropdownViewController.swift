//
//  DropdownViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 9/2/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
import AZDropdownMenu
class DropdownViewController: UIViewController {
    var titles = [String]()
    var menu : AZDropdownMenu?
    @IBOutlet weak var pdfDisplay: UIWebView!
    var path = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        path = Bundle.main.path(forResource: "West Building", ofType: "pdf")!
        let url = NSURL.fileURL(withPath: path)
        
        let arr = ["West Building", "East Building", "IC Building", "Fine Arts", "Full Campus"]
        pdfDisplay.loadRequest(URLRequest(url: url))
        /*
        menu?.cellTapHandler = { [weak self] (indexPath: NSIndexPath) -> Void in
            let url2 = NSURL.fileURL(withPath: arr[indexPath.row])
            pdfDisplay.loadRequest(URLRequest(url: url2))
        } */

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showDropdown() {
        if (self.menu?.isDescendant(of: self.view) == true) {
            self.menu?.hideMenu()
        } else {
            self.menu?.showMenuFromView(self.view)
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
