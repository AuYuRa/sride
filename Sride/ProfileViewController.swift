//
//  ProfileViewController.swift
//  Sride
//
//  Created by sulagna on 3/25/22.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var myPostButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
        var currentUser = PFUser.current() // assigning the current PFUser to a variable

    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("ProfileTab viewDidLoad()")

        // Do any additional setup after loading the view.
        
        usernameLabel.text = currentUser?.username // Display the username of the currently logged in user
        
        myPostButton.layer.cornerRadius = 4.0
        
        // Consider letting the user upload their profile picture
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        // After logging out, the user will be returned to the initial login screen
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
    }
}
