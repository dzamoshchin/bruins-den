//
//  ImportantDocumentsViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/22/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var path = ""
    var docName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        path = Bundle.main.path(forResource: docName, ofType: "pdf")!
        
        let url = NSURL.fileURL(withPath: path)
        
        webView.loadRequest(URLRequest(url: url))

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
