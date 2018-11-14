//
//  ClubProfileViewController.swift
//  Clubs
//
//  Created by J Lee on 7/27/17.
//  Copyright © 2017 J Lee. All rights reserved.
//

import UIKit

class ClubProfileViewController: UIViewController {
    var club: Club?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var sponsor: UILabel!
    @IBOutlet weak var office: UILabel!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!

    @IBOutlet weak var clubInfo: UIStackView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var des: UITextView!

    @IBOutlet weak var desc: UIView!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        name.text = club?.name
        self.title = "Club Profile"
        var bold = "Sponsors: "
        var attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17)]
        var attributedString = NSMutableAttributedString(string:bold, attributes:attrs)
        attributedString.append(NSMutableAttributedString(string: club!.sponsor!))
        sponsor.attributedText = attributedString
        
        bold = "Sponsor Office: "
        attributedString = NSMutableAttributedString(string:bold, attributes:attrs)
        attributedString.append(NSMutableAttributedString(string: club!.office!))
        office.attributedText = attributedString
        
        bold = "Sponsor Email: "
        attributedString = NSMutableAttributedString(string:bold, attributes:attrs)
        attributedString.append(NSMutableAttributedString(string: club!.email!))
        email.attributedText = attributedString
        
        
        //Switch it up!
        attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        let attr = [NSFontAttributeName : UIFont.systemFont(ofSize: 15)]
        
        bold = "Location: "
        attributedString = NSMutableAttributedString(string:bold, attributes:attrs)
        attributedString.append(NSMutableAttributedString(string: club!.location!, attributes: attr))
        location.attributedText = attributedString
        
        bold = "When: "
        attributedString = NSMutableAttributedString(string:bold, attributes:attrs)
        attributedString.append(NSMutableAttributedString(string: club!.days!, attributes: attr))
        days.attributedText = attributedString
        
        bold = "Time: "
        attributedString = NSMutableAttributedString(string:bold, attributes:attrs)
        attributedString.append(NSMutableAttributedString(string: club!.times!, attributes: attr))
        time.attributedText = attributedString
        
        attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 17)]
        bold = "About Us\n"
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        
        attributedString = NSMutableAttributedString(string:bold, attributes:attrs)
        attributedString.append(NSMutableAttributedString(string: club!.desc!, attributes: attr))
        
        des.attributedText = attributedString
        
        des.textAlignment = .center
        
        
        super.viewDidLoad()
        let line = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 1))
        line.backgroundColor = UIColor.black
        
        let line2 = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 1))
        line2.backgroundColor = UIColor.black
        
        desc.addSubview(line)
        
        clubInfo.addSubview(line2)
        // Do any additional setup after loading the view.
        
        if let pic = UIImage(named: "\(name.text ?? "Sample")") {
            image.image = pic
        } else {
            image.image = UIImage(named: "Sample")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
