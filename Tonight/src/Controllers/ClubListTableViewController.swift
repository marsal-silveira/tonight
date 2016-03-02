//
//  ClubListTableViewController.swift
//  Tonight
//
//  Created by Marsal on 29/02/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit
import Firebase

class ClubListTableViewController : UITableViewController
{
    // ****************************** //
    // MARK: Init
    // ****************************** //
    
    private var _clubs: [Club] = [Club]()
    private var _selectedClub: Club!
    
    // *********************************** //
    // MARK: <UIViewController> Lifecycle
    // *********************************** //
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // wait until Firebase send data or occurs some event
        FirebaseApp.sharedInstance().fechtClubsFromServerFromCity("Palhoça", completionBlock: { clubs in
            
            // update clubs list and refresh table data with new values
            self._clubs = clubs
            self.tableView.reloadData()
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == Segue_ListToDetail) {
            let viewController = segue.destinationViewController as! ClubDetailTableViewController
            viewController.selectedClub = _selectedClub
        }
    }
    
    // *********************************** //
    // MARK: <UITableViewDataSource>
    // *********************************** //
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return _clubs.count
    }
    
    // *********************************** //
    // MARK: <UITableViewDelegate>
    // *********************************** //
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var result: ClubTableViewCell!
        if let cell = tableView.dequeueReusableCellWithIdentifier("ClubCell") as? ClubTableViewCell {
            result = cell
        }
        else {
            result = ClubTableViewCell()
        }
        result.configureCell(_clubs[indexPath.row])
        return result
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("You selected cell #\(indexPath.row)!")
        _selectedClub = _clubs[indexPath.row]
        performSegueWithIdentifier(Segue_ListToDetail, sender: self)
    }
    
}