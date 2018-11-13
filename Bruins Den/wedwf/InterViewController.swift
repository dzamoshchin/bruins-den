//
//  InterViewController.swift
//  wedwf
//
//  Created by hari sowrirajan on 5/5/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

//class that handles the page control of bottom slide screens
class InterViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let menuViewController = segue.destination as? MenuViewController {
            menuViewController.menuDelegate = self
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

extension InterViewController: MenuViewControllerDelegate {
    
    func menuViewController(menuViewController: MenuViewController,didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func menuViewController(menuViewController: MenuViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
}


