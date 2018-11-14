//
//  TeacherTableViewCell.swift
//  Teachers
//
//  Created by Student on 5/8/17.
//  Copyright © 2017 CCHS. All rights reserved.
//

import UIKit

class TeacherTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    var teachers = [Teacher1]()
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        pic.layer.borderWidth = 1
        pic.layer.masksToBounds = false
        pic.layer.borderColor = UIColor.black.cgColor
        pic.layer.cornerRadius = pic.frame.height/2
        pic.clipsToBounds = true

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
