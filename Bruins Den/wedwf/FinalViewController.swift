//
//  FinalViewController.swift
//  Bruins Den
//
//  Created by Daniel Zamoshchin on 12/26/18.
//  Copyright © 2018 Cherry Creek High School. All rights reserved.
//

import UIKit

class FinalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var firstSemester = false
    
    let times: [String] = ["​8:20-9:05", "9:15-10:45", "​10:55-12:25", "Lunch", "​1:10-2:40", "​2:40-3:30"]
    
    let periodsSem1: [[String]] = [["PREP*", "​Period 3", "Period 7", "--", "PREP*/Student Conferences", "PREP*/Student Conferences"], ["PREP*", "Period 1", "Period 4", "--", "Period 8", "PREP*/Student Conferences"], ["PREP*", "Period 2", "Period 5", "--", "Period 5", "Student Conferences"], ["Teachers submit grades"]]
    
    let periodsSem2: [[String]] = [["PREP*", "​Period 1", "Period 4", "--", "Period 8", "PREP*/Student Conferences"], ["PREP*", "Period 2", "Period 6", "--", "Period 5", "PREP*/Student Conferences"], ["PREP*", "Period 3", "Period 7", "--", "PREP*/Student Conferences", "Student Conferences"], ["Teachers submit grades"]]
    
    let sectionNameSem1: [String] = ["​Dec. 18, 2018 (Tuesday)", "​​Dec. 19, 2018 (Wednesday)", "​​Dec. 20, 2018 (Thursday)", "​​Dec. 21, 2018 (Friday)"]

    let sectionNameSem2: [String] = ["​May 20, 2019 (Monday)", "​​May 21, 2019 (Tuesday)", "​​May 23, 2019 (Thursday)", "​​May 24, 2019 (Friday)"]

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < 3 {
            return 6
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "schedule"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FinalsTableViewCell else {
            fatalError("The dequeued cell is not an instance of FinalsTableViewCell.")
        }
        
        cell.time.text = times[indexPath.row]
        print(indexPath.section)
        print(indexPath.row)
        if(firstSemester) {
            cell.period.text = periodsSem1[indexPath.section][indexPath.row]
        } else {
            cell.period.text = periodsSem2[indexPath.section][indexPath.row]
        }
        
        return cell
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tab: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([ NSAttributedString.Key.font.rawValue: UIFont(name: "HelveticaNeue-Light", size: 25)!])
        self.title = "Final Exams"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func action(_ sender: Any) {
        if tab.selectedSegmentIndex == 0 {
            firstSemester = true
        } else if tab.selectedSegmentIndex == 1 {
            firstSemester = false
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(firstSemester) {
            return sectionNameSem1[section]
        } else {
            return sectionNameSem2[section]
        }
    }
    
    func makeLabel(_ text: String) -> UILabel{
        let label = UILabel()
        label.text  = text
        label.textAlignment = .center
        return label
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
