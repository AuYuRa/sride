//
//  UserPostViewController.swift
//  Sride
//
//  Created by Autumn Y Ngoc on 4/1/22.
//

import UIKit
import Parse

class UserPostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RideCell") as! RideCell
        let post = posts[indexPath.row]
        
        let user = post["accountOwner"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.destinationLabel.text = (post["Destination"] as! String)
        cell.startLabel.text = (post["StartingPoint"] as! String)
        cell.dateLabel.text = (post["DateOfRide"] as! String)

        cell.nameLabel.text = (post["Name"] as! String)

        
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
        // query.whereKey("Share", equalTo: true) -> filter out Share posts
        query.limit = 20
        
        query.findObjectsInBackground { posts, error in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DetailView") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let ride = posts[indexPath!.row]

            let detailsViewController = segue.destination as! DetailsViewController

            detailsViewController.ride = ride
        }
    }
     


}
