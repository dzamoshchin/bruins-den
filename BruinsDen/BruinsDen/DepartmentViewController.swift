//
//  DepartmentViewController.swift
//  Teachers
//
//  Created by J Lee on 5/12/17.
//  Copyright © 2017 CCHS. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage


class DepartmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //PROPERTIES
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var placeHold = UIImageView(image: #imageLiteral(resourceName: "Calendar"))
    
    
    //MARK: Private Methods
    
    private func loadDepartments() {
        
        // reference to database at the department branch
        let ref = Database.database().reference(withPath: "Faculty/Department")
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        //let imagesRef = storageRef.child("images")
        let placeholder = UIImage(named: "placeholder.jpg")
        
        
        
        
        //an array to hold all the keys of the departments to be used for later reference paths
        var keys: [String] = []
        
        
        //This next entire method call (yes it is all one singular call of the 'observeSingleEvent(of: , with: )' method 
        //used to take data from the database) is tricky to explain. You get the data through one of the parameters (weird right?)
        //and for some reason swift likes to split things up and everything outside of the method 'observeSingleEvent' will be finished
        //before everything inside, meaning everything inside will be gotten too late if it is used outside. Example: I want to get all of the department
        //keys and put them in the 'keys' array above, well if I did 'for key in keys{}' outside of the method call to get thte keys 'keys' would be 
        //empty when the for loop looks at it. So to make sure that that does not happen, we had to put everything using that data
        //inside the method that gets that data, and since the data we need is three levels deep (department>teacher>teacher-info) there
        //is another 'observeSingleEvent' call each within the previous level (for a grand total of three calls alltogether). There are also 
        //two if statements all the way in the teacher information call to check if all the departments and teachers have been created.
        //Also it is probably good to mention that data taken from the database is most easily casted into a dictionary which is why we do
        //that for every level of data we look at.
        
        //now looking at department level
        if facultyLoaded == 0 {
            facultyLoaded += 1
            ref.observeSingleEvent(of: .value, with: {snapshot in
                if let dict = snapshot.value as? NSDictionary{
                    //gets all the keys (aka names) of all the departments in the database
                    for entry in dict{
                        keys.append((entry.key as? String)!)
                    }
                    
                    //for each department...
                    for key in keys{
                        //create a more specific reference to the database that is just for the current department being looked at
                        let tempref = Database.database().reference(withPath: "Faculty/Department/\(key)")
                        
                        //a temp department object that will have all the teachers added to it as the teachers are created, then added to 'departments' property above
                        let dept = Department(n: key, t: [])
                        
                        //a list of keys for all of the teachers, will be added to later, and is also used for path strings like 'keys' was
                        var facs: [String] = []
                        
                        //now looking at the teacher level
                        tempref.observeSingleEvent(of: .value, with: {snapshot in
                            if let dict = snapshot.value as? NSDictionary{
                                //gets all teacher keys
                                for entry in dict{
                                    facs.append((entry.key as? String)!)
                                }
                            }
                            
                                                                      
                            //for each teacher...
                            for fac in facs{
                                //an even more specific reference just to look at the teacher's info
                                let temp2ref = Database.database().reference(withPath: "Faculty/Department/\(key)/\(fac)")
                                print(fac)
                                
                                //now looking at teacher-info level
                                temp2ref.observeSingleEvent(of: .value, with: {snapshot in
                                    if let dict = snapshot.value as? NSDictionary{
                                        //first name
                                        let fName = dict["firstName"] as? String ?? ""
                                        //last name
                                        let lName = dict["lastName"] as? String ?? ""
                                        //office
                                        let Office = dict["office"] as? String ?? ""
                                        //phone
                                        let Phone = dict["phone"] as? String ?? ""
                                        //schedule
                                        let Sched = dict["schedule"] as? String ?? ""
                                        //image
                                        var photo: UIImage = #imageLiteral(resourceName: "sample")
                                        var facRef:StorageReference
                                        var str = " "
                                        if fac.hasPrefix("*"){
                                            str = fac.substring(from: fac.index(fac.startIndex, offsetBy: 1))
                                            facRef = storageRef.child("images/faculty/\(str).jpg")
                                        }else{
                                            str = fac
                                            facRef = storageRef.child("images/faculty/\(fac).jpg")
                                        }
                                        
                                        if let r = UIImage(named: str) {
                                            photo = r
                                            
                                            //teacher has a username, which is their key, first name, last name, image (add this later), office, phone, email which is created from their username, and a schedule
                                            let teach = Teacher1(un: fac, fn: fName, ln: lName, p: photo, o:    Office, ph: Phone, e: fac + "@cherrycreekschools.org", s: Sched)
                                            
                                            //add a teacher to the temp department
                                            dept.teachers.append(teach)
                                            totalTeachers.append(teach)
                                            
                                            
                                            //if all the teachers in a department are created then add the department to 'departments'
                                            if(dept.teachers.count == facs.count){
                                                print("ALL TEACHERS ACCOUTNED FOR")
                                                departments.append(dept)
                                            }
                                            
                                            
                                            //if all the departments are created then reload the data in the table since it will previously have nothing
                                            if(departments.count == keys.count){
                                                print("ALL DEPARTMENTS ACCOUNTED FOR")
                                                departments.sort(by: { (one : Department, two : Department) -> Bool in
                                                    return one.name.localizedCaseInsensitiveCompare(two.name) == ComparisonResult.orderedAscending
                                                })
                                                self.tableView.reloadData()
                                                let vc = self.parent as! FacultyViewController
                                                vc.endFrame.reloadData()
                                            }
                                            
                                        }else{
                                            facRef.downloadURL { (url, error) in
                                                if url != nil{
                                                    if let data = NSData(contentsOf: url!){
                                                        if let image = UIImage(data: data as Data){
                                                            photo = image
                                                            print("photo set to image")
                                                        }
                                                    }
                                                }
                                                
                                                
                                                
                                                
                                                //teacher has a username, which is their key, first name, last name, image (add this later), office, phone, email which is created from their username, and a schedule
                                                let teach = Teacher1(un: fac, fn: fName, ln: lName, p: photo, o:    Office, ph: Phone, e: fac + "@cherrycreekschools.org", s: Sched)
                                                
                                                //add a teacher to the temp department
                                                dept.teachers.append(teach)
                                                totalTeachers.append(teach)
                                                
                                                
                                                //if all the teachers in a department are created then add the department to 'departments'
                                                if(dept.teachers.count == facs.count){
                                                    print("ALL TEACHERS ACCOUTNED FOR")
                                                    departments.append(dept)
                                                }
                                                
                                                
                                                //if all the departments are created then reload the data in the table since it will previously have nothing
                                                if(departments.count == keys.count){
                                                    print("ALL DEPARTMENTS ACCOUNTED FOR")
                                                    departments.sort(by: { (one : Department, two : Department) -> Bool in
                                                        return one.name.localizedCaseInsensitiveCompare(two.name) == ComparisonResult.orderedAscending
                                                    })
                                                    totalTeachers.sort(by: { (one : Teacher1, two : Teacher1) -> Bool in
                                                        let str1 = "\(one.lName!), \(one.fName!)"
                                                        let str2 = "\(two.lName!), \(two.fName!)"
                                                        return str1.localizedCaseInsensitiveCompare(str2) == ComparisonResult.orderedAscending
                                                    })
                                                    self.tableView.reloadData()
                                                    let vc = self.parent as! FacultyViewController
                                                    vc.endFrame.reloadData()
                                                }
                                            }
                                        }
                                        
                                        
                                    }
                                })
                            }
                            
                            
                        })
                    }
                }
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Departments
        //loadDepartments()
        
        
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
        if searchActive && !emptySearch {
            return filtered.count
        }
        return departments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DepartmentTableViewCell1"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DepartmentTableViewCell1  else {
            fatalError("The dequeued cell is not an instance of DepartmentTableViewCell1.")
        }
        
        
        // Fetches the appropriate meal for the data source layout.
        let de = departments[indexPath.row]
        
        cell.department.text = de.name
        
        
        return cell
    }
    
    //Needs to be modified for searching
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(departments[indexPath.row])
    }
    
    //modify for searching:
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowDetail":
            guard let teachers = segue.destination as? TeachersViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedDepartmentCell = sender as? DepartmentTableViewCell1 else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedDepartmentCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedDepartment = departments[indexPath.row]
            teachers.department = selectedDepartment
            segue.destination.navigationItem.title = selectedDepartment.name
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
}

