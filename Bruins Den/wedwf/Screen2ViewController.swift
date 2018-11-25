//
//  Screen2ViewController.swift
//  wedwf
//
//  Created by Student on 5/4/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class Screen2ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let identifier = "CellIdentifier2"
    
    var cells = [MenuButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "TopNavBarBackground2"), for: .default)
        cells += [MenuButton("PowerSchool", #imageLiteral(resourceName: "powerschool")), MenuButton("Union Street Journal", #imageLiteral(resourceName: "unionstreet")), MenuButton("Senate Voting", #imageLiteral(resourceName: "senate")), MenuButton("Master Calendar",#imageLiteral(resourceName: "Calendar-1")), MenuButton("Documents", #imageLiteral(resourceName: "Documents")), MenuButton("Settings", #imageLiteral(resourceName: "Settings"))]
        
        collectionView.dataSource = self
        collectionView.delegate = self
        

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
extension Screen2ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Menu2CollectionViewCell
        cell.name.text = cells[indexPath.item].name
        let targetSize = CGSize(width: cell.picture.frame.size.width * 0.75, height: cell.picture.frame.size.height * 0.75)
        
        cell.picture.frame.size = targetSize
        cell.picture.clipsToBounds = true
        cell.picture.contentMode = UIView.ContentMode.scaleAspectFit
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
    
    //USER INTERACTION - clicking on a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //CLICKING ON COLLECTIONVIEWCELL
        if(indexPath.row == 0) {
            performSegue(withIdentifier: "toPower", sender: self)
        } else if indexPath.row == 1 {
            performSegue(withIdentifier: "toUSJ", sender: self)
        } else if indexPath.row == 2 {
            performSegue(withIdentifier: "toSenate", sender: self)
        } else if indexPath.row == 3 {
            
        } else if indexPath.row == 4 {
            performSegue(withIdentifier: "toDocs", sender: self)
        } else if indexPath.row == 5 {
            
        }
    }
}
