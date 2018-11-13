//
//  TwitterViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/9/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//x

import UIKit
import TwitterKit

class TwitterViewController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = TWTRAPIClient()
        self.dataSource = TWTRUserTimelineDataSource(screenName: "CherryCreekSN", apiClient: client)
        //self.dataSource = TWTRListTimelineDataSource(listSlug: "Archetapp", listOwnerScreenName: "Archetapp", apiClient: client)

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
