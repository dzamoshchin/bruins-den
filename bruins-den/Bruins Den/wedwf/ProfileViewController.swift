//
//  ProfileViewController.swift
//  Teachers
//
//  Created by J Lee on 5/12/17.
//  Copyright © 2017 CCHS. All rights reserved.
//

import UIKit
import os.log

class ProfileViewController: UIViewController, UITextViewDelegate {
    
    var teacher: Teacher1?
    @IBOutlet weak var prof: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var office: UILabel!
    @IBOutlet weak var phone: UITextView!
    
    @IBOutlet weak var email: UIButton!
    @IBOutlet var schedule: [UILabel]!
    
    @IBOutlet weak var sem1Button: UIButton!
    
    @IBOutlet weak var sem2Button: UIButton!
    
    @IBOutlet weak var temp: UIView!
    var sem1 = [String]()
    var sem2 = [String]()
    var twoSems = false
    var select = 0
    
    @IBOutlet weak var dptIcon: UIImageView!
    @IBOutlet weak var semesters: UIStackView!
    var attrs : [String: Any] = [
        NSFontAttributeName : UIFont.systemFont(ofSize: 15, weight: 3),
        NSForegroundColorAttributeName : colorTint,
        NSUnderlineStyleAttributeName : 1]
    var attrs2 : [String: Any] = [
        NSFontAttributeName : UIFont.systemFont(ofSize: 15),
        NSForegroundColorAttributeName : colorTint,
        NSUnderlineStyleAttributeName : 0]
    
    override func viewDidLoad() {
        phone.delegate = self
        schedule.sort { (a : UILabel, b: UILabel) -> Bool in
            return a.tag < b.tag
        }
        //self.view.bringSubview(toFront: phone)
        self.title = "Teacher Profile"
        let attribute = NSMutableAttributedString(string: "Sem. 1",
                                                  attributes: attrs)
        
        sem1Button.setAttributedTitle(attribute, for: .normal)
        
        //USE THIS: http://swiftdeveloperblog.com/uitextview-and-uitextviewdelegate-example-in-swift/
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //self.navigationController?.navigationBar.alpha = 0
        prof.image = (teacher?.photo)!
        name.text = "\(teacher!.lName!), \(teacher!.fName!)"
        office.text = teacher?.office
        var str = "72055" + (teacher?.phone)!
        var test = ""
        for i in 0..<str.characters.count {
            let index = str.index(str.startIndex, offsetBy: i)
            if i == 3 || i==6 {
                test += "-"
            }
            test += String(str[index])
        }
        phone.text = test
        var em = teacher?.email
        if (em?.hasPrefix("*"))! {
            let inn = em?.index((em?.startIndex)!, offsetBy: 1)
            em = em?.substring(from: inn!)
            dptIcon.isHidden = false
            
            
        }
        email.setTitle((em)!, for: .normal)
        //email.text = (teacher?.email)!
        let line = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 1))
        line.backgroundColor = UIColor.black
        temp.addSubview(line)
        
        
        //addLine(fromPoint: email.frame.origin, toPoint: pt2)
        let arr = teacher?.schedule?.components(separatedBy: "|")
        print(arr)
        parseTeachers(arr!)
        /*
        for i in 0..<schedule.count {
            if arr?[i+1] == " " {
                schedule[i].text = "Off"
            } else {
                schedule[i].text = arr?[i+1]
            }
        } */
        if !twoSems { //sem1 == sem2
            print("NO CHANGES")
            for i in 0..<sem1.count {
                let g = sem1[i]
                if g == " " {
                    schedule[i].text = "Off"
                }else {
                    schedule[i].text = sem1[i]
                }
            }
            semesters.isHidden = true
        } else {
            print("different semesters")
            for i in 0..<sem1.count {
                let g = sem1[i]
                if g == " " {
                    schedule[i].text = "Off"
                }else {
                    schedule[i].text = sem1[i]
                }
            }
        }
        print("schedules")
        for i in 0..<schedule.count {
            print(schedule[i].text)
        }
        
        
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        prof.layer.borderWidth = 1
        prof.layer.masksToBounds = false
        prof.layer.borderColor = UIColor.white.cgColor
        prof.layer.cornerRadius = prof.frame.height/2
        prof.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(_ sender: UIButton) {
        print("lim sup")
        self.navigationController?.popViewController(animated: true)
    }
    
   
    func addLine(fromPoint start: CGPoint, toPoint end:CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.strokeColor = UIColor.red.cgColor
        line.lineWidth = 1
        line.lineJoin = kCALineJoinRound
        self.view.layer.addSublayer(line)
    }
    func parseTeachers(_ arr : [String]) {
        var location = ""
        var classOne = ""
        var classTwo = ""
        for i in 0..<arr.count {
            if i == 0{
                continue
            }
            if let range = arr[i].range(of: " - ") {
                location = arr[i].substring(from: range.upperBound)
                let temp = arr[i].substring(to: range.lowerBound)
                if let range2 = temp.range(of: " / ") {
                    classOne = arr[i].substring(to: range2.lowerBound)
                    classTwo = arr[i].substring(from: range2.upperBound)
                    sem1 += ["\(classOne) - \(location)"]
                    sem2 += [classTwo]
                } else {
                    sem1 += [arr[i]]
                    sem2 += [arr[i]]
                }
                
            } else {
                sem1 += [" "]
                sem2 += [" "]
            }
        }
        print(arr)
        print("sem1 \(sem1)")
        print("sem2 \(sem2)")
        if sem1 == sem2 {
            twoSems = false
        } else {
            twoSems = true
        }
        
    }
    
    
    @IBAction func click(_ sender: UIButton) {
        print("click")
        if sender.tag == select {
            //do nothing
        } else {
            select = sender.tag
            if sender.tag == 0 {
                let attribute = NSMutableAttributedString(string: "Sem. 1",
                                                          attributes: attrs)
                let attribute2 = NSMutableAttributedString(string: "Sem. 2", attributes: attrs2)
                sem1Button.setAttributedTitle(attribute, for: .normal)
                sem2Button.setAttributedTitle(attribute2, for: .normal)
                for i in 0..<sem1.count {
                    let g = sem1[i]
                    if g == " " {
                        schedule[i].text = "Off"
                    }else {
                        schedule[i].text = sem1[i]
                    }
                }
                
            } else {
                let attribute = NSMutableAttributedString(string: "Sem. 2",
                                                          attributes: attrs)
                let attribute2 = NSMutableAttributedString(string: "Sem. 1", attributes: attrs2)
                sem1Button.setAttributedTitle(attribute2, for: .normal)
                sem2Button.setAttributedTitle(attribute, for: .normal)
                for i in 0..<sem2.count {
                    let g = sem2[i]
                    if g == " " {
                        schedule[i].text = "Off"
                    }else {
                        schedule[i].text = sem2[i]
                    }
                }
                
            }
        }
        
    }
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        
        
        if (URL.scheme == "tel"){
            var phoneNumber = URL.absoluteString.replacingOccurrences(of: "tel:", with: "")
            phoneNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
            let alert = UIAlertController(title: phoneNumber, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (alert) in
                if UIApplication.shared.canOpenURL(URL) {
                    UIApplication.shared.openURL(URL)
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
                print("User Canceld")
            }))
            present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }

    @IBAction func clickEmail(_ sender: UIButton) {
        if let email = sender.titleLabel?.text {
            if let url = URL(string: "mailto:\(email)") {
                UIApplication.shared.open(url)
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
