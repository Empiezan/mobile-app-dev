# iOS Apps Developed in CSE 438
This repository is a collection of 4 iOS apps that were developed over the course of taking an iOS mobile application course at Washington University in St. Louis. Each app was developed in about 1-2 weeks and focused on learning new tools from the Swift API. These apps range from a simple shopping cart calculator to a movie browsing assistant. The curriculum can be found [here](https://www.arl.wustl.edu/~todd/cse438/index.html).

## Getting Started
### Xcode 9.3
The code in this repository is written in Swift 3/4 and was developed in Xcode 9.3. Therefore, ensure that the Xcode version is at least version 9.3 when attempting to compile and test the apps. 
### Running apps on iPhone or Simulator 
App 2 was developed specifically to adjust to different screen sizes and iOS devices, but Apps 1, 3, and 4 were only developed and tested on an iPhone 8 simulation. Therefore, it is advised to select iPhone 8 or iPhone 8 Plus as the simulator in general. 

### App/Lab 1: Shopping Cart Calculator
An app to keep track of shopping cart items and the running total. The app consists of two main views: a form and a tableview. In the form, users can supply information such as the name of the item, quantity, discounts, and taxes. The tableview displays the items that users have submitted from the form, shows the running total, and allows users to delete individual items or all items.

<img src="https://github.com/Empiezan/mobile-app-dev/raw/master/Lab1.gif" width="250"/>

### App/Lab 2: Virtual Pet App
In this app, users have 4 pets: a dog, a cat, a fish, and a bird. Each pet has its own food level and happiness level. In addition, the user has two buttons to feed and play with each pet. The `feed` button spawns a bag of pet food that the user can give to the pet by dragging the bag to the pet. By feeding the pet, its food level increases by one point. The `play` button unfortunately does not spawn a pet toy, but the pet's happiness level does increase and its food level decreases. Once a pet's food level reaches 0, the user can no longer play with the pet and the pet's happiness level will not increase.

<img src="https://github.com/Empiezan/mobile-app-dev/raw/master/Lab2.gif" width="250"/>
<img src="https://github.com/Empiezan/mobile-app-dev/raw/master/Lab2-landscape.gif" width="250"/>

### App/Lab 3: Free-drawing App
For this drawing app, users can draw to their heart's content, vary the size of the brush, choose different colors, and save their beautiful creations to the Photo Gallery. Users may also import their own pictures, draw on the pictures, and save the photos. 

<img src="https://github.com/Empiezan/mobile-app-dev/raw/master/Lab3.gif" width="250"/>

### App/Lab 4: Movie Buff Assistant
This assistant allows users to browse the catalog of movies from the TMDb database, check out the most popular movies, search movies by genre, view movie details (e.g., rating and release date), and save movies that they're interested in. To retrieve the movie data, the apps sends several GET requests to the TMDb API. 

<img src="https://github.com/Empiezan/mobile-app-dev/raw/master/Lab4.gif" width="250"/>
