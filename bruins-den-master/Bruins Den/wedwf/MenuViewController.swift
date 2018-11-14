//
//  MenuViewController.swift
//  wedwf
//
//  Created by hari sowrirajan on 5/3/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

//the actual scroll screens on the bottom
class MenuViewController: UIPageViewController {
    //Do i need this? :
    let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    
    var menuDelegate: MenuViewControllerDelegate?
    
    
    //the views the user scrolls between
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(1),
                self.newViewController(2)]
    }()
    
    private func newViewController(_ page: Int) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Screen\(page)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        menuDelegate?.menuViewController(menuViewController: self, didUpdatePageCount: orderedViewControllers.count)
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        view.autoresizesSubviews = false
        
        if let view1 = orderedViewControllers[0] as? Screen1ViewController {
            view1.view.frame = view.frame
            //let stack = view1.stack1
            //stack?.translatesAutoresizingMaskIntoConstraints = false
            //let margins = view.layoutMarginsGuide
           // stack?.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            //let fr = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height)
            //stack?.frame.size.height = 300
            
            
        }
        
        

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
// MARK: UIPageViewControllerDataSource

extension MenuViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        page = 0
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        page = 1
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
  

    
}
extension MenuViewController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            menuDelegate?.menuViewController(menuViewController: self,didUpdatePageIndex: index)
        }
        
    }
}

protocol MenuViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter menuViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func menuViewController(menuViewController: MenuViewController, didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func menuViewController(menuViewController: MenuViewController, didUpdatePageIndex index: Int)
    
}







