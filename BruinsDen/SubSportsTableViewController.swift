//
//  SubSportsTableViewController.swift
//  Bruins Den
//
//  Created by hari sowrirajan on 7/25/17.
//  Copyright © 2017 hari sowrirajan. All rights reserved.
//

import UIKit

class SubSportsTableViewController: UITableViewController {
    
    var mensFall : [Sport] = [Sport("Cross Country", #imageLiteral(resourceName: "crosscountry")), Sport("Football", #imageLiteral(resourceName: "football")), Sport("Golf", #imageLiteral(resourceName: "golf")), Sport("Soccer", #imageLiteral(resourceName: "soccer")), Sport("Tennis", #imageLiteral(resourceName: "tennis"))]
    var womensFall : [Sport] = [Sport("Cheer", #imageLiteral(resourceName: "Cheer")), Sport("Cross Country", #imageLiteral(resourceName: "crosscountry")), Sport("Field Hockey", #imageLiteral(resourceName: "Field Hockey")), Sport("Gymnastics", #imageLiteral(resourceName: "Gymnastics")), Sport("Softball", #imageLiteral(resourceName: "Softball")), Sport("Volleyball", #imageLiteral(resourceName: "Volleyball")), Sport("Poms", #imageLiteral(resourceName: "Poms"))]
    var mensWinter : [Sport] = [Sport("Basketball", #imageLiteral(resourceName: "basketball")), Sport("Ice Hockey", #imageLiteral(resourceName: "hockey")), Sport("Wrestling", #imageLiteral(resourceName: "wrestling"))]
    var womensWinter : [Sport] = [Sport("Basketball", #imageLiteral(resourceName: "basketball")), Sport("Swim/Dive", #imageLiteral(resourceName: "swimming"))]
    var mensSpring : [Sport] = [Sport("Baseball", #imageLiteral(resourceName: "baseballIcon")), Sport("Lacrosse", #imageLiteral(resourceName: "lacrosse")), Sport("Swim/Dive", #imageLiteral(resourceName: "swimming")), Sport("Track and Field", #imageLiteral(resourceName: "track"))]
    var womensSpring : [Sport] = [Sport("Lacrosse", #imageLiteral(resourceName: "lacrosse")), Sport("Soccer", #imageLiteral(resourceName: "soccer")), Sport("Tennis", #imageLiteral(resourceName: "tennis")), Sport("Track and Field", #imageLiteral(resourceName: "track")), Sport("Golf", #imageLiteral(resourceName: "golf"))]
    var currentArray = [Sport]()
    var gender = -1 //0 is man, 1 is woman
    var season = 0 //1 is fall, 2 is winter, etc.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //loadSports()
        if season == 1 && gender == 0{
            currentArray = mensFall
            //return mensFall.count
        } else if season == 2 && gender == 0 {
            currentArray = mensWinter
            //return mensWinter.count
        } else if season == 3 && gender == 0{
            currentArray = mensSpring
           // return mensSpring.count
        } else if season == 1 && gender == 1 {
            currentArray = womensFall
        } else if season == 2 && gender == 1 {
            currentArray = womensWinter
        } else {
            currentArray = womensSpring
        }
        
        //self.tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print("loading table")
        return currentArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print("lim sup")
        let cellIdentifier = "SubSportsTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SubSportsTableViewCell else {
            fatalError("The dequeued cell is not an instance of SubSportsTableViewCell.")
            
        }
        cell.icon.image = currentArray[indexPath.row].icon
        cell.name.text = currentArray[indexPath.row].name
        

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSportsDetail", sender: (currentArray[indexPath.row], gender))
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let g = sender as? (Sport, Int) {
            
            if segue.identifier == "toSportsDetail" {
                if let vc = segue.destination as? DetailAthleticsViewController {
                    vc.gender = g.1
                    vc.sport = g.0
                }
            }
        }
    }
    
    
    

}
