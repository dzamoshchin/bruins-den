//
//  ViewController.swift
//  Clubs
//
//  Created by J Lee on 7/26/17.
//  Copyright © 2017 J Lee. All rights reserved.
//

import UIKit
import Firebase

class ClubViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var firstTime = false
    var filter = [Club]()
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive2 = false
    var emptySearch2 = true
   
    @IBOutlet weak var origina: UIView!
    @IBOutlet weak var clubPic: UIImageView!
    
    @IBOutlet weak var move: UIView!
    var containerViewController: ClubProfileViewController? //holds the table view
    @IBOutlet weak var tableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if firstTime {
            return 0
        }
        if searchActive2{
            return filter.count
        }
        return (clubs.count)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if searchActive2{
            performSegue(withIdentifier: "toClubProfile", sender: tableView.cellForRow(at: indexPath))
        } else {
            performSegue(withIdentifier: "toClubProfile", sender: tableView.cellForRow(at: indexPath))
        }
        searchBar.endEditing(true)

    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClubCell", for: indexPath) as? ClubTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ClubTableViewCell.")
        }
        var club = clubs[indexPath.row]
        
        
        if searchActive2 && !firstTime{
            club = filter[indexPath.row]
        }
        
        cell.clubName.text = club.name
        cell.club = club
        if firstTime {
            cell.clubName.text = ""
            cell.club = Club(n: "", s: "", o: "", l: "", d: "", t: "", de: "", e: "")
        }
        
        return (cell)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!]
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        searchBar.delegate = self
        self.title = "Clubs"
        
       
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController {
            let reveal = self.revealViewController()
            reveal?.panGestureRecognizer().isEnabled = true
        }
    }
    
    //Searching
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive2 = true
        firstTime = true
        searchBar.setShowsCancelButton(true, animated: true)
        UIView.animate(withDuration: 0.5, animations: {
            self.tableView.frame = self.move.frame
            
            self.clubPic.alpha = 0
            /*var frame = self.container1.frame
             //frame.origin.y -= self.container1.frame.height
             frame.origin.y -= moveHeight
             self.container1.frame = frame */
        })
        tableView.reloadData()
        //searchActive2 = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchActive2 = false
        firstTime = false
        UIView.animate(withDuration: 0.5, animations: {
            /*var frame = self.container1.frame
             frame.origin.y += moveHeight
             self.container1.frame = frame */
            self.tableView.frame = self.origina.frame
            self.clubPic.alpha = 1
        })
        
        tableView.reloadData()
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive2 = false
        searchBar.endEditing(true)
        filter = [Club]()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive2 = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        firstTime = false
        self.filter = (clubs.filter({ (text) -> Bool in
            let tmp: String = "\(text.name)"
            
            let range = tmp.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            //let range = tmp.rangeOfString(searchText, options: NSString.CompareOptions.CaseInsensitiveSearch)
            return range != nil
        }))
        searchActive2 = true
        if searchText.characters.count != 0 {
            emptySearch2 = false
        } else {
            emptySearch2 = true
        }
        tableView.reloadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toClubProfile" {
            if let vc = segue.destination as? ClubProfileViewController {
                vc.club = (sender as! ClubTableViewCell).club
            }
        }
    }
    
    
}
