//
//  CreateRideViewController.swift
//  Sride
//
//  Created by sulagna on 3/25/22.
//

import UIKit
import Parse

class CreateRideViewController: UIViewController {
    var share = false
    var request = false
    var offer = false

    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var startingPoint: UITextField!
    @IBOutlet weak var dateofRide: UITextField!
    @IBOutlet weak var timeFrame: UITextField!
    @IBOutlet weak var nameofRider: UITextField!
    @IBOutlet weak var accompany: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var extraNote: UITextField!
    @IBOutlet weak var shareSwitch: UISwitch!
    @IBOutlet weak var requestRide: UISwitch!
    @IBOutlet weak var offerSwitch: UISwitch!
    @IBOutlet weak var vaccination: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let ride = PFObject(className: "Rides")
        
        ride["Destination"] = destination.text!
        ride["StartingPoint"] = startingPoint.text!
        ride["DateOfRide"] = dateofRide.text!
        ride["timeFrame"] = timeFrame.text!
        ride["Name"] = nameofRider.text!
        ride["Accompany"] = accompany.text!
        ride["Contact"] = contact.text!
        ride["ExtraNote"] = extraNote.text!
        ride["Share"] = share
        ride["Request"] = request
        ride["Offer"] = offer
        ride["vaccination"] = vaccination.text
        ride["accountOwner"] = PFUser.current()!
        
        ride.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("Saved!")
            }
            else{
                print("Error")
            }
        }
        
        
    }
    
    @IBAction func shareSwitchFunction(_ sender: UISwitch){

        if shareSwitch.isOn{
            share = true
        }
        else{
            share = false
        }
    }
    
    @IBAction func requestSwitchFunction(_ sender: UISwitch) {
        if requestRide.isOn{
            request = true
        }
        else{
            request = false
        }
    }
    
    
    @IBAction func offerSwitchFunction(_ sender: UISwitch) {
        if offerSwitch.isOn{
            offer = true
        }
        else{
            offer = false
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
