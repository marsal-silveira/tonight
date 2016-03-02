//
//  ClubTableViewCell.swift
//  Tonight
//
//  Created by Marsal on 29/02/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit
import Haneke

class ClubTableViewCell: UITableViewCell
{
    // *********************************** //
    // MARK: @IBOutlet
    // *********************************** //

    @IBOutlet private weak var _imgViewPhoto: UIImageView!
    @IBOutlet private weak var _lblName: UILabel!
    @IBOutlet private weak var _lblAddress: UILabel!
    @IBOutlet private weak var _lblDistance: UILabel!
    
    // *********************************** //
    // MARK: Utils
    // *********************************** //
    
    func configureCell(club: Club)
    {
        var distanceFromUser: String = ""
        if let distance = club.distance {
            distanceFromUser = "\(String(format: "%.1f", distance.toKilometer())) km"
        }

        // load labels and image view with club properties
        _lblName.text = club.name
        _lblAddress.text = club.address
        _lblDistance.text = distanceFromUser
        _imgViewPhoto.hnk_setImageFromURL(club.logoURL)
    }

}