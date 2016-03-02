//
//  Session.swift
//  Tonight
//
//  Created by Marsal on 29/02/16.
//  Copyright © 2016 Marsal Silveira. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit

// ****************************** //
// MARK: User
// ****************************** //

struct User
{
    // ****************************** //
    // MARK: Properties
    // ****************************** //

    private var _uid: String?
    var uid: String? {
        return _uid
    }

    private var _provider: String
    var provider: String {
        return _provider
    }

    private var _name: String
    var name: String {
        return _name
    }

    private var _email: String
    var email: String {
        return _email
    }

    // ****************************** //
    // MARK: Init
    // ****************************** //
    
    init(provider: String, name: String, email: String)
    {
        self.init(uid: nil, provider: provider, name: name, email: email)
    }
    
    init(uid: String?, provider: String, name: String, email: String)
    {
        _uid = uid
        _provider = provider
        _name = name
        _email = email
    }
    
    // ****************************** //
    // MARK: Utils
    // ****************************** //

    // return user record in JSON format excluding uid field
    func toJSON() -> Dictionary<String, AnyObject>
    {
        return ["provider": _provider, "name": _name, "email": _email]
    }
}

// ****************************** //
// MARK: Session
// ****************************** //

class Session
{
    // ****************************** //
    // MARK: Singleton
    // ****************************** //
    
    private static let singleton = Session()
    static func sharedInstance() -> Session
    {
        return singleton
    }
    
    // this must be private to avoid init without using singleton way
    private init()
    {
        // do nothing
    }
    
    // ****************************** //
    // MARK: Properties
    // ****************************** //
    
    private var _user: User?
    var user: User? {
        return _user
    }
    
    // ******************************************** //
    // MARK: Session Control
    // ******************************************** //
    
    func doLoginWithEmail(email: String, andPassword password: String, withCompletionBlock completionBlock: ((logged: Bool, message: String) -> Void))
    {
        // only continue if uer has all is properties
        if (email != "") && (password != "") {
            
            // Login with the Firebase's authUser method
            FirebaseApp.sharedInstance().authUser(email, password: password, withCompletionBlock: { error, authData in

                // if has some error return false and show a message to user
                if (error != nil) {
                    // print error and call completion block with result values
                    print("Error signing. \(error)")
                    completionBlock(logged: false, message: "Check your email and password.")
                }
                else {
                    // get logged user and store it (uid) into UserDefauts
                    self._user = User(uid: authData.uid, provider: authData.provider, name: "", email: email)
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    // print error and call completion block with result values
                    print("Logged in '\(authData.provider)' with '\(authData)'")
                    completionBlock(logged: true, message: "Logged in '\(authData.provider)' with '\(authData)'")
                }
            })
        }
        else {
            // call completion block with result values
            completionBlock(logged: false, message: "Don't forget to enter your email and password.")
        }
    }
    
    func doLoginWithFacebookFromViewController(viewController: UIViewController, completionBlock: ((logged: Bool, message: String) -> Void))
    {
        FBSDKLoginManager().logInWithReadPermissions(["email"], fromViewController: viewController, handler: { (facebookResult, facebookError) -> Void in
            
            if (facebookError != nil) {
                // print error and call completion block with result values
                print("Facebook login failed. Error \(facebookError)")
                completionBlock(logged: false, message: "Facebook login failed. Error \(facebookError)")
            }
            else if facebookResult.isCancelled {
                // print error and call completion block with result values
                print("Facebook login was cancelled.")
                completionBlock(logged: false, message: "Facebook login was cancelled.")
            }
            else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                FirebaseApp.sharedInstance().authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    
                    if (error != nil) {
                        // print error and call completion block with result values
                        print("Login failed. \(error)")
                        completionBlock(logged: false, message: "Facebook login failed. Error \(error)")
                    }
                    else {
                        // get logged user and store it (uid) into UserDefauts
                        self._user = User(uid: authData.uid, provider: authData.provider, name: "", email: "")
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                        
                        // print error and call completion block with result values
                        print("Logged in '\(authData.provider)' with '\(authData)'")
                        completionBlock(logged: true, message: "Logged in '\(authData.provider)' with '\(authData)'")
                    }
                })
            }
        })
    }
    
    func doLogout()
    {
        //unath user and remove it from user dafaults (uid)
        FirebaseApp.sharedInstance().unauthUser()
        _user = nil
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
    }
    
    func doSignUpWithName(name: String, email: String, andPassword password: String, withCompletionBlock completionBlock: ((logged: Bool, message: String) -> Void))
    {
        // only continue if uer has all is properties
        if (name != "") && (email != "") && (password != "") {
            
            // Set Email and Password for the New User.
            FirebaseApp.sharedInstance().createUser(email, password: password, withValueCompletionBlock: { error, result in
                
                // if has some error return false and show a message to user
                if (error != nil) {
                    // print error and call completion block with result values
                    print("Error creating new user. \(error)")
                    completionBlock(logged: false, message: "Having some trouble creating your account. Try again.")
                }
                else {
                    // exec sign in and return result
                    self.doLoginWithEmail(email, andPassword: password, withCompletionBlock: { logged, message in
                        
                        // if logged create user at Firebase
                        if (logged) {
                            FirebaseApp.sharedInstance().insertUser(self._user!)
                        }
                        completionBlock(logged: logged, message: message)
                    })
                }
            })
        } else {
            // call completion block with result values
            completionBlock(logged: false, message: "Don't forget to enter your name, email and password.")
        }
    }
    
    func restorePreviousSession() -> Bool
    {
        // check if has a previous user stored and try restore its session...
        if let authData = FirebaseApp.sharedInstance().restorePreviousSession() {
            _user = User(uid: authData.uid, provider: authData.provider, name: "", email: "")
            print("Logged in '\(authData.provider)' with '\(authData)'")
            return true
        }
        return false
    }
    
}