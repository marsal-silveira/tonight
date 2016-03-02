//
//  FirebaseApp.swift
//  Tonight
//
//  Created by Marsal on 29/02/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import Firebase

struct FirebaseApp
{
    // ****************************** //
    // MARK: Singleton
    // ****************************** //
    
    private static let singleton = FirebaseApp()
    static func sharedInstance() -> FirebaseApp
    {
        return singleton
    }
    
    // this must be private to avoid init it without using singleton way
    private init() { }
    
    // ****************************** //
    // MARK: Firebase References
    // ****************************** //
    
    private static let BASE_URL = "https://tonight-mps.firebaseio.com"
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    
    var _CURRENT_USER_REF: Firebase {
        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        return Firebase(url: "\(_USER_REF)").childByAppendingPath(userID)
    }
    
    // ****************************** //
    // MARK: User
    // ****************************** //
    
    func authUser(email: String!, password: String!, withCompletionBlock block: ((NSError!, FAuthData!) -> Void)!)
    {
        _BASE_REF.authUser(email, password: password, withCompletionBlock: block);
    }
    
    func authWithOAuthProvider(provider: String!, token oauthToken: String!, withCompletionBlock block: ((NSError!, FAuthData!) -> Void)!)
    {
        _BASE_REF.authWithOAuthProvider(provider, token: oauthToken, withCompletionBlock: block)
    }
    
    func unauthUser()
    {
        // unauth() is the logout method for the current user.
        _CURRENT_USER_REF.unauth()
    }
    
    func restorePreviousSession() -> FAuthData!
    {
        // If we have the uid stored, the user is already logger in - no need to sign in again!
        var result: FAuthData! = nil
        if (NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil) {
            result = _CURRENT_USER_REF.authData
        }
        return result
    }
    
    func createUser(email: String!, password: String!, withValueCompletionBlock block: ((NSError!, [NSObject : AnyObject]!) -> Void)!)
    {
        _BASE_REF.createUser(email, password: password, withValueCompletionBlock: block)
    }
    
    func insertUser(user: User)
    {
        _USER_REF.childByAppendingPath(user.uid).setValue(user.toJSON())
    }

    // ****************************** //
    // MARK: Club
    // ****************************** //
    
    private var _CLUB_REF = Firebase(url: "\(BASE_URL)/clubs")
    var CLUB_REF: Firebase {
        return _CLUB_REF
    }
    
    func insertClub(club: Club)
    {
        // only continue if club has all required properties
        if (club.name != "") {
            
            // childByAutoId() saves the joke and gives it its own ID... setValue() saves to Firebase.
            let newRef = FirebaseApp.sharedInstance().CLUB_REF.childByAutoId()
            newRef.setValue(club.toJSON())
        }
    }
    
    func fechtClubsFromServerFromCity(city: String, completionBlock: ((clubs: [Club]) -> Void))
    {
        //
        _CLUB_REF.queryOrderedByChild("city").queryEqualToValue(city).observeEventType(.Value, withBlock: { snapshot in
            
            // The snapshot is a current look at our clubs data
//            print(snapshot.value)
            
            var result = [Club]()
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                for snap in snapshots {
                    
                    if let properties = snap.value as? Dictionary<String, AnyObject> {
                        let name = properties["name"] as! String
                        let logoPath = properties["logoPath"] as! String
                        let city = properties["city"] as! String
                        let address = properties["address"] as! String
                        let latitude = properties["latitude"] as! String
                        let longitude = properties["longitude"] as! String
                        let parties = properties["parties"] as? [Party]
                        let club = Club(uid: snap.key, name: name, logoPath: logoPath, city: city, address: address, latitude: latitude, longitude: longitude, parties: parties)
                        
                        // Items are returned chronologically, but it's more fun with the newest clubs first.
                        result.insert(club, atIndex: 0)
                    }
                }
            }
            
            // finally call completionBlock passing result clubs
            completionBlock(clubs: result)
        })
    }

    func populateFirebase()
    {
        var club: Club
        var parties: [Party]! = nil
        
        // populate 3 times the same records
        for _ in 1...3 {
            
            // Palhoça
            parties = nil
            //        parties = [Party(title: "Sonido Club #1", description: "Rock a 4 mãos e 4 pés", date: "03/03/2016", price:  "R$ 10,00"),
            //                  Party(title: "Groove de Cajon", description: "Rock e Reggae para todos os gostos", date: "04/03/2016", price: "R$5,00")]
            club = Club(
                name: "The Liffey Brew Pub",
                logoPath: "http://www.liffeypub.com.br/img/assets/the-liffey-brew-pub.png",
                city: "Palhoça",
                address: "Rua da Universidade, Loja 27, Passeio Pedra Branca, Palhoça - SC",
                latitude: "-27.6230369",
                longitude: "-48.6786597",
                parties: parties)
            FirebaseApp.sharedInstance().insertClub(club)
            
            parties = nil
            club = Club(
                name: "Bendito Boteco",
                logoPath: "http://palhocense.com.br/polopoly_fs/1.1861671.1450359926!/imagens/14503598464547.jpg",
                city: "Palhoça",
                address:  "Avenida Prefeito Nelson Martins, 129 - Centro, Palhoça",
                latitude: "-27.6558741",
                longitude: "-48.6745999",
                parties: parties)
            FirebaseApp.sharedInstance().insertClub(club)
            
            
            // Santo Amaro
            parties = nil
            //        parties = [Party(title: "Lord Dan", description: "Lord Dan Dubbel, Totalmente Faixa Preta", date: "02/03/2016", price: "R$ 5,00")]
            club = Club(
                name: "Cervejaria Faixa Preta",
                logoPath: "http://blackled.com.br/wp-content/uploads/2015/09/400.jpg",
                city: "Santo Amaro da Imperatriz",
                address:  "Vila Becker, Santo Amaro da Imperatriz - SC",
                latitude: "-27.6788686",
                longitude: "-48.7512173",
                parties: parties)
            FirebaseApp.sharedInstance().insertClub(club)
            
            parties = nil
            club = Club(
                name: "Cervejaria Badenia",
                logoPath: "http://www.greifenbier.com.br/fotos_header/logo_badenia_rund.png",
                city: "Santo Amaro da Imperatriz",
                address:  "R. Intendente Broering, 3479 - Vila Becker, Santo Amaro da Imperatriz - SC",
                latitude: "-27.6825792",
                longitude: "-48.7578981",
                parties: parties)
            FirebaseApp.sharedInstance().insertClub(club)
        }
    }

}