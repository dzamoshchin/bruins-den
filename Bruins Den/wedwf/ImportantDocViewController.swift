//
//  ImportantDocViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/22/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class ImportantDocViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var revealButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let reveal = self.revealViewController()
        reveal?.panGestureRecognizer().isEnabled = false
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!]
        revealButton.target = self
        revealButton.action = #selector(ImportantDocViewController.revealToggle)
        self.title = "Important Documents"
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func revealToggle() {
        let reveal = self.revealViewController()
        reveal?.panGestureRecognizer().isEnabled = true
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        revealViewController().setFront(appDelegate?.mainViewController, animated: true)
        revealViewController().revealToggle(self) // Optional
        
    }
    
    //Table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DocTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DocTableViewCell else {
            fatalError("The dequeued cell is not an instance of DocTableViewCell.")
        }
        if indexPath.row == 0 {
            cell.name.text = "Master Schedule"
        } else if indexPath.row == 1 {
            cell.name.text = "Bear Facts"
        } else {
            cell.name.text = "Registration Guide"
        }
            
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            performSegue(withIdentifier: "toDocs", sender: "MasterSchedule")
        } else if indexPath.row == 1 {
            performSegue(withIdentifier: "toDocs", sender: "BearFacts")
        } else {
            performSegue(withIdentifier: "toDocs", sender: "RegistrationGuide")
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? DocumentsViewController {
            vc.docName = sender as! String
        }
    }
    

}
