//
//  InitialViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 8/3/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
import Firebase

//Global variables - stores database info accessible from anywhere
var totalTeachers = [Teacher1]()
var departments: [Department] = []
var clubs = [Club]()
class InitialViewController: UIViewController {
    
    typealias DownloadComplete = () -> ()
    typealias DownloadComplete2 = () -> ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //This is the apps loading point. We should load all database stuff here rather than later
        //It is the initial view controller that follows the Launch Storyboard
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        loadDepartments() {
            print("DEPARTSS \(departments)")
            self.loadClubs {
                self.performSegue(withIdentifier: "Start", sender: self)
            }
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*loadDepartments() { (isWorking) in
            if isWorking {
                print("Firebase \(isWorking)")
                // do stuff
            } else {
                // not working
            }
        } */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadDepartments(completed: @escaping DownloadComplete) {
        
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
            var depts = 0
            
            
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
                                            facRef = storageRef.child("18-19/18-19/\(str).jpg")
                                        }else{
                                            str = fac
                                            facRef = storageRef.child("18-19/faculty/\(fac).jpg")
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
                                                completed()
                                                departments.sort(by: { (one : Department, two : Department) -> Bool in
                                                    return one.name.localizedCaseInsensitiveCompare(two.name) == ComparisonResult.orderedAscending
                                                })
                                                //self.tableView.reloadData()
                                                //let vc = self.parent as! FacultyViewController
                                                //vc.endFrame.reloadData()
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
                                                    completed()
                                                    departments.sort(by: { (one : Department, two : Department) -> Bool in
                                                        return one.name.localizedCaseInsensitiveCompare(two.name) == ComparisonResult.orderedAscending
                                                    })
                                                    totalTeachers.sort(by: { (one : Teacher1, two : Teacher1) -> Bool in
                                                        let str1 = "\(one.lName!), \(one.fName!)"
                                                        let str2 = "\(two.lName!), \(two.fName!)"
                                                        return str1.localizedCaseInsensitiveCompare(str2) == ComparisonResult.orderedAscending
                                                    })
                                                    //self.tableView.reloadData()
                                                    //let vc = self.parent as! FacultyViewController
                                                    //vc.endFrame.reloadData()
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
            //here
//            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "Start", sender: self)
//            }
            //completed()
            
            
        }
        //completion(true)
        
    }
    func loadClubs(completed: @escaping DownloadComplete) {
        // reference to database at the department branch
        let ref = Database.database().reference(withPath: "Groups/Clubs")
        
        var keys: [String] = []
        
        ref.observeSingleEvent(of: .value, with: {snapshot in
            print("looking")
            if let dict = snapshot.value as? NSDictionary{
                print("not fail")
                for entry in dict{
                    keys.append((entry.key as? String)!)
                }
            }
            for key in keys{
                let temp2ref = Database.database().reference(withPath: "Groups/Clubs/\(key)")
                print(key)
                temp2ref.observeSingleEvent(of: .value, with: {snapshot in
                    print("looking")
                    
                    if let dict = snapshot.value as? NSDictionary{
                        print("not today boyo")
                        let name = key
                        print(dict.allKeys)
                        let sponsor = dict.value(forKey: "Club Sponsor") as! String
                        let office = dict.value(forKey: "Sponsor Office Location") as! String
                        let location = dict.value(forKey: "Meeting Location") as! String
                        let days = dict.value(forKey: "Meeting Times") as! String
                        let desc = dict.value(forKey: "Description" ) as! String
                        let club = Club(n: name, s: sponsor, o: office, l: location, d: days, t: "???", de: desc, e: "???")
                        clubs.append(club)
                        if clubs.count == keys.count {
                            completed()
                            clubs.sort { (one : Club, two : Club) -> Bool in
                                return one.name?.localizedCaseInsensitiveCompare(two.name!) == ComparisonResult.orderedAscending
                            }
                        }
                        
                        
                    }
                })
            }
        })
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
