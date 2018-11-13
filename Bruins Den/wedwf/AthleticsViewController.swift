//
//  AthleticsViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/8/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
import TwitterKit

class AthleticsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    //Twitter tutorial: https://www.youtube.com/watch?v=ODTNtwnk6_E
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!]
        tableView.delegate = self
        self.navigationController?.navigationBar.tintColor = UIColor.black
        tableView.dataSource = self
        self.title = "Athletics"

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController {
            let reveal = self.revealViewController()
            reveal?.panGestureRecognizer().isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "AthleticsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AthleticsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of AthleticsTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        if indexPath.row == 0 {
            cell.name.text = "Men's Sports"
        } else {
            cell.name.text = "Women's Sports"
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 2.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toSeasons", sender: indexPath.row)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toSeasons" {
            if let vc = segue.destination as? SeasonsViewController {
                vc.gender = sender as! Int
            }
        }
    }
    

}
