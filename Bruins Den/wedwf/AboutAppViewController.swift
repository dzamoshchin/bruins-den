//
//  AboutAppViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 10/7/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var revealButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([ NSAttributedString.Key.font.rawValue: UIFont(name: "HelveticaNeue-Light", size: 25)!])
        self.title = "About the App"
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        line.backgroundColor = UIColor.black
        tableView.addSubview(line)
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "name"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NamesTableViewCell else {
            fatalError("The dequeued cell is not an instance of NamesTableViewCell.")
            
        }
        if indexPath.row == 0 {
            let image = #imageLiteral(resourceName: "hari")
            cell.img.image = image
            cell.name.text = "Hari Sowrirajan"
            cell.job.text = "iOS Development Lead"
        
        } else if indexPath.row == 1 {
            cell.img.image = #imageLiteral(resourceName: "Cyprien")
            cell.name.text = "Cyprien Toffa"
            cell.job.text = "Head UI/UX Designer"
            
        } else if indexPath.row == 2 {
            cell.img.image = #imageLiteral(resourceName: "Chris")
            cell.name.text = "Chris Lee"
            cell.job.text = "iOS Development & Database"
        } else {
            cell.img.image = #imageLiteral(resourceName: "Matt")
            cell.name.text = "Matt Clough"
            cell.job.text = "Database"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
