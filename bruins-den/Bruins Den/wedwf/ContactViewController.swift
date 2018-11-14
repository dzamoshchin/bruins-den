//
//  ContactViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/28/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit
import DownPicker
import skpsmtpmessage

class ContactViewController: UIViewController {
    //implement SKPSMTPMessageDelegate
    
    //@IBOutlet weak var subjectTextField: UITextField!
    var downPick : DownPicker!
    @IBOutlet weak var revealButton: UIBarButtonItem!
    
    //@IBOutlet weak var message: UITextField!
    
   // @IBOutlet weak var email: UITextField!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let reveal = self.revealViewController()
        reveal?.panGestureRecognizer().isEnabled = false
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!]
        self.title = "Suggestion Box"
        webView.loadRequest(NSURLRequest(url: NSURL(string: "https://sites.google.com/view/cchsapp/home")! as URL) as URLRequest)
        revealButton.target = self
        revealButton.action = #selector(ContactViewController.revealToggle)
        /*
        subjectTextField.rightView = UIImageView(image: #imageLiteral(resourceName: "downArrow"))
        let persons = ["Cherry Creek HS", "CCHS Bruins Den App"]
        self.downPick = DownPicker(textField: self.subjectTextField, withData:persons)
        downPick.shouldDisplayCancelButton = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
         */
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
    
    /*
    
    @IBAction func submit(_ sender: UIButton) {
        if subjectTextField.text! == "" {
            let alert = UIAlertController(title: "Please select a subject", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            return
        }
        var dest = ""
        if subjectTextField.text == "Cherry Creek HS" {
            dest = "4everabronco@gmail.com"
        } else {
            dest = "cchsappteam@gmail.com"
        }
        var messageE = SKPSMTPMessage()
        messageE.fromEmail = "cchsappteam@gmail.com"
        messageE.toEmail = dest
        messageE.relayHost = "smtp.gmail.com"
        messageE.requiresAuth = true
        messageE.pass = "BruinsDen2.0" 
        messageE.login = "cchsappteam@gmail.com"
        messageE.subject = "Suggestion"
        messageE.wantsSecure = true
        messageE.delegate = self
        let messageBody = "A user had a suggestion: \n \(self.message.text!) \n email: \(self.email.text!)"
        
        
        var parts: NSDictionary = [
            "kSKPSMTPPartContentTypeKey": "text/plain; charset=UTF-8",
            "kSKPSMTPPartMessageKey": messageBody,
            ]

        /*let keys = [kSKPSMTPPartContentTypeKey, kSKPSMTPPartMessageKey, kSKPSMTPPartContentTransferEncodingKey]
        let objects = ["text/plain", messageBody, "8bit"]
        var dict = NSDictionary(object: objects, forKey: keys as NSCopying)
        var dict:[String:String] = [:]
        keys.enumerated().forEach { (i) -> () in
            dict[i.element] = objects[i.offset]
        } */
        messageE.parts = [parts]
        print(messageE)
        messageE.send()
        
        
        
        
    }
    func messageSent(_ message: SKPSMTPMessage!) {
        print("message sent")
    }
    func messageFailed(_ message: SKPSMTPMessage!, error: Error!) {
        print("message failed")
    }
    
    

   
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
  */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
