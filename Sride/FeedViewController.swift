//
//  FeedViewController.swift
//  Sride
//
//  Created by sulagna on 3/25/22.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    
    var rides = [PFObject]()
    
    @IBAction func createRide(_ sender: Any) {}
    
    @IBOutlet weak var popupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 15.0, *) {
            popupButton.changesSelectionAsPrimaryAction = true
            popupButton.showsMenuAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
            print("This feature is only available for iOS 15.0")
        }
        
        
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
        
        let optionsClosureRequest = { (action: UIAction) in
            print(action.title)
            let query = PFQuery(className: "Rides")
            query.includeKeys(["accountOwner", "comments", "comments.author"])
            query.order(byDescending: "createdAt")
            query.limit = 20
            query.whereKey("Request", equalTo: true) // -> filter out Share posts
            query.findObjectsInBackground { (rides, error) in
                if rides != nil{
                    self.rides = rides!
                    self.tableView.reloadData()
                }
                
            }
        }
        
        let optionsClosureOffer = { (action: UIAction) in
            print(action.title)
            let query = PFQuery(className: "Rides")
            query.includeKeys(["accountOwner", "comments", "comments.author"])
            query.order(byDescending: "createdAt")
            query.limit = 20
            query.whereKey("Offer", equalTo: true) // -> filter out Share posts
            query.findObjectsInBackground { (rides, error) in
                if rides != nil{
                    self.rides = rides!
                    self.tableView.reloadData()
                }
                
            }
        }
        
        
           popupButton.menu = UIMenu(children: [
             UIAction(title: "All", state: .on, handler: optionsClosure),
             UIAction(title: "Share", handler: optionsClosureShare),
             UIAction(title: "Request", handler: optionsClosureRequest),
             UIAction(title: "Offer", handler: optionsClosureOffer),
           ])
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Rides")
        query.includeKeys(["accountOwner", "comments", "comments.author"])
        query.limit = 20
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (rides, error) in
            if rides != nil{
                self.rides = rides!
                self.tableView.reloadData()
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RideCell") as! RideCell
        let ride = rides[indexPath.row]
        
        let user = ride["accountOwner"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.destinationLabel.text = (ride["Destination"] as! String)
        cell.startLabel.text = (ride["StartingPoint"] as! String)
        cell.dateLabel.text = (ride["DateOfRide"] as! String)
        cell.timeFrameLabel.text = (ride["timeFrame"] as! String)
        cell.nameLabel.text = (ride["Name"] as! String)
        cell.accompanyLabel.text = (ride["Accompany"] as! String)
        cell.contactLabel.text = (ride["Contact"] as! String)
        cell.noteLabel.text = (ride["ExtraNote"] as! String)
        cell.vaccinatedLabel.text = (ride["vaccination"] as! String)
        
        return cell
    }
    

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
