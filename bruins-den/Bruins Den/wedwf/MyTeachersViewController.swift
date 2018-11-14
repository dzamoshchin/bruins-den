//
//  TeachersViewController.swift
//  Teachers
//
//  Created by J Lee on 5/12/17.
//  Copyright © 2017 CCHS. All rights reserved.
//

import UIKit

class MyTeachersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var teachers = [Teacher1]()
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Private Methods
    
    private func loadSampleTeachers() {
       /* var t = [Teacher1.init(n: "Riegler, Kirsten", p: UIImage(named: "KIRSTEN RIEGLER")!, o: "E 206A", ph: "720-554-2334", e: "kriegler", s: ["Off", "Off", "Off", "CP English 9 - E 304", "Off", "CP English 9 - E 304", "AP Lang - E 300", "AP Lang - E 304"])]
        t += [Teacher1.init(n: "Sommer, Amy", p: UIImage(named: "AMY SOMMER")!, o: "IC 730C", ph: "720-554-2490", e: "asommer", s: ["Off", "Off", "Off", "Off", "Off", "Latin 3/4 H - IC 716", "CP Latin 2 - IC 716", "AP Latin - IC 716"])]
        t += [Teacher1.init(n: "Dwyer, Cayel", p: UIImage(named: "CAYEL DWYER")!, o: "W 429C", ph: "720-554-2300", e: "ldwyer", s: ["Off", "Off", "Off", "Intervention - W 544", "Off", "Intervention - W 544", "PreCalc Trig - W 441", "Alg 2/Trig H - W 441"])]
        t += [Teacher1.init(n: "Bailey, Carl", p: UIImage(named: "CARL BAILEY")!, o: "W 428A", ph: "720-554-2513", e: "cbailey4", s: ["Off", "AP Biology - W 427", "AP Biology - W 427", "CP Chemistry - W94", "Off", "CP Chemistry - W94", "CP Chemistry - W94", "CP Chemistry - W94"])]
        t += [Teacher1.init(n: "Best, Jodi", p: UIImage(named: "JODI BEST")!, o: "IC 701A", ph: "720-554-2173", e: "jbest5", s: ["AP World History - IC 735", "​​AP World History - IC 735", "CP World History - IC 735", "Off", "Off", "CP Humanities 10 - IC 735", "CP Humanities 10 - IC 735", "Off"])]
        teachers = t*/
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadSampleTeachers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TeacherTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TeacherTableViewCell  else {
            fatalError("The dequeued cell is not an instance of TeacherTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let teacher = teachers[indexPath.row]
        
        cell.name.text = teacher.uName
        cell.pic.image = teacher.photo
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(teachers[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowDetail":
            guard let teach = segue.destination as? ProfileViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedDepartmentCell = sender as? TeacherTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedDepartmentCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedTeacher = teachers[indexPath.row]
            teach.teacher = selectedTeacher
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
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
