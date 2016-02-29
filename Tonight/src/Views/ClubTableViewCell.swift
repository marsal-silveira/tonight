//
//  ClubTableViewCell.swift
//  Tonight
//
//  Created by Marsal on 28/02/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit

class ClubTableViewCell: UITableViewCell
{
    @IBOutlet private weak var _lblName: UILabel!
    @IBOutlet private weak var _lblCity: UILabel!
    @IBOutlet private weak var _lblDistance: UILabel!
    @IBOutlet private weak var _imgViewPhoto: UIImageView!
    
//    func configureCell(club: Club)
//    {
//        _lblName.text = club.name
//        _lblCity.text = club.city
//        _lblDistance.text = "10 KM" //"Total Votes: \(joke.jokeVotes)"
//    }
    
    func configureCell(name: String, city: String, distance: String)
    {
        _lblName.text = name
        _lblCity.text = city
        _lblDistance.text = distance
    }
    
}