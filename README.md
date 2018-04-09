# Lab 6 - *Name of App Here*

**Name of your app** is an app that allows the user to search for locations using the [Foursquare API](https://developer.foursquare.com/docs) and create a pin with an image annotation.

Time spent: **8** hours spent in total

## User Stories

The following **required** user stories are complete:

- [x] User can view a map (+2pt)
- [x] User can take a photo (+1pt)
- [x] User can tag a location (+1pt)
- [x] User can drop a pin with image annotation (+1pt)

The following **stretch** user stories are implemented:

- [x] User sees a custom annotation (+1pt)
- [x] User can see Fullscreen Picture (+1pt)
- [ ] User sees a custom image for the "pin" (+1pt)
- [ ] List anything else that you can get done to improve the app functionality! (+1-3pts)

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. How can I save the pinned photos so that they persist on app restarts?
2. How can I delete the pinned photos?

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://image.ibb.co/bwZVKx/photo_Map_Demo_Fix_Full.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' width="100"/>

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
* Learned more about the delegate; it is the object that implements the protocol
* Learned how to grab the selected annotation so I could display the correct full photo

## License

    Copyright [2018] [Mavey Ma]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

## Starter Project for Photo Map Exercise (Swift)
![Image](http://i.imgur.com/WIwqNtn.gif)

- Connects with Foursquare API
- Implements `LocationsViewController`
- Placeholders for `PhotoMapViewController` and `FullImageViewController`
