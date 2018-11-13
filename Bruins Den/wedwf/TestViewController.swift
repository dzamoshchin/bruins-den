//
//  TestViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/17/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorageUI
import SDWebImage


class TestViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var placeholder: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let test = storageRef.child("images/mgoodman5.jpg")
        let imageView: UIImageView = self.image
        let placehold = UIImage(named: "placeholder.jpg")
        
        
        imageView.sd_setImage(with: test, placeholderImage: placehold)
        //roundabout way to get the image since placehold is nothing more than that - a placeholder
        let testImage = imageView.image
        placeholder.image = testImage
        
        
        // Do any additional setup after loading the view.
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
