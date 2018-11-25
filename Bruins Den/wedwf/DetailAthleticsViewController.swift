//
//  DetailAthleticsViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/26/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class DetailAthleticsViewController: UIViewController {

    @IBOutlet weak var games: UIButton!
    
    @IBOutlet weak var contact: UIButton!
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var webView: UIWebView!
    
    
    @IBOutlet weak var webView2: UIWebView!
    
    var select = 0
    
    var sport = Sport()
    var gender = -1
    var attrs : [String: Any] = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font) : UIFont(name: "HelveticaNeue-Bold", size: 21),
        convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor) : UIColor.white,
        convertFromNSAttributedStringKey(NSAttributedString.Key.underlineStyle) : 1]
    var attrs2 : [String: Any] = [
        convertFromNSAttributedStringKey(NSAttributedString.Key.font) : UIFont(name: "Helvetica Neue", size: 21),
        convertFromNSAttributedStringKey(NSAttributedString.Key.foregroundColor) : UIColor.white,
        convertFromNSAttributedStringKey(NSAttributedString.Key.underlineStyle) : 0]
    
    //Mile Split
    //
    let crossCountryA = "http://co.milesplit.com/teams/12209-cherry-creek-high-school/schedule#.WXoHB9Pyvow"
    let crossCountryB = "http://cherrycreek.ccsdathletics.org/page/show/2656289-coaches?subseason=312467"
    let footballA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/football/schedule.htm"
    let footballB = "http://cherrycreek.ccsdathletics.org/page/show/2656337-coaches?subseason=312472"
    let golfA = "http://cherrycreek.ccsdathletics.org/boysgolf"
    let golfB = "http://cherrycreek.ccsdathletics.org/page/show/2656358-coaches"
    
    let boysSoccerA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/soccer/schedule.htm"
    let boysSoccerB =  "http://cherrycreek.ccsdathletics.org/page/show/2656541-coaches"
    
    let boysTennisA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/tennis-fall/schedule.htm"
    let boysTennisB = "http://cherrycreek.ccsdathletics.org/page/show/2656630-coaches"
    
    let boysBballA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/basketball/schedule.htm"
    let boysBballB = "http://cherrycreek.ccsdathletics.org/page/show/2656201-coaches"
    
    let iceHockeyA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/ice-hockey/schedule.htm"
    let iceHockeyB = "http://cherrycreek.ccsdathletics.org/page/show/2656383-coaches?subseason=312478"
    
    let wrestlingA = "http://cherrycreek.ccsdathletics.org/page/show/3414648-wrestling-2017-2018-"
    let wrestlingB = "http://cherrycreek.ccsdathletics.org/page/show/2656780-coaches?subseason=312525"
    
    let baseBallA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/baseball/schedule.htm"
    let baseBallB = "http://cherrycreek.ccsdathletics.org/page/show/2656139-coaches?subseason=312455"
    
    let boysLacrosseA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/lacrosse/schedule.htm"
    let boysLacrosseB = "http://cherrycreek.ccsdathletics.org/page/show/2656397-coaches?subseason=312480"
    
    let boysSwimmingA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/swimming/schedule.htm"
    let boysSwimmingB = "http://cherrycreek.ccsdathletics.org/page/show/2656598-coaches?subseason=312498"
    
    let trackA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/track-field/schedule.htm"
    let trackB = "http://cherrycreek.ccsdathletics.org/page/show/2656709-coaches"
    
    //Womens
    let cheerA = "http://cherrycreek.ccsdathletics.org/page/show/3414592-varsity-cheer-2017-2018-"
    let cheerB = "http://cherrycreek.ccsdathletics.org/page/show/2657145-coaches-contact-information"
    
    let fieldHockeyA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/field-hockey/schedule.htm"
    let fieldHockeyB = "http://cherrycreek.ccsdathletics.org/page/show/2656302-coaches?subseason=312469"
    
    let gymnasticsA = "http://cherrycreek.ccsdathletics.org/page/show/3414601-gymnastics-2017-2018-"
    let gymnasticsB = "http://cherrycreek.ccsdathletics.org/page/show/2656374-coaches?subseason=312477"
    
    let softBallA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/softball-fall/schedule.htm"
    let softBallB = "http://cherrycreek.ccsdathletics.org/page/show/2656588-coaches?subseason=312496"
    
    let volleyBallA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/volleyball/schedule.htm"
    let volleyBallB = "http://cherrycreek.ccsdathletics.org/page/show/2656742-coaches?subseason=312519"
    
    let pomsA = "http://cherrycreek.ccsdathletics.org/page/show/2655483-poms"
    let pomsB = "http://cherrycreek.ccsdathletics.org/page/show/2656431-coaches?subseason=312487"
    
    let girlsBballA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/girls-basketball/schedule.htm"
    let girlsBballB = "http://cherrycreek.ccsdathletics.org/page/show/2656211-coaches?subseason=312461"
    
    let girlsSwimmingA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/girls-swimming/schedule.htm"
    let girlsSwimmingB = "http://cherrycreek.ccsdathletics.org/page/show/2656609-coaches?subseason=312500"
    
    let girlsLacrosseA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/girls-lacrosse/schedule.htm"
    let girlsLacrosseB = "http://cherrycreek.ccsdathletics.org/page/show/2656418-coaches?subseason=312484"
    
    let girlsSoccerA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/girls-soccer-spring/schedule.htm"
    let girlsSoccerB = "http://cherrycreek.ccsdathletics.org/page/show/2656577-coaches?subseason=312494"
    
    let girlsTennisA = "http://www.maxpreps.com/high-schools/cherry-creek-bruins-(greenwood-village,co)/girls-tennis-spring/schedule.htm"
    let girlsTennisB = "http://cherrycreek.ccsdathletics.org/page/show/2656666-coaches"
    
    let girlsGolfA = "http://cherrycreek.ccsdathletics.org/page/show/3414663-girls-golf-2017-2018-"
    let girlsGolfB = "http://cherrycreek.ccsdathletics.org/page/show/2656366-contact-coaches?subseason=312475"
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = sport.name
        let attribute = NSMutableAttributedString(string: "Game Schedule",
                                                  attributes: convertToOptionalNSAttributedStringKeyDictionary(attrs))
        games.setAttributedTitle(attribute, for: .normal)
        var website = ("", "")
        if gender == 0 {
            website = loadMale(sport.name)
        } else {
            website = loadFemale(sport.name)
        }
        
        webView.loadRequest(NSURLRequest(url: NSURL(string: website.0)! as URL) as URLRequest)
        //webView2.loadRequest(NSURLRequest(url: NSURL(string: website.1)! as URL) as URLRequest)
        webView2.loadRequest(NSURLRequest(url: NSURL(string: "http://cherrycreek.ccsdathletics.org/page/show/2657145-coaches-contact-information")! as URL) as URLRequest)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkSport() {
        
    }
    func loadFemale(_ name : String) -> (String,String) {
        var r = name + "W"
        image.image = UIImage(named: r)
        //print(name)
        if name == "Swim/Dive" { //WHAT is the problem???
            print("laj")
            image.image = #imageLiteral(resourceName: "SwimDiveW")
        }
        //image.image = UIImage(named: r)
        if name == "Cheer" {
            return (cheerA, cheerB)
        } else if name == "Cross Country" {
            return (crossCountryA, crossCountryB)
        } else if name == "Field Hockey" {
            return (fieldHockeyA, fieldHockeyB)
        } else if name == "Gymnastics" {
            return (gymnasticsA, gymnasticsB)
        } else if name == "Softball" {
            return (softBallA, softBallB)
        } else if name ==  "Volleyball" {
            return (volleyBallA, volleyBallB)
        } else if name == "Poms" {
            return (pomsA, pomsB)
        } else if name == "Basketball" {
            return (girlsBballA, girlsBballB)
        } else if name == "Swim/Dive" {
            return (girlsSwimmingA, girlsSwimmingB)
        } else if name == "Lacrosse" {
            return (girlsLacrosseA, girlsLacrosseB)
        } else if name == "Soccer" {
            return (girlsSoccerA, girlsSoccerB)
        } else if name == "Tennis" {
            return (girlsTennisA, girlsTennisB)
        } else if name == "Track and Field" {
            return (trackA, trackB)
        } else { //Golf
            return (girlsGolfA, girlsGolfB)
        }
    }
    func loadMale(_ name : String) -> (String, String) {
        var r = name + "M"
        if name == "Swim/Dive" {
            r = "SwimDiveM"
        }
        image.image = UIImage(named: r)
        if name == "Cross Country" {
            return (crossCountryA, crossCountryB)
        } else if name == "Football" {
            return (footballA, footballB)
        } else if name == "Golf" {
            return (golfA, golfB)
        } else if name == "Soccer" {
            return (boysSoccerA, boysSoccerB)
        } else if name == "Tennis" {
            return (boysTennisA, boysTennisB)
        } else if name == "Basketball" {
            return (boysBballA, boysBballB)
        } else if name == "Ice Hockey" {
            return (iceHockeyA, iceHockeyB)
        } else if name == "Wrestling" {
            return (wrestlingA, wrestlingB)
        } else if name == "Baseball" {
            return (baseBallA, baseBallB)
        } else if name == "Lacrosse" {
            return (boysLacrosseA, boysLacrosseB)
        } else if name == "Swim/Dive" { //pic is screwed up
            return (boysSwimmingA, boysSwimmingB)
        } else { //track and field
            return (trackA, trackB)
        }
    }
    
    
    @IBAction func click(_ sender: UIButton) {
        if sender.tag == select {
            //do nothing
        } else {
            select = sender.tag
            if sender.tag == 0 {
                let attribute = NSMutableAttributedString(string: "Game Schedule",
                                                          attributes: convertToOptionalNSAttributedStringKeyDictionary(attrs))
                let attribute2 = NSMutableAttributedString(string: "Contact", attributes: convertToOptionalNSAttributedStringKeyDictionary(attrs2))
                games.setAttributedTitle(attribute, for: .normal)
                contact.setAttributedTitle(attribute2, for: .normal)
                UIView.animate(withDuration: 0.5, animations: {
                    self.webView.alpha = 1
                    self.webView2.alpha = 0
                })
            } else {
                let attribute = NSMutableAttributedString(string: "Contact",
                                                          attributes: convertToOptionalNSAttributedStringKeyDictionary(attrs))
                let attribute2 = NSMutableAttributedString(string: "Game Schedule", attributes: convertToOptionalNSAttributedStringKeyDictionary(attrs2))
                games.setAttributedTitle(attribute2, for: .normal)
                contact.setAttributedTitle(attribute, for: .normal)
                UIView.animate(withDuration: 0.5, animations: {
                    self.webView.alpha = 0
                    self.webView2.alpha = 1
                })
            }
        }
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
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
