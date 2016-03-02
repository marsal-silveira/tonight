//
//  ClubDetailTableViewController.swift
//  Tonight
//
//  Created by Marsal on 29/02/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit
import Firebase

class ClubDetailTableViewController : UIViewController
{
    // *********************************** //
    // MARK: Properties
    // *********************************** //
    
    private var _selectedClub: Club!
    var selectedClub: Club {
        get { return _selectedClub }
        set(newValue) { _selectedClub = newValue }
    }
    
    // *********************************** //
    // MARK: <UIViewController> Lifecycle
    // *********************************** //

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == Segue_DetailToMap) {
            let viewController = segue.destinationViewController as! MapViewController
            viewController.selectedClub = _selectedClub
        }
    }
    
}