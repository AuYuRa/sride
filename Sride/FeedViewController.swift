//
//  FeedViewController.swift
//  Sride
//
//  Created by sulagna on 3/25/22.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView! // Create a table view
    
    var rides = [PFObject]() // Create an array of PFObjects to store the ride posts, and assign it to a variable named rides
    
    
    @IBAction func createRide(_ sender: Any) {} // NOTE
    
    @IBOutlet weak var popupButton: UIButton! // Create the popupButton on the screen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // for older XCode versions, change from iOS 15.0 to a lower version
        if #available(iOS 15.2, *) {
            
            popupButton.changesSelectionAsPrimaryAction = true // for older XCode versions, comment this line out
            popupButton.showsMenuAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
            print("This feature is only available for iOS 15.0")
        }
        
        // Execute this handler when the user clicks "All" in the Filter button
        let optionsClosure = { (action: UIAction) in
            print(action.title)
            let query = PFQuery(className: "Rides")
            query.includeKeys(["accountOwner", "comments", "comments.author"])
            query.order(byDescending: "createdAt")
            query.limit = 20
            query.findObjectsInBackground { (rides, error) in
                if rides != nil{
                    self.rides = rides!
                    self.tableView.reloadData()
                }

            }
        }
        
        // Execute this handler when the user clicks "Share" in the Filter button
        let optionsClosureShare = { (action: UIAction) in
            print(action.title)
            let query = PFQuery(className: "Rides")
            query.includeKeys(["accountOwner", "comments", "comments.author"])
            query.order(byDescending: "createdAt")
            query.limit = 20
            query.whereKey("Share", equalTo: true) // -> filter out Share posts
            query.findObjectsInBackground { (rides, error) in
                if rides != nil{
                    self.rides = rides!
                    self.tableView.reloadData()
                }
                
            }
        }
        
        // Execute this handler when the user clicks "Request" in the Filter button
        let optionsClosureRequest = { (action: UIAction) in
            print(action.title)
            let query = PFQuery(className: "Rides")
            query.includeKeys(["accountOwner", "comments", "comments.author"])
            query.order(byDescending: "createdAt")
            query.limit = 20
            query.whereKey("Request", equalTo: true) // -> filter out Request posts
            query.findObjectsInBackground { (rides, error) in
                if rides != nil{
                    self.rides = rides!
                    self.tableView.reloadData()
                }
                
            }
        }
        
        // Execute this handler when the user clicks "Offer" in the Filter button
        let optionsClosureOffer = { (action: UIAction) in
            print(action.title)
            let query = PFQuery(className: "Rides")
            query.includeKeys(["accountOwner", "comments", "comments.author"])
            query.order(byDescending: "createdAt")
            query.limit = 20
            query.whereKey("Offer", equalTo: true) // -> filter out Offer posts
            query.findObjectsInBackground { (rides, error) in
                if rides != nil{
                    self.rides = rides!
                    self.tableView.reloadData()
                }
                
            }
        }
        
        // Create four different options in the pop-up button
       popupButton.menu = UIMenu(children: [
         UIAction(title: "All", state: .on, handler: optionsClosure), // The default option
         UIAction(title: "Share", handler: optionsClosureShare),
         UIAction(title: "Request", handler: optionsClosureRequest),
         UIAction(title: "Offer", handler: optionsClosureOffer),
       ])
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // After the view is loaded, query the ride objects from the class Rides
        let query = PFQuery(className: "Rides")
        query.includeKeys(["accountOwner", "comments", "comments.author"]) // Query the PFObjects that have their reference keys
        query.limit = 20 // Limit the number of objects returned at a time
        query.order(byDescending: "createdAt") // Sort the most recently created posts first
        query.findObjectsInBackground { (rides, error) in
            if rides != nil{
                self.rides = rides! // Load the data queried to the tableView
                self.tableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RideCell") as! RideCell
        let ride = rides[indexPath.row] // Access a specific object in each row
        let user = ride["accountOwner"] as! PFUser
        
        // Fetching data from backend
        cell.usernameLabel.text = user.username
        cell.destinationLabel.text = (ride["Destination"] as! String)
        cell.startLabel.text = (ride["StartingPoint"] as! String)
        cell.nameLabel.text = (ride["Name"] as! String)
        cell.dateLabel.text = (ride["DateOfRide"] as! String)
        
        //Cell layout and color
        cell.dateLabel.backgroundColor = UIColor.white
        cell.dateLabel.layer.cornerRadius = 20.0

        cell.nameLabel.backgroundColor = UIColor.white
        cell.nameLabel.layer.cornerRadius = 20.0

        cell.shareLabel.textColor = UIColor.clear
        cell.shareLabel.layer.borderColor = UIColor.clear.cgColor
        cell.shareLabel.backgroundColor = UIColor.clear

        cell.offerLabel.textColor = UIColor.clear
        cell.offerLabel.layer.borderColor = UIColor.clear.cgColor
        cell.offerLabel.backgroundColor = UIColor.clear
        
        cell.requestLabel.textColor = UIColor.clear
        cell.requestLabel.layer.borderColor = UIColor.clear.cgColor
        cell.requestLabel.backgroundColor = UIColor.clear
        
        // cell layout and color change to signify type of post (share/request/offer)
        if ride["Share"] as! Bool{
            cell.shareLabel.backgroundColor = UIColor.init(red: 193/255, green: 255/255, blue: 220, alpha: 0.75)
            cell.shareLabel.layer.borderWidth = 1.0
            cell.shareLabel.layer.borderColor = UIColor.systemIndigo.cgColor
            cell.shareLabel.layer.cornerRadius = 10
            cell.shareLabel.textColor = UIColor.black

        }
        if ride["Request"] as! Bool{
            cell.requestLabel.backgroundColor = UIColor.init(red: 193/255, green: 255/255, blue: 220, alpha: 0.75)
            cell.requestLabel.layer.borderWidth = 1.0
            cell.requestLabel.layer.borderColor = UIColor.systemIndigo.cgColor
            cell.requestLabel.layer.cornerRadius = 10
            cell.requestLabel.textColor = UIColor.black

        }
        if ride["Offer"] as! Bool{
            cell.offerLabel.backgroundColor = UIColor.init(red: 193/255, green: 255/255, blue: 220, alpha: 0.75)
            cell.offerLabel.layer.borderWidth = 1.0
            cell.offerLabel.textColor = UIColor.black
            cell.offerLabel.layer.cornerRadius = 10
            cell.offerLabel.layer.borderColor = UIColor.systemIndigo.cgColor

        }
        return cell
    }
    
    //connect to detail view controller with segue.identifier when cell is clicked
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DetailView") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let ride = rides[indexPath!.row]
            let detailsViewController = segue.destination as! DetailsViewController
            detailsViewController.ride = ride
        }
    }

}
