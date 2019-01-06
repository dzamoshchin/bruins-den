//
//  CalendarViewController.swift
//  Bruins Den
//
//  Created by Daniel Zamoshchin on 12/31/18.
//  Copyright © 2017 Daniel Zamoshchin. All rights reserved.
//

import UIKit
import FSCalendar
import Darwin
import FeedKit

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!

    var events = [EventDate]()
    var thisDate = DateComponents()
    var ind = -1

    let cellReuseIdentifier = "cell"

    var alert: UIAlertView = UIAlertView(title: "Loading...", message: "Please wait. The calendar is only loaded every other week.", delegate: nil, cancelButtonTitle: "Cancel")

    var datesWithEvent = [String]()
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController!.navigationBar.setTitleVerticalPositionAdjustment(1, for: .default)
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 25)!]
        self.title = "Master Calendar"

        tableView.delegate = self
        tableView.dataSource = self
        let date = Date()
        let cal = Calendar.current
        let year = cal.component(.year, from: date)
        let month = cal.component(.month, from: date)
        let day = cal.component(.day, from: date)
        thisDate.year = year
        thisDate.month = month
        thisDate.day = day
        loadEvents()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600

        if let lastLoaded = UserDefaults.standard.object(forKey: "lastLoad") {
            let today = Date()
            if daysBetween(date1: lastLoaded as! Date, date2: today)>=14 {
                var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 37, height: 37)) as UIActivityIndicatorView

                loadingIndicator.center = self.view.center;
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.style = UIActivityIndicatorView.Style.gray
                loadingIndicator.startAnimating();

                alert.setValue(loadingIndicator, forKey: "accessoryView")
                loadingIndicator.startAnimating()

                alert.show();

               parseRSS()
            } else {
                let decoded = UserDefaults.standard.object(forKey: "events") as! Data

                self.events = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [EventDate]
                self.datesWithEvent = UserDefaults.standard.object(forKey: "dates") as! [String]
            }
        } else {
            var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 50, y: 10, width: 37, height: 37)) as UIActivityIndicatorView

            loadingIndicator.center = self.view.center;
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating();

            alert.setValue(loadingIndicator, forKey: "accessoryView")
            loadingIndicator.startAnimating()

            alert.show();

            parseRSS()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadDatesWithEvents() {
        print("loading")
        for i in 0..<events.count {
            var addition = ""
            let date = events[i].date
            addition += String(date.year!)
            addition += "-"
            if date.month! < 10 {
                addition += "0"
                addition += String(date.month!)
            } else {
                addition += String(date.month!)
            }
            addition += "-"
            if date.day! < 10 {
                addition += "0"
                addition += String(date.day!)
            } else {
                addition += String(date.day!)
            }
            //print(addition)
            datesWithEvent.append(addition)

        }
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        _ = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        let d = self.dateFormatter.string(from: date)
        let arr = d.components(separatedBy: "/")
        thisDate.year = Int(arr[0])
        thisDate.month = Int(arr[1])
        thisDate.day = Int(arr[2])
        tableView.reloadData()

        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    /*
     func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor? {
     let dateString = self.dateFormatter2.string(from: date)
     if self.datesWithEvent.contains(dateString) {
     return UIColor.purple
     }
     return nil
     }

     func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
     let key = self.dateFormatter2.string(from: date)
     if self.datesWithMultipleEvents.contains(key) {
     return [UIColor.magenta, appearance.eventDefaultColor, UIColor.black]
     }
     return nil
     }

 */

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return 1
        }
        return 0
    }

    //TABLE VIEW METHODS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let index = events.index(of: EventDate(thisDate)) {
            ind = index

            return events[index].event.count
        } else {
            print("here")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : EventTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! EventTableViewCell
        cell.eventName.text = events[ind].event[indexPath.row].title
        var time = ""
        var numberOfSpace = 0
        //figure out last day stuff
        if let g = events[ind].event[indexPath.row].lastDay {
            for i in 0..<g.count {
                if g[g.index(g.startIndex, offsetBy: i)] == " " {
                    numberOfSpace += 1
                    if numberOfSpace == 1 {
                        time += ":"
                    } else {
                        time += " "
                    }

                } else {
                    time += String(g[g.index(g.startIndex, offsetBy: i)])
                }


            }
        } else {
            time += String(events[ind].event[indexPath.row].hour)
            time += ":"
            if (events[ind].event[indexPath.row].minute == 0) {
                time += "00"
            } else {
                time += String(events[ind].event[indexPath.row].minute)
            }
            time += " "
            time += events[ind].event[indexPath.row].AM
        }


        cell.time.text = time

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ev = events[ind].event[indexPath.row]
        
        self.performSegue(withIdentifier: "toEvent", sender: ev)
    }

    //Change to loading from database when applicable
    private func loadEvents() {

    }
    //Enter date in form "yyyy-MM-dd"
    private func createDate(str : String) -> DateComponents {
        let timeArr = str.components(separatedBy: "-")
        var dateComp = DateComponents()
        dateComp.year = Int(timeArr[0])!
        dateComp.month = Int(timeArr[1])!
        dateComp.day = Int(timeArr[2])!
        return dateComp
    }

    //Watch out for duplicate timings! - what if something's start time == another's end time, like afterprom?
    func parseRSS() {
        let feedURL = URL(string: "http://cherrycreek.cherrycreekschools.org/_layouts/15/listfeed.aspx?List=%7B9CE5158B-4A2D-4B34-B16E-1B1FD2A169B7%7D&Source=http%3A%2F%2Fcherrycreek%2Echerrycreekschools%2Eorg%2FLists%2FSchoolEvents%2Fcalendar%2Easpx")!
        let parser = FeedParser(URL: feedURL)
        let result = parser.parse()

        // Do your thing, then back to the Main thread
        guard let feed = result.rssFeed, result.isSuccess else {
            print(result.error as Any)
            return
        }
        
        print("This happens")
        
        for item in feed.items! {
            print("Strange happenings")
            var start = ""
            var end = ""
            
            let str = item.description!
            if let index = str.index(of: "<div><b>Start Time:</b> ") {
                let removeLocation = String(str[index...])
                if let startTimeEnd = removeLocation.index(of: "</div") {
                    //Extracting Start Time from HTML
                    var isolateStart = String(removeLocation[..<startTimeEnd])
                    isolateStart = isolateStart.replacingOccurrences(of: "<div><b>Start Time:</b> ", with: "")
                    start = isolateStart.trimmingCharacters(in: .newlines)
                    
                    //Extracting End Time from HTML
                    let rest = String(removeLocation[removeLocation.index(startTimeEnd, offsetBy: 6)...])
                    if let endTimeEnd = rest.index(of: "</div") {
                        var isolateEnd = String(rest[..<endTimeEnd])
                        isolateEnd = isolateEnd.replacingOccurrences(of: "<div><b>End Time:</b> ", with: "")
                        end = isolateEnd.trimmingCharacters(in: .newlines)
                    }
                }
            }
            
            var datecomp = DateComponents()
            print(start)
            print(end)
            print("before it crashes")
            self.parseDateTime(str: start, d: &datecomp, start: &start)
            
            let eventTitle = item.title!
            print("Start: " + start)
            print("End: " + end)

            //Create the event
            let event = Event(eventTitle, "", start)
            event.endTime = end
            event.startDate = datecomp
            let eventDate = EventDate(datecomp)
            if self.events.contains(eventDate) {
                self.events[self.events.firstIndex(of: eventDate)!].event.append(event)
            } else {
                eventDate.event.append(event)
                self.events.append(eventDate)
            }
        }
            
        print("after this")
        
        self.addMultiEvents()
        self.loadDatesWithEvents()
        self.sortEvents()
        self.calendar.reloadData()
        
        UserDefaults.standard.set(self.datesWithEvent, forKey: "dates")
        let currentDate = Date()
        UserDefaults.standard.set(currentDate, forKey: "lastLoad")
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.events)
        UserDefaults.standard.set(encodedData, forKey: "events")
        self.alert.dismiss(withClickedButtonIndex: -1, animated: true)
    }

    //str: "mm/dd/yyyy 88:88 AM"
    func parseDateTime(str : String, d : inout DateComponents, start : inout String) {
        let needle: Character = " "
        var date = ""
        if let idx = str.characters.index(of: needle) {
            let pos = str.characters.distance(from: str.startIndex, to: idx)
            date = str.substring(to: idx)
            start = str.substring(from: idx)
            start.remove(at: start.startIndex)
            start = start.replacingOccurrences(of: ":", with: " ")
        }

        let arr = date.components(separatedBy: "/")
        //print(str)
        //print("str is \(str)")
        d.month = Int(arr[0])!
        d.day = Int(arr[1])!
        d.year = Int(arr[2])!
    }

    //If events extend over many days, adds it to each individual day
    func addMultiEvents() {
        events.sort { (one : EventDate, two : EventDate) -> Bool in
            daysBetweenDates(one: one.date, two: two.date) < 0
        }
        var d = DateComponents()
        var placeHold = ""
        let count = events.count
        for a in 0..<count { //should be the start date
            let eventDate = self.events[a]
            print(eventDate.date)
            for event in eventDate.event {
                var copy = DateComponents()
                copy.month = eventDate.date.month!
                copy.year = eventDate.date.year!
                copy.day = eventDate.date.day!
                //print("date \(copy)")
                parseDateTime(str: event.endTime, d: &d, start: &placeHold)
                let days = daysBetweenDates(one : eventDate.date, two : d)
                for i in 0..<days {
                    copy = incrementDate(d: copy)
                    let e = event.copy() as! Event
                    let ev = EventDate(copy)
                    if i == days - 1{
                        e.lastDay = placeHold
                    }
                    if let ind = self.events.index(of: ev) { //array already has this event date
                        self.events[ind].event.append(e)
                    } else {
                        ev.event.append(e)
                        self.events.append(ev)
                    }
                }
            }
        }
    }

    func daysBetweenDates(one : DateComponents, two : DateComponents) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let year1 = String(one.year!)
        let month1 = String(one.month!)
        let day1 = String(one.day!)
        let year2 = String(two.year!)
        let month2 = String(two.month!)
        let day2 = String(two.day!)

        var first = year1 + "-"
        var last = year2 + "-"
        if one.month! < 10 {
            first += "0" + month1
        } else {
            first += month1
        }
        if one.day! < 10 {
            first += "-0" + day1
        } else {
            first += "-" + day1
        }
        if two.month! < 10 {
            last += "0" + month2
        } else {
            last += month2
        }
        if two.day! < 10 {
            last += "-0" + day2
        } else {
            last += "-" + day2
        }

        //let first = "2010-09-01"
        let firstDate = dateFormatter.date(from: first)!
        //let last = "2010-09-05"
        let lastDate = dateFormatter.date(from: last)!

        let currentCalendar = NSCalendar.current
        
        let dd = currentCalendar.dateComponents([.day], from: firstDate, to: lastDate)
        return dd.day!
    }
    
    func incrementDate(d : DateComponents) -> DateComponents {
        var new = DateComponents()
        let currentDate = Calendar.current.date(from: d)
        new.day = 1
        new.month = 0
        new.year = 0
        let futureDate = Calendar.current.date(byAdding: new, to: currentDate!)
        let units: Set<Calendar.Component> = [.day, .month, .year]
        let comps = Calendar.current.dateComponents(units, from: futureDate!)
        return comps
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let next = segue.destination as! EventViewController
        let event = sender as! Event
        next.descr = event.message
        var minute = ""
        if event.minute < 10 {
            minute = "0" + String(event.minute)
        } else {
            minute = String(event.minute)
        }
        next.startText = "Start Time: " + String(event.startDate.month!) + "/" + String(event.startDate.day!) + "/" + String(event.startDate.year!) + " " + String(event.hour) + ":" + minute + " " + event.AM
        next.endText = "End Time: " + event.endTime
        next.titleText = event.title
    }
    
    func sortEvents() {
        for eventDate in events {
            eventDate.event.sort(by: { (one : Event, two : Event) -> Bool in
                var time1 = 100*one.hour + one.minute
                print(one.AM + " " + two.AM)
                if one.AM != "AM" && one.hour != 12{
                    time1 += 1200
                }
                if one.hour == 12 && one.AM == "AM" {
                    time1 = one.minute
                }
                var time2 = 100*two.hour + two.minute
                if two.AM != "AM" && two.hour != 12{
                    time2 += 1200
                }
                if two.hour == 12 && two.AM == "AM" {
                    time2 = two.minute
                }
                print("time")
                print(time1)
                print(time2)
                return time1 < time2
            })
        }
    }
    
    //convienience for Date, NOT datecomponent:
    func daysBetween(date1: Date, date2: Date) -> Int {
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: date1)
        let date2 = calendar.startOfDay(for: date2)

        let components = calendar.dateComponents([Calendar.Component.day], from: date1, to: date2)

        return components.day ?? 0
    }
}

extension StringProtocol where Index == String.Index {
    func index(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: Self, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while start < endIndex,
            let range = self[start..<endIndex].range(of: string, options: options) {
                result.append(range.lowerBound)
                start = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    func ranges(of string: Self, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while start < endIndex,
            let range = self[start..<endIndex].range(of: string, options: options) {
                result.append(range)
                start = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
