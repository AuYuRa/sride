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
    @IBAction func createRide(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Rides")
        query.includeKey("accountOwner")
        query.limit = 20
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
