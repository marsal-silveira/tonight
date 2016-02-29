//
//  MainTabBarController.swift
//  Tonight
//
//  Created by Marsal on 28/02/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    //    @IBOutlet weak var theLabel: UILabel!
    
    var manager:CLLocationManager!
    var myLocations: [CLLocation] = []
    
    override func viewDidAppear(animated: Bool)
    {
        let casa = CLLocation(latitude: -27.68752305, longitude: -48.66092563)
//        let pinheira = CLLocation(latitude: -27.88682843, longitude: -48.58707637)
        
        super.viewDidAppear(animated)
        //        self.calculateDistance()
        
        self.centerMapOnLocation(casa)
    }
    
    //    let regionRadius: CLLocationDistance = 1000
    let regionRadius: CLLocationDistance = 500
    func centerMapOnLocation(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    //    func degreesToRadians(degrees: Double) -> Double { return degrees * M_PI / 180.0 }
    //    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / M_PI }
    //
    //    func getBearingBetweenTwoPoints1(point1 : CLLocation, point2 : CLLocation) -> Double {
    //
    //        let lat1 = degreesToRadians(point1.coordinate.latitude)
    //        let lon1 = degreesToRadians(point1.coordinate.longitude)
    //
    //        let lat2 = degreesToRadians(point2.coordinate.latitude);
    //        let lon2 = degreesToRadians(point2.coordinate.longitude);
    //
    //        let dLon = lon2 - lon1;
    //
    //        let y = sin(dLon) * cos(lat2);
    //        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
    //        let radiansBearing = atan2(y, x);
    //
    //        return radiansToDegrees(radiansBearing)
    //    }
    
    func calculateDistance()
    {
        let userLocation:CLLocation = CLLocation(latitude: -27.88682843, longitude: -48.58707637)
        let priceLocation:CLLocation = CLLocation(latitude: -27.88480855, longitude: -48.58709782)
        let distanceBetween:CLLocationDistance = userLocation.distanceFromLocation(priceLocation)
        print("\(distanceBetween)")
        print("\(String(format: "%.2f", distanceBetween))")
        //        float fKiloMeters = meters/1000;
        
        //Distance in Meters
        //1 meter == 100 centimeter
        //1 meter == 3.280 feet
        //1 square meter == 10.76 square feet
    }
    
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        //Setup our Location Manager
    //        manager = CLLocationManager()
    //        manager.delegate = self
    //        manager.desiredAccuracy = kCLLocationAccuracyBest
    //        manager.requestAlwaysAuthorization()
    //        manager.startUpdatingLocation()
    //
    //        //Setup our Map View
    //        mapView.delegate = self
    //        mapView.mapType = MKMapType.Satellite
    //        mapView.showsUserLocation = true
    //    }
    
    //    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject])
    //    {
    ////        theLabel.text = "\(locations[0])"
    //        myLocations.append(locations[0] as! CLLocation)
    //
    //        let spanX = 0.007
    //        let spanY = 0.007
    //        let newRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
    //        mapView.setRegion(newRegion, animated: true)
    //
    //        if (myLocations.count > 1){
    //            let sourceIndex = myLocations.count - 1
    //            let destinationIndex = myLocations.count - 2
    //
    //            let c1 = myLocations[sourceIndex].coordinate
    //            let c2 = myLocations[destinationIndex].coordinate
    //            var a = [c1, c2]
    //            let polyline = MKPolyline(coordinates: &a, count: a.count)
    //            mapView.addOverlay(polyline)
    //        }
    //    }
    //
    //    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer
    //    {
    ////        if overlay is MKPolyline {
    //            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
    //            polylineRenderer.strokeColor = UIColor.blueColor()
    //            polylineRenderer.lineWidth = 4
    //            return polylineRenderer
    ////        }
    ////        return nil
    //    }
}