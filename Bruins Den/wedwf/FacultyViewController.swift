//
//  FacultyViewController.swift
//  wedwf
//
//  Created by Student on 5/19/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
var searchActive = false
var filtered : [Teacher1] = []
var emptySearch = true


class FacultyViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    


    @IBOutlet weak var download: UIImageView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var container1: UIView!
    
    var containerViewController: DepartmentViewController? //holds the table view
    
    @IBOutlet weak var originalFrame: UIView!
    
    
    @IBOutlet weak var endFrame: UITableView!
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DEPART \(departments.count)")
        print("total \(totalTeachers.count)")
        emptySearch = true
        //self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "TopNavBarBackground2"), for: .default)
        //self.navigationController?.navigationBar.tintColor = UIColor.black
        
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!]
        
        endFrame.delegate = self
        endFrame.dataSource = self
        
        
        
        //THIS GETS RID OF BACK TEXT ON SUBSEQUENT SCENES
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        searchBar.delegate = self

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //var movingupheight = self.navigationController?.navigationBar.frame.height
        searchActive = true
        
        //var moveHeight = view.frame.height - container1.frame.height - searchBar.frame.height - (self.navigationController?.navigationBar.frame.height)!
        var moveHeight = endFrame.frame.height
        UIView.animate(withDuration: 0.5, animations: {
            self.container1.frame = self.endFrame.frame
            self.endFrame.alpha = 1
            self.download.alpha = 0
            /*var frame = self.container1.frame
            //frame.origin.y -= self.container1.frame.height
            frame.origin.y -= moveHeight
            self.container1.frame = frame */
        })
        endFrame.reloadData()
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("done editing")
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchActive = false;
        
        UIView.animate(withDuration: 0.5, animations: {
            /*var frame = self.container1.frame
            frame.origin.y += moveHeight
            self.container1.frame = frame */
            self.endFrame.alpha = 0
            self.container1.frame = self.originalFrame.frame
            self.download.alpha = 1
        })
        containerViewController?.tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.endEditing(true)
        searchBar.text = ""
        filtered = [Teacher1]()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(containerViewController?.departments.count)
        
        filtered = (totalTeachers.filter({ (text) -> Bool in
            let tmp: String = "\(text.lName!), \(text.fName!)"
            
            let range = tmp.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            //let range = tmp.rangeOfString(searchText, options: NSString.CompareOptions.CaseInsensitiveSearch)
            return range != nil
        }))
        print(filtered.count)
        searchActive = true
        
        endFrame.reloadData()
        //containerViewController?.tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        /*UIView.animate(withDuration: 2, animations: {
            var frame = self.container1.frame
            frame.origin.y -= self.container1.frame.height
            self.container1.frame = frame
        }) */
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController {
            let reveal = self.revealViewController()
            reveal?.panGestureRecognizer().isEnabled = true
        }
    }
    
    //Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        }
        return totalTeachers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "teach"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchTeachersTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SearchTeachersTableViewCell.")
        }
        var teacher = totalTeachers[indexPath.row]
        if searchActive {
            teacher = filtered[indexPath.row]
        }
        cell.name.text = "\(teacher.lName!), \(teacher.fName!)"
        cell.pic.image = teacher.photo
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        endFrame.deselectRow(at: indexPath, animated: true)
        if searchActive {
            searchBar.text = ""
            emptySearch = true
            endFrame.reloadData()
            //searchBar.endEditing(true)
            performSegue(withIdentifier: "ShowTeach", sender: filtered[indexPath.row])
        } else {
            performSegue(withIdentifier: "ShowTeach", sender: totalTeachers[indexPath.row])
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDepartment" {
            containerViewController = segue.destination as! DepartmentViewController
        } else if segue.identifier == "ShowTeach" {
            if let vc = segue.destination as? ProfileViewController {
                vc.teacher = sender as! Teacher1
            }
        }
    }
 
    
    //Animation to push out profile pic:
    //https://stackoverflow.com/questions/29702116/moving-uitableview-position-in-swift
    //https://stackoverflow.com/questions/7301022/shifting-uitableview-down-uitableviewcontroller
    
    

}
