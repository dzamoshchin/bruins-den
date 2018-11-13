//
//  TeachersViewController.swift
//  Teachers
//
//  Created by J Lee on 5/12/17.
//  Copyright © 2017 CCHS. All rights reserved.
//

import UIKit
var colorTint = UIColor.blue
class TeachersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    var filter = [Teacher1]()
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive2 = false
    var emptySearch2 = true
    
    
    @IBOutlet weak var tableView: UITableView!
    var department: Department?
    var teachers = [Teacher1]()
    
    //MARK: Private Methods
    
    private func loadSampleTeachers() {
//        let names = ["Anderson, Paul", "Barber, Michelle", "Berndt, Michael", "Carlson, Jill", "Carter, Chris", "Dady, Dotty", "Degitis, Mike", "Dertinger, Kent", "Dertinger, Kim", "Goeglein, Dara", "McDavid, Delisa"]
//        let photos = [UIImage(named: "Math_1_Anderson"), UIImage(named: "Math_2_Barber"), UIImage(named: "Math_3_Berndt"), UIImage(named: "Math_4_Carlson"), UIImage(named: "Math_5_Carter"), UIImage(named: "Math_6_Dady"), UIImage(named: "Math_7_Degitis"), UIImage(named: "Math_8_Dertinger(M)"), UIImage(named: "Math_9_Dertinger(F)"), UIImage(named: "Math_10_Goeglein"), UIImage(named: "Math_11_McDavid")]
//        for i in 0..<photos.count {
//            let t = Teacher1(n: names[i], p: photos[i]!)
//            teachers += [t]
//        }
        teachers = (department?.teachers)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorTint = view.tintColor
        searchBar.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //tableView.tableHeaderView = nil
        loadSampleTeachers()
        teachers.sort(by: { (one : Teacher1, two : Teacher1) -> Bool in
            let str1 = "\(one.lName!), \(one.fName!)"
            let str2 = "\(two.lName!), \(two.fName!)"
            return str1.localizedCaseInsensitiveCompare(str2) == ComparisonResult.orderedAscending
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Searching
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive2 = true
        searchBar.setShowsCancelButton(true, animated: true)
        //searchActive2 = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchActive2 = false
        tableView.reloadData()
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive2 = false
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive2 = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filter = (teachers.filter({ (text) -> Bool in
            let tmp: String = "\(text.lName!), \(text.fName!)"
            
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
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive2 && !emptySearch2{
            return filter.count
        }
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TeacherTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TeacherTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TeacherTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        var teacher = teachers[indexPath.row]
        if searchActive2 && !emptySearch2 {
            teacher = filter[indexPath.row]
        }
        cell.name.text = "\(teacher.lName!), \(teacher.fName!)"
        cell.pic.image = teacher.photo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchActive2 && !emptySearch2 {
            performSegue(withIdentifier: "ShowDetail", sender: filter[indexPath.row])
        } else {
            performSegue(withIdentifier: "ShowDetail", sender: teachers[indexPath.row])
        }
        searchBar.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //super.prepare(for: segue, sender: sender)
        if segue.identifier == "ShowDetail" {
            if let vc = segue.destination as? ProfileViewController {
                vc.teacher = sender as! Teacher1
            }
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
