# Sride

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Matches people who want to share a ride to the same destination

### App Evaluation
- **Category:** Transportation
- **Mobile:** Mobile only
- **Story:** User can post ride requests and available rides on feed.
- **Market:** For college students to be able to find rides easier
- **Habit:** The app can be useful for low income student to find ride partners in the same college/area, also can find rides from the person who are not professional uber/lyft driver and want to give a ride
- **Scope:** First, people who want to share / want/give a ride post there rides in the app. So that people can find the contact each other and share there rides!

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can sign up for account
* User can log into access common feed/ log out
* User can create new ride-post
* User can input information about the ride in a screen
* User can use tab bar to see who want a ride/ share a ride/ give a ride
* Users can add comments
* User can click on a post and see the detailed view

**Optional Nice-to-have Stories**

* Users can chat
* Users can upvote (review/rating)
* User can search using a keyword

### 2. Screen Archetypes

* Login Screen
   * User can log in 


* Feed Screen
    * User can scroll through ride share posts
    * Optional : posts will have a color tint based on the type of post.


* Detail screen
   * Read full post
   * See all comments


* Create post screen
   * User can insert **text** in the text box
   * User can set the **category** of their post: share ride (using a third-party vehicle like Uber), offer ride (using the user's vehicle), or request ride (using the request accepter's vehicle)
   * User can set the **date** and **time** for the ride
   * User can set the **departure point** and **destination** of the ride
   * User can share their **urgency**
   * User can share their **accompany**
   * User can share their **contact** to discuss
   * User can comment and reply to comment on any post


* Profile screen
   * User can log out
   * User can see their post history
   * Optional: Notifications (someone comments on the user's post or the post that the user turns on their notifications for, someone replies to the user's comment)

**Optional**
* Share ride screen
    * Show only the posts under the Share category
* Offer ride screen
    * Show only the posts under the Offer category
* Request ride screen
    * Show only the posts under the Request category

### 3. Navigation

**Tab Navigation** (Tab to Screen)
**Required**
* Latest feeds
* User profile


**Optional**
* Share ride
* Offer Ride
* Request Ride

**Flow Navigation** (Screen to Screen)

* Login Screen
   * Login Screen -> Feed Screen
* Feed Screen
   * Feed Screen -> Create Ride
   * Feed Screen -> Profile Screen

## Wireframes
<img src="https://i.imgur.com/BSzOmwA.jpg">

## Schema 
[This section will be completed in Unit 9]
## Schema 
### Models
#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | destination   | String    | destination of the ride |
   | departure     | String   | departure location of the ride |
   | commentsCount | Number   | number of comments that has been posted to an image |
   | dateOfRide     | DateTime | date when the user wants to get a ride |
   | createdAt     | DateTime  | date when the post is created|
   | updatedAt     | DateTime | date when post is last updated (default field) |
   | share         | Bool     | if the user is sharing the ride |
   | offer         | Bool     | if the user is offering the ride |
   | request       | Bool     | if the user is requesting the ride |
   | numberOfPeople | int | the number of people request/share/can be offered the ride |
   

### Networking


#### List of network requests by screen
   - Feed Screen
      - (Read/GET) Query all posts
```swift
let query = PFQuery(className:"Post")
query.order(byDescending: "dateOfRide")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
if let error = error { 
   print(error.localizedDescription)
    } else if let posts = posts {
   print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
```
     
- (Create/POST) Create a new comment on a post
      
```swift
let comment = PFObject(className: "Comments")
        comment["text"] = "This is a random comment"
        comment["post"] = post
        comment["author"] = PFUser.current()!
        
        post.add(comment, forKey: "comments")
        post.saveInBackground{
            (success, error) in
            if success {
                print("Saved comments")
            } else {
                print("error in saving comments")
            }
        }
```

   - Create Post Screen
      - (Create/POST) Create a new post object
```swift
let post = PFObject(className: "Posts")
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
post.saveInBackground{
            (success,error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            }
            else{
                print("error!")
            }
        }
```
   - Profile Screen
      - (Read/GET) Query logged in user object
    
        
```swift
let query = PFQuery(className:"User")
        query.getObjectInBackground(withId: "") { (user, error) in
            if error == nil {
            // Success!
            } else {
            // Fail!
            }
        }
```
       
