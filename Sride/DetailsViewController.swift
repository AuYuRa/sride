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
    
    @IBOutlet weak var tableView: UITableView! // the tableView only consists of comments, not the post itself

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
    var showsCommentBar = false

   override func viewDidLoad() {
       super.viewDidLoad()
       
       tableView.delegate = self
       tableView.dataSource = self
       
       tableView.keyboardDismissMode = .interactive
       
       //added this part
       
       let center = NotificationCenter.default
       center.addObserver(self, selector: #selector(keyboardWillbeHidden(note:)), name: UIResponder.keyboardDidHideNotification, object: nil)

       
       commentBar.inputTextView.placeholder = "Add a comment..."
       commentBar.sendButton.title = "Send"
       commentBar.delegate = self
       
       let user = ride!["accountOwner"] as! PFUser
       username.text = user.username
   
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
       
   }
   
   @objc func keyboardWillbeHidden(note: Notification){
       commentBar.inputTextView.text = nil
       showsCommentBar = false
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

        // clear and dismiss
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let comments = (ride?["comments"] as? [PFObject]) ?? []
        switch comments.count == 0 {
            case true:
                return 1 // only one AddComment cell
            case false:
                return comments.count + 1 // the number of existing comments plus the AddComment cell
        }
        
    }
    
    // Rasha: previously there was no didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comments = (ride?["comments"] as? [PFObject]) ?? []
        switch comments.count == 0 {
            case true:
                /// No content
                if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
                return cell
                }
                else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "empty-cell-id") as! EmptyTableViewCell
                return cell
                }
            
            case false:
                /// User cell
                if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
                return cell
                }
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

//extension DetailsViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder() // dismiss keyboard
//        return true
//    }
//}

