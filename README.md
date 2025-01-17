# Project 4 - *Impostorgram*
<img src='https://github.com/athomas9195/Impostorgram/blob/main/impostorgram.png'/>

**Impostorgram** is a photo sharing app using Parse as its backend.

Time spent: **31** hours spent in total

## User Stories

The following **required** functionality is completed:

- [ ] User can sign up to create a new account using Parse authentication
- [ ] User can log in and log out of his or her account
- [ ] The current signed in user is persisted across app restarts
- [ ] User can take a photo, add a caption, and post it to "Instagram"
- [ ] User can view the last 20 posts submitted to "Instagram"
- [ ] User can pull to refresh the last 20 posts submitted to "Instagram"
- [ ] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [ ] Run your app on your phone and use the camera to take the photo
- [ ] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [ ] Show the username and creation time for each post
- [ ] User can use a Tab Bar to switch between a Home Feed tab (all posts) and a Profile tab (only posts published by the current user)
- User Profiles:
  - [ ] Allow the logged in user to add a profile photo
  - [ ] Display the profile photo with each post
  - [ ] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [ ] User can like a post and see number of likes for each post in the post details screen.
- [ ] Style the login page to look like the real Instagram login page.
- [ ] Style the feed to look like the real Instagram feed.
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [ ] Added like and unlike options on both home feed and details view. 
- [ ] Implemented dark mode. 
- [ ] Rounded out the corners of user's profile pictures. 
- [ ] Right after user posts an image, the home feed will display the newest post automatically. 
- [ ] Shows user alert when trying to log in with invalid credentials. 
- [ ] Implemented double tap gesture for liking images. 
- [ ] Added Instagram stories view to the feed page.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I'd like to talk about creating model for Parse (like User and Post). What are the benefits and downsizes as opposed to directly setting it as a parameter/property. Like what I did for comments. 
2. I really liked Chris' lecture on API yesterday and I'd like to explore more. 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

*Main:*

<img src='https://github.com/athomas9195/Impostorgram/blob/main/final%20ig%20demo%20main.gif' title='Video - Main' width='' alt='Video Walkthrough' />

*Login/Signup:*

<img src='https://github.com/athomas9195/Impostorgram/blob/main/ezgif.com-gif-maker%20(2).gif' title='Video - Main' width='' alt='Video Walkthrough' />

*Posting (camera):*

<img src='https://github.com/athomas9195/Impostorgram/blob/main/post%20camera%20demo%20ig.gif' title='Video - Main' width='' alt='Video Walkthrough' />

*Posting (**custom** camera view):*

<img src='https://github.com/athomas9195/Impostorgram/blob/main/custom%20camera%20view%20demo%20ig.gif' title='Video - Main' width='' alt='Video Walkthrough' />

*Posting (photo library):*

<img src='https://github.com/athomas9195/Impostorgram/blob/main/post%20library%20demo%20ig.gif' title='Video - Main' width='' alt='Video Walkthrough' />

*Profile and editing profile image:* 

<img src='https://github.com/athomas9195/Impostorgram/blob/main/prof%20pic%20ig%20demo.gif' title='Video - Main' width='' alt='Video Walkthrough' />

*Instagram stories:*

<img src='https://github.com/athomas9195/Impostorgram/blob/main/stories%20demo%20ig.gif' title='Video - Main' width='' alt='Video Walkthrough' />


*Infinite scroll and loading:*

<img src='https://github.com/athomas9195/Impostorgram/blob/main/refresh%20demo%20ig.gif' title='Video - Main' width='' alt='Video Walkthrough' />

*Double tap to like:*

<img src='https://github.com/athomas9195/Impostorgram/blob/main/double%20tap%20like%20demo%20ig.gif' title='Video - Main' width='' alt='Video Walkthrough' />



GIF created with [Kap](https://getkap.co/).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [Parse]
- [DateTools]
- [SVPullToRefresh]
- [MBProgressHUD]


## Notes

Some challenges I encountered were implementing the comments section and also making the profile picture appear for each post after changing the pic in the profile view. Something I want to work on and improve is the style of my code. I really liked this project becuase of the exciting challenges!

## License

    Copyright [2021] [CodePath]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
