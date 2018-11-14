////
////  CalendarViewController.swift
////  Bruins Den
////
////  Created by hari sowrirajan on 6/15/17.
////  Copyright © 2017 hari sowrirajan. All rights reserved.
////
//
//import UIKit
//import FSCalendar
//import Kanna
//import Alamofire
//import Darwin
//
//class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource {
//
//
//    @IBOutlet weak var revealButton: UIBarButtonItem!
//    @IBOutlet weak var calendar: FSCalendar!
//
//
//    @IBOutlet weak var tableView: UITableView!
//
//    var events = [EventDate]()
//    var thisDate = DateComponents()
//    var ind = -1
//
//    let cellReuseIdentifier = "cell"
//
//    var alert: UIAlertView = UIAlertView(title: "Loading", message: "Please wait. Loading only done every other week", delegate: nil, cancelButtonTitle: "")
//
//    var datesWithEvent = [String]()
//    fileprivate lazy var dateFormatter2: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter
//    }()
//
//    fileprivate lazy var dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd"
//        return formatter
//    }()
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.navigationBar.tintColor = UIColor.black
//        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
//        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: 25)!]
//        self.title = "Master Calendar"
//        //var alert: UIAlertView = UIAlertView(title: "Title", message: "Please wait...", delegate: nil, cancelButtonTitle: "Cancel");
//
//
//
//
//        let reveal = self.revealViewController()
//        reveal?.panGestureRecognizer().isEnabled = false
//
//
//
//        revealButton.target = self
//        revealButton.action = #selector(CalendarViewController.revealToggle)
//
//        tableView.delegate = self
//        tableView.dataSource = self
//        let date = Date()
//        let cal = Calendar.current
//        let year = cal.component(.year, from: date)
//        let month = cal.component(.month, from: date)
//        let day = cal.component(.day, from: date)
//        thisDate.year = year
//        thisDate.month = month
//        thisDate.day = day
//        loadEvents()
//
//        if let lastLoaded = UserDefaults.standard.object(forKey: "lastLoad") {
//            let today = Date()
//            if daysBetween(date1: lastLoaded as! Date, date2: today)>=14 {
//                var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 37, height: 37)) as UIActivityIndicatorView
//
//                loadingIndicator.center = self.view.center;
//                loadingIndicator.hidesWhenStopped = true
//                loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//                loadingIndicator.startAnimating();
//
//                alert.setValue(loadingIndicator, forKey: "accessoryView")
//                loadingIndicator.startAnimating()
//
//                alert.show();
//
//               scrapeCalendarFeed()
//            } else {
//                let decoded = UserDefaults.standard.object(forKey: "events") as! Data
//
//                self.events = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [EventDate]
//                self.datesWithEvent = UserDefaults.standard.object(forKey: "dates") as! [String]
//            }
//        } else {
//            var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 37, height: 37)) as UIActivityIndicatorView
//
//            loadingIndicator.center = self.view.center;
//            loadingIndicator.hidesWhenStopped = true
//            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//            loadingIndicator.startAnimating();
//
//            alert.setValue(loadingIndicator, forKey: "accessoryView")
//            loadingIndicator.startAnimating()
//
//            alert.show();
//
//            scrapeCalendarFeed()
//        }
//
//
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func revealToggle() {
//        let reveal = self.revealViewController()
//        reveal?.panGestureRecognizer().isEnabled = true
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        revealViewController().setFront(appDelegate?.mainViewController, animated: true)
//        revealViewController().revealToggle(self) // Optional
//    }
//    func loadDatesWithEvents() {
//        print("loading")
//        for i in 0..<events.count {
//            var addition = ""
//            let date = events[i].date
//            addition += String(date.year!)
//            addition += "-"
//            if date.month! < 10 {
//                addition += "0"
//                addition += String(date.month!)
//            } else {
//                addition += String(date.month!)
//            }
//            addition += "-"
//            if date.day! < 10 {
//                addition += "0"
//                addition += String(date.day!)
//            } else {
//                addition += String(date.day!)
//            }
//            //print(addition)
//            datesWithEvent.append(addition)
//
//        }
//    }
//
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        print("laj")
//        //print("did select date \(self.dateFormatter.string(from: date))")
//        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
//        let d = self.dateFormatter.string(from: date)
//        let arr = d.components(separatedBy: "/")
//        thisDate.year = Int(arr[0])!
//        thisDate.month = Int(arr[1])!
//        thisDate.day = Int(arr[2])!
//        tableView.reloadData()
//
//
//
//        print("selected dates is \(selectedDates)")
//
//        if monthPosition == .next || monthPosition == .previous {
//            calendar.setCurrentPage(date, animated: true)
//        }
//    }
//    /*
//     func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor? {
//     let dateString = self.dateFormatter2.string(from: date)
//     if self.datesWithEvent.contains(dateString) {
//     return UIColor.purple
//     }
//     return nil
//     }
//
//     func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
//     let key = self.dateFormatter2.string(from: date)
//     if self.datesWithMultipleEvents.contains(key) {
//     return [UIColor.magenta, appearance.eventDefaultColor, UIColor.black]
//     }
//     return nil
//     }
//
// */
//
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//        let dateString = self.dateFormatter2.string(from: date)
//        if self.datesWithEvent.contains(dateString) {
//            return 1
//        }
//        return 0
//    }
//
//    //TABLE VIEW METHODS
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let index = events.index(of: EventDate(thisDate)) {
//            ind = index
//
//            return events[index].event.count
//        } else {
//            print("here")
//            return 0
//        }
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell : EventTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! EventTableViewCell
//        cell.eventName.text = events[ind].event[indexPath.row].title
//        var time = ""
//        var numberOfSpace = 0
//        //figure out last day stuff
//        if let g = events[ind].event[indexPath.row].lastDay {
//            for i in 0..<g.characters.count {
//                if g[g.index(g.startIndex, offsetBy: i)] == " " {
//                    numberOfSpace += 1
//                    if numberOfSpace == 1 {
//                        time += ":"
//                    } else {
//                        time += " "
//                    }
//
//                } else {
//                    time += String(g[g.index(g.startIndex, offsetBy: i)])
//                }
//
//
//            }
//        } else {
//            time += String(events[ind].event[indexPath.row].hour)
//            time += ":"
//            if (events[ind].event[indexPath.row].minute == 0) {
//                time += "00"
//            } else {
//                time += String(events[ind].event[indexPath.row].minute)
//            }
//            time += " "
//            time += events[ind].event[indexPath.row].AM
//        }
//
//
//        cell.time.text = time
//
//        return cell
//
//
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let ev = events[ind].event[indexPath.row]
//
//        self.performSegue(withIdentifier: "toEvent", sender: ev)
//    }
//
//    //Change to loading from database when applicable
//    private func loadEvents() {
//
//    }
//
//
//    //Enter date in form "yyyy-MM-dd"
//    private func createDate(str : String) -> DateComponents {
//        let timeArr = str.components(separatedBy: "-")
//        var dateComp = DateComponents()
//        dateComp.year = Int(timeArr[0])!
//        dateComp.month = Int(timeArr[1])!
//        dateComp.day = Int(timeArr[2])!
//        return dateComp
//    }
//    func scrapeCalendarFeed() {
//        print("here")
//        /*Alamofire.request("http://nycmetalscene.com").responseString { response in
//            print("\(response.result.isSuccess)")
//            if let html = response.result.value {
//                self.parseHTML(html: html)
//            }
//        } */
//
//        Alamofire.request("http://cherrycreek.cherrycreekschools.org/_layouts/15/listfeed.aspx?List=%7B9CE5158B-4A2D-4B34-B16E-1B1FD2A169B7%7D&Source=http%3A%2F%2Fcherrycreek%2Echerrycreekschools%2Eorg%2FLists%2FSchoolEvents%2Fcalendar%2Easpx").responseString { response in
//            print("\(response.result.isSuccess)")
//            if let html = response.result.value {
//                self.parseHTML(html: html)
//            }
//        }
//
//
//    }
//    //We need to figure out how to efficiently parse - maybe we should only consider events by month, and only scrape the rest if the user navigates to other months
//    //some indices are hard coded - be careful (since we're assuming that description or end time will always have the same length
//    //Watch out for duplicate timings! - what if something's start time == another's end time, like afterprom?
//    //We've fixed the above using the varaible leftOffIndex
//    func parseHTML(html : String) {
//        var count = 0
//        print("parse HTML")
//
//        //http://tid-kijyun.github.io/Kanna/tutorials/v2/searching.html
//        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
//            if let total = doc.text {
//                //print(doc.text!)
//                var leftOffIndex = total.startIndex
//
//
//                var previous = ""
//                var eventDateIndex = -1
//                var eventIndex = -1
//                for show in doc.css("div") {
//                    var datecomp1 = DateComponents()
//                    var startTime = ""
//
//                    var endTime = ""
//
//                    let this = show.text!
//                    var datecomp = DateComponents()
//                    if this.hasPrefix("Description:") {
//                        let index = this.index(this.startIndex, offsetBy: 13)
//                        var desc = this.substring(from: index)
//                        //removes \n, spaces
//                        desc = String(desc.characters.filter { !" \n\t\r".characters.contains($0) })
//                        events[eventDateIndex].event[eventIndex].message = desc
//                    }
//                    else if this.hasPrefix("End Time") {
//                        let needle: Character = ":"
//                        var boolean = false //if we perform the if loop below
//                        if previous.hasPrefix("Start Time") {
//                            count += 1
//
//                            let index = this.index(this.startIndex, offsetBy: 12)
//                            let s = previous.substring(from: index)
//                            parseDateTime(str: s, d: &datecomp, start: &startTime)
//                            var eventDate = EventDate(datecomp)
//                            datecomp1.day = datecomp.day
//                            datecomp1.year = datecomp.year
//                            datecomp1.month = datecomp.month
//                            if let ind = self.events.index(of: eventDate) {
//                                eventDateIndex = ind
//                            } else {
//                                self.events.append(eventDate)
//                                eventDateIndex = self.events.count - 1
//                            }
//                            boolean = true
//                        }
//
//                        //var datecomp = DateComponents()
//                        let index = this.index(this.startIndex, offsetBy: 10)
//                        let info = this.substring(from: index)
//                        parseDateTime(str: info, d: &datecomp, start: &endTime)
//
//                        endTime = info
//
//                        if let indexOf = total.range(of: endTime, range: leftOffIndex..<total.endIndex)?.lowerBound {
//                            if(!boolean) { //Start time == end time or its not there for some reason
//                                //startTime = endTime
//                                let startIndex = total.range(of: "Start Time: ", options: .backwards, range: leftOffIndex..<indexOf)?.upperBound
//
//                                parseDateTime(str: total.substring(with: startIndex!..<indexOf), d: &datecomp, start: &startTime)
//                                var eventDate = EventDate(datecomp)
//                                if let ind = self.events.index(of: eventDate) {
//                                    eventDateIndex = ind
//                                } else {
//                                    self.events.append(eventDate)
//                                    eventDateIndex = self.events.count - 1
//                                }
//                                //leftOffIndex = (total.range(of: endTime, range: leftOffIndex..<total.endIndex)?.upperBound)!
//                                //for end time we just want the whole string, not any specific info
//                            }
//                            leftOffIndex = (total.range(of: endTime, range: leftOffIndex..<total.endIndex)?.upperBound)!
//                            //let intValue = total.distance(from: total.startIndex, to: indexOf)
//                            let htmlIndex = total.range(of: "http", options: .backwards, range: total.startIndex..<indexOf)?.lowerBound
//                            var startPoint = total.distance(from: total.startIndex, to: htmlIndex!)
//                            startPoint = startPoint - 1
//                            var execute = true
//                            while(execute) {
//                                let index = total.index(total.startIndex, offsetBy: startPoint)
//                                if total[index] != " " {
//                                    execute = false
//                                    break
//                                }
//                                startPoint = startPoint - 1
//                            }
//                            startPoint = startPoint + 1 //we want the first index after the title
//                            let endIndex = total.characters.index(total.startIndex, offsetBy: startPoint)
//                            let firstIndex = total.range(of: "   ", options: .backwards, range: total.startIndex..<endIndex)?.upperBound
//                            //FINALLY!!!
//                            let range = firstIndex!..<endIndex
//                            let eventTitle = total.substring(with: range)
//
//                            //Check if there is a location
//                            let rangeForLocation = firstIndex!..<indexOf
//                            let eventWithLocation = total.substring(with: rangeForLocation)
//                            var loc = ""
//                            if let loc1 = total.range(of: "Location: ", range: rangeForLocation) {
//                                let locationIndex = loc1.upperBound
//                                let end = total.range(of: "Start", range: rangeForLocation)?.lowerBound
//                                loc = total.substring(with: locationIndex..<end!)
//                            }
//                            //Create the event
//                            let ev = Event(eventTitle, "", startTime)
//                            ev.endTime = endTime
//                            if boolean {
//                                ev.startDate = datecomp1
//                            }else{
//                                ev.startDate = datecomp
//                            }
//                            ev.location = loc
//                            self.events[eventDateIndex].event.append(ev)
//                            eventIndex = self.events[eventDateIndex].event.count - 1
//                            print("here we are" + startTime + " " + endTime)
//                            //print("description" + description)
//
//                        }
//
//
//
//
//
//
//                    }
//                    //print(show.text)
//                    previous = show.text!
//                }
//            }
//
//        }
//        //print(count)
//
//        addMultiEvents()
//        loadDatesWithEvents()
//        sortEvents()
//        calendar.reloadData()
//        print(events)
//        print("ok")
//        UserDefaults.standard.set(datesWithEvent, forKey: "dates")
//        let dddd = Date()
//        UserDefaults.standard.set(dddd, forKey: "lastLoad")
//        print("ok1")
//        let encodedData = NSKeyedArchiver.archivedData(withRootObject: events)
//
//        UserDefaults.standard.set(encodedData, forKey: "events")
//        print("ok2")
//
//        alert.dismiss(withClickedButtonIndex: -1, animated: true)
//
//    }
//
//
//
//
//    //str: "mm/dd/yyyy 88:88 AM"
//    func parseDateTime(str : String, d : inout DateComponents, start : inout String) {
//        let needle: Character = " "
//        var date = ""
//        if let idx = str.characters.index(of: needle) {
//            let pos = str.characters.distance(from: str.startIndex, to: idx)
////            print("Found \(needle) at position \(pos)")
//            date = str.substring(to: idx)
//            start = str.substring(from: idx)
//            start.remove(at: start.startIndex)
//            start = start.replacingOccurrences(of: ":", with: " ")
//        }
//
//        let arr = date.components(separatedBy: "/")
//        //print(str)
//        //print("str is \(str)")
//        d.month = Int(arr[0])!
//        d.day = Int(arr[1])!
//        d.year = Int(arr[2])!
//    }
//    //If events extend over many days, adds it to each individual day
//    func addMultiEvents() {
//        events.sort { (one : EventDate, two : EventDate) -> Bool in
//            daysBetweenDates(one: one.date, two: two.date) < 0
//        }
//        var d = DateComponents()
//        var placeHold = ""
//        let count = events.count
//        for a in 0..<count { //should be the start date
//            var eventDate = self.events[a]
//            print(eventDate.date)
//            for event in eventDate.event {
//                var copy = DateComponents()
//                copy.month = eventDate.date.month!
//                copy.year = eventDate.date.year!
//                copy.day = eventDate.date.day!
//                //print("date \(copy)")
//                parseDateTime(str: event.endTime, d: &d, start: &placeHold)
//                let days = daysBetweenDates(one : eventDate.date, two : d)
//                for i in 0..<days {
//                    copy = incrementDate(d: copy)
//                    let e = event.copy() as! Event
//                    var ev = EventDate(copy)
//                    if i == days - 1{
//
//                        e.lastDay = placeHold
//
//                    }
//                    if let ind = self.events.index(of: ev) { //array already has this event date
//                        self.events[ind].event.append(e)
//
//
//                    } else {
//                        ev.event.append(e)
//                        self.events.append(ev)
//
//
//                    }
//
//
//
//                }
//
//            }
//        }
//    }
//
//    func daysBetweenDates(one : DateComponents, two : DateComponents) -> Int {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let year1 = String(one.year!)
//        let month1 = String(one.month!)
//        let day1 = String(one.day!)
//        let year2 = String(two.year!)
//        let month2 = String(two.month!)
//        let day2 = String(two.day!)
//
//        var first = year1 + "-"
//        var last = year2 + "-"
//        if one.month! < 10 {
//            first += "0" + month1
//        } else {
//            first += month1
//        }
//        if one.day! < 10 {
//            first += "-0" + day1
//        } else {
//            first += "-" + day1
//        }
//        if two.month! < 10 {
//            last += "0" + month2
//        } else {
//            last += month2
//        }
//        if two.day! < 10 {
//            last += "-0" + day2
//        } else {
//            last += "-" + day2
//        }
//
//        //let first = "2010-09-01"
//        let firstDate = dateFormatter.date(from: first)!
//        //let last = "2010-09-05"
//        let lastDate = dateFormatter.date(from: last)!
//
//        let currentCalendar = NSCalendar.current
//        let timeUnitDay = NSCalendar.Unit.day
//
//        let dd = currentCalendar.dateComponents([.day], from: firstDate, to: lastDate)
//        return dd.day!
//
//
//    }
//    func incrementDate(d : DateComponents) -> DateComponents {
//        var new = DateComponents()
//        let currentDate = Calendar.current.date(from: d)
//        new.day = 1
//        new.month = 0
//        new.year = 0
//        let futureDate = Calendar.current.date(byAdding: new, to: currentDate!)
//        let units: Set<Calendar.Component> = [.day, .month, .year]
//        let comps = Calendar.current.dateComponents(units, from: futureDate!)
//        return comps
//    }
//
//
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        var next = segue.destination as! EventViewController
//        let e = sender as! Event
//        next.descr = e.message
//        var minute = ""
//        if e.minute < 10 {
//            minute = "0" + String(e.minute)
//        } else {
//            minute = String(e.minute)
//        }
//        next.startText = "Start Time: " + String(e.startDate.month!) + "/" + String(e.startDate.day!) + "/" + String(e.startDate.year!) + " " + String(e.hour) + ":" + minute + " " + e.AM
//        next.endText = "End Time: " + e.endTime
//        next.titleText = e.title
//
//    }
//    func sortEvents() {
//        for eventDate in events {
//            eventDate.event.sort(by: { (one : Event, two : Event) -> Bool in
//                var time1 = 100*one.hour + one.minute
//                print(one.AM + " " + two.AM)
//                if one.AM != "AM" && one.hour != 12{
//                    time1 += 1200
//                }
//                if one.hour == 12 && one.AM == "AM" {
//                    time1 = one.minute
//                }
//                var time2 = 100*two.hour + two.minute
//                if two.AM != "AM" && two.hour != 12{
//                    time2 += 1200
//                }
//                if two.hour == 12 && two.AM == "AM" {
//                    time2 = two.minute
//                }
//                print("time")
//                print(time1)
//                print(time2)
//                return time1 < time2
//            })
//        }
//    }
//    //convienience for Date, NOT datecomponent:
//    func daysBetween(date1: Date, date2: Date) -> Int {
//        let calendar = Calendar.current
//
//        let date1 = calendar.startOfDay(for: date1)
//        let date2 = calendar.startOfDay(for: date2)
//
//        let components = calendar.dateComponents([Calendar.Component.day], from: date1, to: date2)
//
//        return components.day ?? 0
//    }
//
//
//}
