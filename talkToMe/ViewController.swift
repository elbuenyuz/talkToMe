//
//  ViewController.swift
//  talkToMe
//
//  Created by Daniel Ramirez on 10/24/16.
//  Copyright © 2016 simpleCoding. All rights reserved.
//


import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField:UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //if already exist we call it and use it
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil{
            //we change the view to the next one
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }
    /*fbBtnPressed loggIn with Facebook, get accesToken and LoggIn with firebase
     */
    @IBAction func fbBtnPressed(sender: UIButton!){
        
        //create faceLogin
        let faceLogin = FBSDKLoginManager()
        
        //login with read permissions
        faceLogin.logInWithReadPermissions(["email"]) { (faceResult,faceError) in
            
            //catch error
            if faceError != nil{
                print("facebook error :\(faceError)")
                
            }else{
                //get sessiontoken
                let accesToken = FBSDKAccessToken.currentAccessToken()
                print("acces token:\(accesToken)")
                
                /*conexion entre firebase y facebook Token*/
                
                //credenciales con el accestoken de facebook
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(accesToken.tokenString)
                //loggInWithCredentials-return USER value
                FIRAuth.auth()?.signInWithCredential(credential, completion: { (user, error) in
                    
                    if error != nil{
                        print("loggin failed, :\(error)")
                        
                    }else{
                        //print user informatin
                        print("user information:\(user?.email), \(user?.displayName), user:\(user)")
                        //save the iser.uid in local memory,we creat it in weD
                        NSUserDefaults.standardUserDefaults().setValue(user?.uid, forKey:"uid")
                        
                        //change view
                        self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                    }
                })//end signinWithCredentials
            }//end else
        }//end logginWithReadPermissions
    }//end fbbtnpressed
    
    
    @IBAction func attemptLogin(sender: UIButton!) {
        
        //let email and let pwd validation
        if let email = emailField.text where email != "",let pwd  = passwordField.text where pwd != "" {
            
            //if this account exist signInWithEmail
            FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: { (firUser, error) in
                print(error?.code)
                print(error)
                
                //if exist an error
                if error != nil{
                    //if error user account doesnt exist
                    if error?.code == STATUS_ACCOUNT_NONEEXIST{
                        
                        //if doesnt exist we create one/
                        FIRAuth.auth()?.createUserWithEmail(email, password: pwd, completion: { (result, error) in
                            
                            //error crearting the account
                            if error != nil{
                                
                                //send alert
                                print("failed creating new user:\(error.debugDescription)")
                                self.showErrorAlert("Could not creat account", msg: "there was a problem creating the account please try later")
                            }else{
                                
                                //Saved the user to the local memory
                                NSUserDefaults.standardUserDefaults().setValue(result?.uid, forKey: KEY_UID)
                                //SignInWithEmail we are sure this exist
                                FIRAuth.auth()?.signInWithEmail(email, password: pwd, completion: nil)
                                
                                //send next View
                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                                print("loggedIn :)")
                            }
                        })
                    //if error pwd and user invalids
                    } else if error?.code == STATUS_PWD_USER_INVALID{
                        self.showErrorAlert("Could not login", msg: "Please check your username or password")
                    
                    //if bad email format
                    } else if error?.code == STATUS_BAD_EMAIL_FORMAT{
                        self.showErrorAlert("Could not login", msg: "The format of your Email is invalid.")
                    }
                //if there is no errors, send next view
                } else {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }
            })
            
        } else {
            //if the format of the textfield are not correct
            showErrorAlert("Email and Password Required", msg: "You must enter an Email and a Password")
        }
        
    }
    
    /*
     Alerts func
     */
    //func to create alerts
    func showErrorAlert(title: String, msg: String){
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
}














