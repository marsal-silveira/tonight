//
//  ClubListTableViewController.swift
//  Tonight
//
//  Created by Marsal on 28/02/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit
//import Firebase

class ClubListTableViewController : UITableViewController
{
//    private var _clubs = [Club]()
//    private var _selectedClub: Club!
    
    private var _names = ["The Liffey Brew Pub", "Bendito Boteco & Cervejaria", "Cervejaria Faixa Preta", "Cervejaria Badenia"]
    private var _cities = ["Palhoça", "Palhoça", "Santo Amaro da Imperatriz", "Santo Amaro da Imperatriz"]
    private var _distances = ["10KM", "20KM", "30KM", "35KM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
        
//        // observeEventType is called whenever anything changes in the Firebase - new Clubs
//        // It's also called here in viewDidLoad().
//        // It's always listening.
//        
//        FirebaseApp.sharedInstance().observeClubsWithBlock( { snapshot in
//            
//            // The snapshot is a current look at our clubs data
////            print(snapshot.value)
//            
//            self._clubs = []
//            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
//                
//                for snap in snapshots {
//                    
//                    if let properties = snap.value as? Dictionary<String, AnyObject> {
//                        let name = properties["name"] as! String
//                        let imageURL = properties["imageURL"] as! String
//                        let city = properties["city"] as! String
//                        let longitude = properties["longitude"] as! String
//                        let latitude = properties["latitude"] as! String
//                        let parties = properties["parties"] as? [Party]
//                        let club = Club(uid: snap.key, name: name, imageURL: imageURL, city: city, longitude: longitude, latitude: latitude, parties: parties)
//                        
//                        // Items are returned chronologically, but it's more fun with the newest clubs first.
//                        self._clubs.insert(club, atIndex: 0)
//                    }
//                }
//            }
//            
//            // Be sure that the tableView updates when there is new data.
//            self.tableView.reloadData()
//        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        return _clubs.count
        return _names.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCellWithIdentifier("ClubCell") as? ClubTableViewCell {
//            cell.configureCell(_clubs[indexPath.row])
            cell.configureCell(_names[indexPath.row], city:_cities[indexPath.row], distance: _distances[indexPath.row])
            return cell
        } else {
            return ClubTableViewCell()
        }
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
//    {
//        print("You selected cell #\(indexPath.row)!")
//        _selectedClub = _clubs[indexPath.row]
//        performSegueWithIdentifier(Segue_ClubListToDetail, sender: self)        
//    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//        if (segue.identifier == Segue_ClubListToDetail) {
//            let viewController = segue.destinationViewController as! ClubDetailTableViewController
//            viewController.selectClub = _selectedClub
//        }
        
//    }
    
}