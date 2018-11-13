//
//  Screen1ViewController.swift
//  wedwf
//
//  Created by Student on 5/4/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

//First screen the user scrolls on the bottom
class Screen1ViewController: UIViewController {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    let identifier = "CellIdentifier"

    var cells = [MenuButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "TopNavBarBackground2"), for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!]
        
        cells += [MenuButton("Announcements", #imageLiteral(resourceName: "announcements")), MenuButton("MyCherryCreek", #imageLiteral(resourceName: "mycherry")), MenuButton("Faculty/Staff", #imageLiteral(resourceName: "faculty")), MenuButton("Bell Schedule", #imageLiteral(resourceName: "bell")), MenuButton("Athletics", #imageLiteral(resourceName: "athletic")), MenuButton("Clubs", #imageLiteral(resourceName: "clubs"))]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        
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
    // MARK:- UICollectionViewDataSource Delegate
    

}


extension Screen1ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MenuCollectionViewCell
        cell.name.text = cells[indexPath.item].name
        let targetSize = CGSize(width: cell.picture.frame.size.width * 0.75, height: cell.picture.frame.size.height * 0.75)

        print(cell.picture.frame.size)
        cell.picture.frame.size = targetSize
        print(cell.picture.frame.size)
        cell.picture.clipsToBounds = true
        cell.picture.contentMode = UIViewContentMode.scaleAspectFit
        cell.picture.image = cells[indexPath.item].icon
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = self.view.frame.width
        let h = self.view.frame.height
        
        return CGSize(width: w/2.1, height: h/3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let diff = self.view.frame.width/2 - self.view.frame.width/2.1
        return UIEdgeInsets(top: 0, left: diff/2, bottom: 0, right: diff/2)
    }
    //USER INTERACTION
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        //CLICKING ON COLLECTIONVIEWCELL
        if(indexPath.row == 1){
            let reveal = self.revealViewController()
            reveal?.panGestureRecognizer().isEnabled = false
            performSegue(withIdentifier: "toMy", sender: self)
        } else if (indexPath.row == 3){
            let reveal = self.revealViewController()
            reveal?.panGestureRecognizer().isEnabled = false
            performSegue(withIdentifier: "toSchedule", sender: self)
        } else if indexPath.row == 2 {
            let reveal = self.revealViewController()
            reveal?.panGestureRecognizer().isEnabled = false
            performSegue(withIdentifier: "toFaculty", sender: self)
        } else if indexPath.row == 4 {
            let reveal = self.revealViewController()
            reveal?.panGestureRecognizer().isEnabled = false
            performSegue(withIdentifier: "toAthletics", sender: self)
        } else if indexPath.row == 0 {
            let reveal = self.revealViewController()
            reveal?.panGestureRecognizer().isEnabled = false
            performSegue(withIdentifier: "toAnnouncements", sender: self)
        } else if indexPath.row == 5 {
            let reveal = self.revealViewController()
            reveal?.panGestureRecognizer().isEnabled = false
            performSegue(withIdentifier: "toClubs", sender: self)
        }
        /*
         switch (itemNo) {
         case 1:
         {
         //perform segue to another UICollectionViewController.
         }
         case 2:
         {
         //perform segue to another UICollectionViewController.
         }
         .
         .
         .
         }
 
        */
    }
    

    
    
    
}
