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
        
        // for iMac, change from iOS 15.0 to a lower version
        if #available(iOS 15.0, *) {
            
            popupButton.changesSelectionAsPrimaryAction = true // for iMac, comment this line out
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
        
        cell.dateLabel.backgroundColor = UIColor.white
        //cell.dateLabel.layer.masksToBounds = true
        cell.dateLabel.layer.cornerRadius = 20.0
        
        //cell.timeFrameLabel.text = (ride["timeFrame"] as! String)
        cell.nameLabel.text = (ride["Name"] as! String)
        cell.nameLabel.backgroundColor = UIColor.white
        //cell.dateLabel.layer.masksToBounds = true
        cell.nameLabel.layer.cornerRadius = 20.0
        
    
        
        
//        cell.startLabel.layer.borderWidth = 2.0
//        cell.startLabel.layer.borderColor = UIColor.init(red: 1, green: 213/255, blue: 248/255, alpha: 1).cgColor
//        cell.startLabel.layer.cornerRadius = 10
//
//        cell.destinationLabel.layer.borderWidth = 2.0
//        cell.destinationLabel.layer.borderColor = UIColor.init(red: 1, green: 213/255, blue: 248/255, alpha: 1).cgColor
//        cell.destinationLabel.layer.cornerRadius = 10
        
        cell.shareLabel.textColor = UIColor.clear
        cell.offerLabel.textColor = UIColor.clear
        cell.requestLabel.textColor = UIColor.clear
        
        cell.shareLabel.layer.borderColor = UIColor.clear.cgColor
        cell.requestLabel.layer.borderColor = UIColor.clear.cgColor
        cell.offerLabel.layer.borderColor = UIColor.clear.cgColor
        
        cell.shareLabel.backgroundColor = UIColor.clear
        cell.requestLabel.backgroundColor = UIColor.clear
        cell.offerLabel.backgroundColor = UIColor.clear
        

        

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
            //cell.offerLabel.backgroundColor = UIColor.green
            cell.offerLabel.backgroundColor = UIColor.init(red: 193/255, green: 255/255, blue: 220, alpha: 0.75)
            cell.offerLabel.layer.borderWidth = 1.0
            cell.offerLabel.textColor = UIColor.black
            cell.offerLabel.layer.cornerRadius = 10
            cell.offerLabel.layer.borderColor = UIColor.systemIndigo.cgColor

        }
        

        
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
