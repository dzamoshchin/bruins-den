//
//  AthleticsViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/8/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
import TwitterKit
import WebKit

class AthleticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var webView: WKWebView!
    
    //Twitter tutorial: https://www.youtube.com/watch?v=ODTNtwnk6_E
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([ NSAttributedString.Key.font.rawValue: UIFont(name: "HelveticaNeue-Light", size: 25)!])
        tableView.delegate = self
        self.navigationController?.navigationBar.tintColor = UIColor.black
        tableView.dataSource = self
        self.title = "Athletics"

//        webView.loadHTMLString("<html><head><meta name='viewport' content='initial-scale=1.0,width=device-width,user-scalable=no,minimum-scale=1.0,maximum-scale=1.0'></head><body><a class='twitter-timeline' href='https://twitter.com/CherryCreekSN?ref_src=twsrc%5Etfw'>Tweets by CherryCreekSN</a> <script async src='https://platform.twitter.com/widgets.js' charset='utf-8'></script></body></html>", baseURL: nil)
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "AthleticsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AthleticsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of AthleticsTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        if indexPath.row == 0 {
            cell.name.text = "Men's Sports"
        } else {
            cell.name.text = "Women's Sports"
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toSeasons", sender: indexPath.row)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toSeasons" {
            if let vc = segue.destination as? SeasonsViewController {
                vc.gender = sender as! Int
            }
        }
    }
    

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
