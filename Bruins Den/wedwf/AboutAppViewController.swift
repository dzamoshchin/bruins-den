//
//  AboutAppViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 10/7/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class AboutAppViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let names: [[String]] = [["Daniel Zamoshchin", "Siddarth Ijju"], ["Hari Sowrirajan", "Cyprien Toffa", "Chris Lee", "Matt Clough"]]
    
    let titles: [[String]] = [["iOS", "iOS"], ["iOS Development Lead", "Head UI/UX Designer", "iOS Development & Database", "Database"]]
    
    let images: [[UIImage]] = [[#imageLiteral(resourceName: "Sample"), #imageLiteral(resourceName: "Sample")], [#imageLiteral(resourceName: "hari"), #imageLiteral(resourceName: "Cyprien"), #imageLiteral(resourceName: "Chris"), #imageLiteral(resourceName: "Matt")]]

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([ NSAttributedString.Key.font.rawValue: UIFont(name: "HelveticaNeue-Light", size: 25)!])
        self.title = "About the App"
        
        tableView.delegate = self
        tableView.dataSource = self
        print(UIScreen.main.bounds.width)
        height.constant += contentView.frame.height - UIScreen.main.bounds.width

        contentView.layoutIfNeeded()
        contentView.updateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 4
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "name"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NamesTableViewCell else {
            fatalError("The dequeued cell is not an instance of NamesTableViewCell.")
        }

        cell.img.image = images[indexPath.section][indexPath.row]
        cell.name.text = names[indexPath.section][indexPath.row]
        cell.job.text = titles[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Bruins Den Team 2.0"
        } else {
            return "Bruins Den Team 1.0"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
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
