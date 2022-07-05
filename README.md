# Sride

## Table of Contents
1. [Overview](#Overview)
2. [User Stories](#User-Stories)
3. [Screen Archetypes](#Screen-Archetypes)
4. [Navigation](#Navigation)
5. [Wireframes](#Wireframes)
6. [Schema](#Schema)
7. [Sprint 1 Updates](#Sprint-1-Updates)
8. [Sprint 2 Updates](#Sprint-2-Updates)
9. [Sprint 3 Updates](#Sprint-3-Updates)
10. [Final Demo Video](#Final-Demo-Video)


## Overview
### Description
Matches people who want to share a ride to the same destination

### App Evaluation
- **Category:** Social media, transportation
- **Platform:** Mobile (iOS)
- **Story:** User can post ride requests and available rides on feed.
- **Market:** For college students to be able to find rides easier 
- **Habit:** The app can be useful for low income student to find ride partners in the same college/area, also can find rides from the person who are not professional uber/lyft driver and want to give a ride ?(delete)
- **Scope:** First, people who want to share / want/give a ride post there rides in the app. So that people can find the contact each other and share there rides! ?


## User Stories

**Must-have Stories**

- [x] User can sign up
- [x] User can sign in to the feed screen
- [x] User can see posts on the feed screen. The most recent posts will appear first.
- [x] User can click on a post and see the Details view of that post
- [x] Users can see comments and add comments in the Details view
- [x] User can create new posts
- [x] User can navigate between tabs: Main Feed tab, and Profile tab.
- [x] User can see their Profile screen when switching to the Profile tab.
- [x] User can log out from their Profile screen
- [x] User can see the record of their past posts.


**Nice-to-have Stories**
- [x] User can filter out posts based on the ride's characteristic (share, offer, or request).
- [ ] User can search for posts using keyword search bar
- [ ] User can receive in-app and/or mobile notification when people comment on their post or reply to their comments.
- [ ] User can set up their notification setting so that they're notified when there are posts mentioning something they're interested in (e.g. location, date, etc.)
- [ ] User can upvote a post and a user (review/rating)
- [ ] User can chat
- [ ] User can add a profile picture
- [ ] User can see posts on the feed screen in the order of urgency (rides with the date closest to current system date will appear first)
- [x] User can see their new post on the feed screen immediately after creation
- [ ] User can scroll to reload the feed


## Screen Archetypes

* Login Screen
   * User can sign up
   * User can log in 


* Feed Screen
    * User can scroll through all ride share posts
    * (Future step): posts will have a color tint based on the type of post.


* Detail screen
   * Read full post
   * See all comments


* Create post screen
   * User can insert **text** in the text boxs
   * User can set the **category** of their post: share ride (using a third-party vehicle like Uber), offer ride (using the user's vehicle), or request ride (using the request accepter's vehicle)


* Profile screen
   * User can log out
   * User can see the record of their past posts
   * Optional: Notifications (someone comments on the user's post or the post that the user turns on their notifications for, someone replies to the user's comment, someone posts mentioning the user's interests, etc.)


## Navigation

**Tab Navigation** (Tab to Screen)
* Rides Tab -> Feed Screen
* Profile Tab -> Profile Screen


**Flow Navigation** (Screen to Screen)

* Login Screen
   * Login Screen -> Feed Screen
* Feed Screen
   * Feed Screen -> Create Ride
   * Feed Screen -> Details Screen
* Profile Screen
    * Profile Screen -> User's posts Screen
* User's posts Screen
    * User's posts Screen -> Details Screen


## Wireframes
<img src="https://i.imgur.com/BSzOmwA.jpg">

This was the original wireframe we drew at the beginning. Throughout the process of writing the app, there have been some changes. Most significant is the replacement of the three category tabs (Share, Offer, Request) by the Filtering button, which helps the app look cleaner and enables more advanced filtering functions, like filtering posts based on dates, locations, etc. 


## Schema 
### Models
#### Ride posts

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | accountOwner        | Pointer to User| the author of the post |
   | destination   | String    | destination of the ride |
   | departure     | String   | departure location of the ride |
   | dateOfRide     | String | date when the user wants to get a ride |
   | createdAt     | DateTime  | date when the post is created|
   | updatedAt     | DateTime | date when post is last updated (default field) |
   | share         | Bool     | if the user is sharing the ride |
   | offer         | Bool     | if the user is offering the ride |
   | request       | Bool     | if the user is requesting the ride |
   | comments | Pointer to the comment(s)   | the comment(s) on the post |
   
 One of our future plans is changing the type of dateOfRide from String to DateTime by allowing the user to input the date, maybe using the PopUp Date Picker.

#### Comments

| Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the comment (default field) |
   | author        | Pointer to User| the author of the comment |
   | ride   | Pointer to Ride    | the ride post that the comment is made on |
   | text     | String   | the content of the comment |
   | createdAt     | DateTime  | date when the post is created|
   | updatedAt     | DateTime | date when post is last updated (default field) |


##  Sprint 1 Updates

![](https://i.imgur.com/JTWYpQz.gif)

## Sprint 2 Updates

https://user-images.githubusercontent.com/93749279/161398224-efd455d1-9f42-493a-afd7-77a93cc07d18.mov

<img src='http://g.recordit.co/70RY9i4WCi.gif' title='Video Walkthrough Part II' width='' alt='Video Walkthrough Part II' /> 

## Sprint 3 Updates

![Screen Recording 2022-04-09 at 9 08 36 PM (1)](https://user-images.githubusercontent.com/60333098/162597910-69fddf9e-94c6-433b-a1d5-9633276fb7f8.gif)


## Final Demo Video

https://vimeo.com/700240403


