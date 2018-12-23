//
//  ImportantDocumentsViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/22/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
import WebKit

class DocumentsViewController: UIViewController {


    @IBOutlet weak var webKit: WKWebView!
    
    var path = ""
    var docName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        path = Bundle.main.path(forResource: docName, ofType: "pdf")!
        let url = URL(fileURLWithPath: path)
        webKit.load(URLRequest(url: url))
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
