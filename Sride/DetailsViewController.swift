//
//  DetailsViewController.swift
//  Sride
//
//  Created by sulagna on 3/25/22.
//

import UIKit
import Parse
import MessageInputBar

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    // the tableView in the DetailsViewController only consists of comments, not the details of the post

    var ride: PFObject?

   @IBOutlet weak var username: UILabel!
   @IBOutlet weak var start: UILabel!
   @IBOutlet weak var destination: UILabel!
   @IBOutlet weak var vaccination: UILabel!
   @IBOutlet weak var extra: UILabel!
   @IBOutlet weak var name: UILabel!
   @IBOutlet weak var date: UILabel!
   @IBOutlet weak var timeframe: UILabel!
   @IBOutlet weak var accompany: UILabel!
   @IBOutlet weak var contact: UILabel!
   @IBOutlet weak var sharing: UILabel!
   @IBOutlet weak var offering: UILabel!
   @IBOutlet weak var requesting: UILabel!

    let commentBar = MessageInputBar()
    var showsCommentBar = false // Not show the comment

   override func viewDidLoad() {
       super.viewDidLoad()
       
       tableView.delegate = self
       tableView.dataSource = self
       
       // make the keyboard follow the drag of our finger
       tableView.keyboardDismissMode = .interactive // This line of code should be written prior to configurating anything in viewDidLoad(). The keyboard won't appear when we attempt to write comment otherwise.
       
       let user = ride!["accountOwner"] as! PFUser
       username.text = user.username
   
       // Layout of the details of the post
       destination.text = (ride?["Destination"] as! String)
       start.text = (ride?["StartingPoint"] as! String)
       date.text = (ride?["DateOfRide"] as! String)
       timeframe.text = (ride?["timeFrame"] as! String)
       name.text = (ride?["Name"] as! String)
       accompany.text = (ride?["Accompany"] as! String)
       contact.text = (ride?["Contact"] as! String)
       extra.text = (ride?["ExtraNote"] as! String)
       vaccination.text = (ride?["vaccination"] as! String)
       sharing.textColor = UIColor.clear
       requesting.textColor = UIColor.clear
       offering.textColor = UIColor.clear
       
       
    // Layout of the textbox for the ride characteristic (Share/Request/Offer)
       
    if ride?["Share"] as! Bool {

        sharing.layer.borderWidth = 1.0
        sharing.layer.borderColor = UIColor.systemIndigo.cgColor
        sharing.layer.cornerRadius = 10
        sharing.textColor = UIColor.black
        
        }
    if ride?["Request"] as! Bool {

        
        requesting.layer.borderWidth = 1.0
        requesting.layer.borderColor = UIColor.systemIndigo.cgColor
        requesting.layer.cornerRadius = 10
        requesting.textColor = UIColor.black
        
        }
    if ride?["Offer"] as! Bool {

        
        offering.layer.borderWidth = 1.0
        offering.layer.borderColor = UIColor.systemIndigo.cgColor
        offering.layer.cornerRadius = 10
        offering.textColor = UIColor.black
        
        }
       
       
       
       let center = NotificationCenter.default
       // Observing an event in the Notification Center.
       // When that event happens, call the selector where the observer is
       // The event is keyboardWillHideNotification, which is when the keyboard is going to be dismissed
       // In this case, the observer is self - the DetailsViewController
       // The selector is the keyboardDidHideNotification function we define below
       
       center.addObserver(self, selector: #selector(keyboardWillbeHidden(note:)), name: UIResponder.keyboardDidHideNotification, object: nil)

       // the default text in the comment bar when there's no text
       commentBar.inputTextView.placeholder = "Add a comment..."
       commentBar.sendButton.title = "Send"
       commentBar.delegate = self
       
   }
   
   @objc func keyboardWillbeHidden(note: Notification){
       commentBar.inputTextView.text = nil // Clear the text in the comment bar
       showsCommentBar = false // Comment bar will be dismissed
       becomeFirstResponder()
   }

    override var inputAccessoryView: UIView?{
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool{
        return showsCommentBar
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {

        let comment = PFObject(className: "Comments")

        // Save the information about the comment in the backend
        comment["text"] = text
        comment["ride"] = ride
        comment["author"] = PFUser.current()!
        
        // Add this comment to an array named "comments" belonged to the selected ride
        ride!.add(comment, forKey: "comments")
        
        // When the post is saved, the comment added to that post will also be saved
        ride!.saveInBackground() {(success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error saving comment")
            }
        }
        tableView.reloadData()

        // clear the comment bar and dismiss
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let comments = (ride?["comments"] as? [PFObject]) ?? []
        switch comments.count == 0 {
            case true: // If the post hasn't had any comment
                return 1 // only one row for the AddComment cell
            
            case false: // If the post has had one or more comments
                return comments.count + 1 // the number of rows in the table view is the sum of the existing comments plus one AddComment cell
        }
        
    }
    
    // Rasha: previously there was no didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // The first row will be the AddComment bar
        if indexPath.row == 0 {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comments = (ride?["comments"] as? [PFObject]) ?? []
        switch comments.count == 0 {
            // When there is no comment
            case true:
                // No content
            // The first row will be the AddComment cell
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
                    return cell
                }
            // Other rows will be empty cells initially
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "empty-cell-id") as! EmptyTableViewCell
                    return cell
                }
            
            // When there is one or more comments
            case false:
            // The first row will still be the AddComment cell
                if indexPath.row == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
                    return cell
                }
            
            // Configure the following rows to be the comments created previously
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
                    let comment = comments[indexPath.row-1]
                    cell.commentLabel.text = (comment["text"] as! String)
                    let user = comment["author"] as! PFUser
                    cell.nameLabel.text = user.username
                    return cell
                }
            }
    }
 
}

