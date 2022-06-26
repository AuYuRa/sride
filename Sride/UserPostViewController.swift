//
//  UserPostViewController.swift
//  Sride
//
//  Created by Autumn Y Ngoc on 4/1/22.
//

import UIKit
import Parse

// Similar to the DetailsViewController
class UserPostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var rides = [PFObject]()
    
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
        cell.nameLabel.text = (ride["Name"] as! String)
        
        cell.dateLabel.backgroundColor = UIColor.white
        cell.dateLabel.layer.cornerRadius = 20.0

        cell.nameLabel.backgroundColor = UIColor.white
        cell.nameLabel.layer.cornerRadius = 20.0

        //layout of share/offer/request textbox in post to hide textbox initially
        cell.shareLabel.textColor = UIColor.clear
        cell.offerLabel.textColor = UIColor.clear
        cell.requestLabel.textColor = UIColor.clear

        cell.shareLabel.layer.borderColor = UIColor.clear.cgColor
        cell.requestLabel.layer.borderColor = UIColor.clear.cgColor
        cell.offerLabel.layer.borderColor = UIColor.clear.cgColor

        cell.shareLabel.backgroundColor = UIColor.clear
        cell.requestLabel.backgroundColor = UIColor.clear
        cell.offerLabel.backgroundColor = UIColor.clear

        // Layout of the textbox for the ride characteristic (Share/Request/Offer) to show textbox if characteristic is true
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


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

  //       Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Rides")
        query.includeKeys(["accountOwner", "comments", "comments.author"])
        // Only query post made by the current user
        query.whereKey("accountOwner", equalTo: PFUser.current()!)
        query.order(byDescending: "createdAt")
        query.limit = 20
        
        query.findObjectsInBackground { rides, error in
            if rides != nil {
                self.rides = rides!
                self.tableView.reloadData()
            }
        }
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
