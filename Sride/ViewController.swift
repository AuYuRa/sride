//
//  ViewController.swift
//  Sride
//
//  Created by sulagna on 3/22/22.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        loginButton.layer.cornerRadius = 20
        signupButton.layer.cornerRadius = 20
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        usernameField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        // Create a new PFUser object in the server
        let user = PFUser()
        //
        user.username = usernameField.text
        user.password = passwordField.text
        user.signUpInBackground { success, error in
            if success {
                print("Successfully signing up.")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
//            else {
//                print("Error: \(error?.localizedDescription)")
//            }
            else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) { user, error in
            if user != nil {
                print("Successfully signing in")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
}

// dismiss the keyboard when the return key is pressed
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }

}
