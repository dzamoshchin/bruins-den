//
//  BellScreenContainerViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/24/17.
//  Updated by Daniel Zamoshchina and Siddarth Ijju on 12/26/18.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class BellScreenContainerViewController: UIViewController {

    var sc = -1;
    @IBOutlet weak var period: UIStackView!
    @IBOutlet weak var times: UIStackView!
    
    @IBOutlet weak var stackview: UIStackView!
    //@IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        self.parent
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([ NSAttributedString.Key.font.rawValue: UIFont(name: "HelveticaNeue-Light", size: 25)!])
        addPeriods()
        var scheduleTimes = [String]()
        print("SC")
        print(sc)
        switch(sc){
            case 0:
                self.title = "Regular Schedule"
                scheduleTimes = ["8:20 - 9:12", "9:19 - 10:06", "10:13 - 11:00", "11:07 - 11:54", "12:01 - 12:48", "12:55 - 1:42", "1:49 - 2:36", "2:43 - 3:30"]
            case 1:
                self.title = "Storm Delay Schedule"
                scheduleTimes = ["9:50 - 10:29", "10:36 - 11:12", "11:19 - 11:55", "12:02 - 12:38", "12:45 - 1:21", "1:28 - 2:04", "2:11 - 2:47", "2:54 - 3:30"]
            case 2:
                self.title = "Assembly Schedule"
                scheduleTimes = ["8:20 - 9:01", "9:08 - 9:49", "9:56 - 10:41", "10:48 - 11:29", "11:36 - 12:17", "12:24 - 1:05", "1:12 - 1:53" , "2:00 - 2:41", "2:48 - 3:30"]
            default:
                self.title = "Finals Schedule"
                scheduleTimes = ["8:20 - 9:12", "9:19 - 10:06", "10:13 - 11:00", "11:07 - 11:54", "12:01 - 12:48", "12:55 - 1:42", "1:49 - 2:36", "2:43 - 3:30"]
        }
        addTimes(scheduleTimes)
    }
    
    func addPeriods(){
        let label = UILabel()
        label.text = "Period"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        period.addArrangedSubview(label)
        for index in 1...2{
            period.addArrangedSubview(makeLabel(String(index)))
        }
        if sc == 2{
            period.addArrangedSubview(makeLabel("Assembly"))
        }
        for index in 3...8{
            period.addArrangedSubview(makeLabel(String(index)))
        }
    }
    
    func addTimes(_ timesIn: [String]){
        let label = UILabel()
        label.text = "Times"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        times.addArrangedSubview(label)
        for index in 0...7{
            times.addArrangedSubview(makeLabel(timesIn[index]))
        }
        if sc == 2{
            times.addArrangedSubview(makeLabel(timesIn[8]))
        }
  
    }
    
    func makeLabel(_ text: String) -> UILabel{
        let label = UILabel()
        label.text  = text
        label.textAlignment = .center
        return label
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
