//
//  MapsViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 9/2/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
import DownPicker
class MapsViewController: UIViewController {
    
    
    @IBOutlet weak var pdf: UIWebView!
    @IBOutlet weak var mapsTextField: UITextField!
    var downPick : DownPicker!
    var path = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapsTextField.rightView = UIImageView(image: #imageLiteral(resourceName: "downArrow"))
        
        let maps = ["West Building", "East Building", "IC Building", "Fine Arts", "Full Campus"]
        self.downPick = DownPicker(textField: mapsTextField, withData: maps)
        downPick.shouldDisplayCancelButton = false
        downPick.addTarget(self, action: #selector(dpSelect), for: UIControl.Event.valueChanged)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([ NSAttributedString.Key.font.rawValue: UIFont(name: "HelveticaNeue-Light", size: 25)!])
        self.title = "Campus Map"
        
        path = Bundle.main.path(forResource: "West Building", ofType: "pdf")!
        let url = NSURL.fileURL(withPath: path)
        pdf.loadRequest(URLRequest(url: url))
    
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dpSelect() {
        path = Bundle.main.path(forResource: downPick.text, ofType: "pdf")!
        let url = NSURL.fileURL(withPath: path)
        pdf.loadRequest(URLRequest(url: url))
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
