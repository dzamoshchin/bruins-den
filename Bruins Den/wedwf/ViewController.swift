//
//  ViewController.swift
//  wedwf
//
//  Created by hari sowrirajan on 5/3/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
var page = 0 //actually a useless variable, delete everywhere when u can
var facultyLoaded = 0
//Handles the Main Menu of the app
class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView! //FOR TOP SCROLLING PICS
    
    var timer : Timer!
    var updateCounter : Int!
    
    var sideBarButton: UIBarButtonItem!

    
    @IBOutlet weak var scrollScreens: UIView! //NOT THE SCROLLING PICTURES ON TOP
    var frame: CGRect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 0, height: 0))
    
    //Pictures scrolling on top
    var pictures = [#imageLiteral(resourceName: "Image1"), #imageLiteral(resourceName: "Photo1"), #imageLiteral(resourceName: "Image3")]
    
    var imageViews:[UIImageView] = []
    var height = CGFloat(0)
    
    @IBOutlet weak var campus: UIButton!

    
    @IBAction func callUsButton(_ sender: Any) {
        //Creating alert view for various call options
        let alert = UIAlertController(title: "Contact Cherry Creek HS", message: nil, preferredStyle: UIAlertController.Style.alert)
        let mainAction = UIAlertAction(title: "Main Office", style: UIAlertAction.Style.default) { (action) in
            if let url = NSURL(string: "tel://7205542285"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
        
        let attendanceAction = UIAlertAction(title: "Attendance", style: UIAlertAction.Style.default) { (action) in
            if let url = NSURL(string: "tel://7205542242"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
        //ADD SAFE2TELL
        let careAction = UIAlertAction(title: "Safe2Tell", style: UIAlertAction.Style.default) { (action) in
            if let url = NSURL(string: "tel://18775427233"), UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(mainAction)
        alert.addAction(attendanceAction)
        alert.addAction(careAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewWillLayoutSubviews()
        navigationController?.view.backgroundColor = UIColor.clear
        print("Departments \(departments.count)")
        let verticalOffset = 0
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
            
        navigationController?.navigationBar.setTitleVerticalPositionAdjustment(CGFloat(verticalOffset), for: UIBarMetrics.default)
        
        
        scrollScreens.backgroundColor = UIColor.clear
        scrollScreens.tintColor = UIColor.clear
        
        //MAKE NAVIGATION BAR TRANSPARENT
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        

        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.mainViewController = self.navigationController
        
        updateCounter = 0
        //set how often the top images scroll
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        for index in 0..<pictures.count {
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(index)
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true
            let subview = UIImageView(frame: frame)
            subview.image = pictures[index]
            subview.contentMode = .scaleAspectFill
            subview.clipsToBounds = true
            imageViews.append(subview)
            
            self.scrollView.addSubview(subview)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for (index,imageView) in imageViews.enumerated() {
            imageView.frame = CGRect(x: CGFloat(index)*scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height:scrollView.frame.size.height)
        }
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width*3, height: scrollView.frame.size.height)
        
       self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    @objc internal func updateTimer() {
        if updateCounter <= 1 {
            let rightOffset = CGPoint(x: scrollView.contentOffset.x + scrollView.frame.size.width, y: 0)
            scrollView.setContentOffset(rightOffset, animated: true)

            updateCounter = updateCounter + 1
            
        } else {
            updateCounter = 0
            scrollView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
  
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
