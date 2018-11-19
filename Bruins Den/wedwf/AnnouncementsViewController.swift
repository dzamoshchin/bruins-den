//
//  AnnouncementsViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/17/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
import FirebaseDatabase
import WebKit

class AnnouncementsViewController: UIViewController, UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource, WKNavigationDelegate {
    

    @IBOutlet weak var videoView: WKWebView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var announcements = [String]()
    var expandedLabel : UILabel!
    var indexOfCellToExpand = -1
    var original = 0
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!]
        self.title = "Announcements"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let ref = Database.database().reference(withPath: "Announcements")
        print("b4")
        ref.observeSingleEvent(of: .value, with: {snapshot in
            print("looking")
            if let dict = snapshot.value as? NSDictionary{
                print("not fail")
                
                if let c = dict.value(forKey: "Text") as? String {
                    self.announcements = c.components(separatedBy: "||")
                    self.tableView.reloadData()
                }
                print(dict.value(forKey: "Text") as! String)
                let youtubeURL = dict.value(forKey: "Link") as! String
                self.videoView.scrollView.contentInset = UIEdgeInsets.zero
//                self.videoView.allowsInlineMediaPlayback = true
                let url = URL(string: youtubeURL)!
                self.videoView.load(URLRequest(url: url))
                self.videoView.allowsBackForwardNavigationGestures = true
//                self.videoView.loadHTMLString("<iframe width=\"\(self.videoView.frame.width)\" height=\"\(self.videoView.frame.height)\" src=\"\(youtubeURL)?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
                self.videoView.reload()
            }
        })
        
        //announcements = ["rfnergnreogeorgi erogjeroigjeogjoer gjoerjgoierjgoejrog", "rfnergnreogeorgierogj eroigjeogjoerg joerjgoierjgoejrog", "wnfejrgiergnkergherkgneriugjnerkgergnfvjdfgligjlergergnerligerlgkerlgirejlgejrogjerlgjergjergljerigjerlgjerlgerlgkjeergjnerkgjenrjgnerkjgekrgnkerjngkejrngkerjg"]
        
        videoView.navigationDelegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        

        // Do any additional setup after loading the view.
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController {
            let reveal = self.revealViewController()
            reveal?.panGestureRecognizer().isEnabled = true
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Announcements") as! AnnouncementsTableViewCell
        if indexPath.row == 0 {
            cell.heading.text = "Bruins Broadcasting Network"
            cell.title.text = "Link to Channel"
            cell.title.textColor = UIColor.blue
            return cell
        }
        cell.title.textColor = UIColor.black
        let str = announcements[indexPath.row-1]
        let index = str.range(of: ".")
        
        let head = str.substring(to: (index?.lowerBound)!)
        cell.heading.text = head
        cell.title.text = str.substring(from: (index?.upperBound)!).trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "channel", sender: self)
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
