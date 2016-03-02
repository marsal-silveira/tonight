//
//  Club.swift
//  Tonight
//
//  Created by Marsal on 29/02/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import Firebase

struct Club
{
    // ****************************** //
    // MARK: Properties
    // ****************************** //
    
    // stored
    private var _uid: String?
    var uid: String? {
        return _uid
    }
    
    private var _name: String
    var name: String {
        return _name
    }
    
    private var _logoPath: String
    var logoPath: String {
        return _logoPath
    }
    
    private var _city: String
    var city: String {
        return _city
    }
    
    private var _address: String
    var address: String {
        return _address
    }
    
    private var _latitude: String
    var latitude: String {
        return _latitude
    }
    
    private var _longitude: String
    var longitude: String {
        return _longitude
    }
    
    private var _parties: [Party]?
    var parties: [Party]? {
        return _parties
    }
    
    // temporal...
    private var _logoURL: NSURL
    var logoURL: NSURL {
        return _logoURL
    }
    
    private var _location: CLLocation
    var location: CLLocation {
        return _location
    }
    
    var distance: CLLocationDistance? {
        return Geolocator.sharedInstance().calculateDistanceFromCurrentLocation(_location)
    }

    // ****************************** //
    // MARK: Init
    // ****************************** //
    
    init(name: String, logoPath: String, city: String, address: String, latitude: String, longitude: String, parties: [Party]?)
    {
        self.init(uid: nil, name: name, logoPath: logoPath, city: city, address: address, latitude: latitude, longitude: longitude, parties: parties)
    }    
    
    init(uid: String?, name: String, logoPath: String, city: String, address: String, latitude: String, longitude: String, parties: [Party]?)
    {
        // stored
        _uid = uid
        _name = name
        _logoPath = logoPath
        _city = city
        _address  = address
        _latitude = latitude
        _longitude = longitude
        _parties = parties
        
        // temporal
        _logoURL = NSURL(string: _logoPath)!
        _location = CLLocation(latitude: Double(_latitude)!, longitude: Double(_longitude)!)
    }
    
    // ****************************** //
    // MARK: Utils
    // ****************************** //

    func toJSON() -> Dictionary<String, AnyObject>
    {
        var jsonParties = [AnyObject]()
        if let parties = _parties {
            for party in parties {
                jsonParties.append(party.toJSON())
            }
        }
        return ["name": _name, "logoPath": _logoPath, "city": _city, "address": _address, "latitude": _latitude, "longitude": _longitude, "parties": jsonParties]
    }

}