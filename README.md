# Shop App

This app is an online store that lets you shop for products and/or post your own.
Also, this is the fourth Flutter app I made in Academind's Flutter & Dart course.

Links to the course:

* On Udemy.com - [Flutter & Dart - The Complete Guide](https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/)
* On Academind.com - [Learn Flutter & Dart to Build iOS & Android Apps](https://pro.academind.com/p/learn-flutter-dart-to-build-ios-android-apps-2020)

## Table of contents

* [Concepts used during development](#concepts-used-during-development)
* [Getting started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [How to use](#how-to-use)
    * [Screenshots](#screenshots)
* [Built with](#built-with)
* [Authors](#authors)
* [License](#license)

## Concepts used during development

* More core widgets
  * GridTile & GridTileBar
  * Chip
  * Dismissible
  * ExpansionTile
  * DrawerHeader
  * ListView vs. SingleChildScrollView & Column
  * FutureBuilder
* More styling
  * Container's transform property
  * Container's box shadows
* More Dart basics
  * "extends" vs. "with"
  * Futures & asynchronous code
  * Working with "async" & "await"
* State management with the "provider" package
  * Working with providers & listeners
  * Providing objects without the "ChangeNotifier" mixin
  * Using nested models & providers
  * "Consumer" vs. "Provider.of"
  * Local state vs. app-wide state
  * Proxy providers
* Working with user input & forms
  * Snack bars with a button for undoing an action
  * Alert dialogs
  * Managing form input focus
  * Validating & submitting forms
  * Using regular expressions for input validation
* Sending HTTP requests
  * GET, POST, PUT, PATCH & DELETE requests
  * JSON strings
  * Showing a loading indicator
  * Handling errors gracefully
  * Implementing pull to refresh functionality
  * Optimistic updating
  * Status codes
  * Creating custom exceptions & error messages
* Adding user authentication
  * How it works (sessions, tokens, protected resources)
  * Sign-up & sign-in with email & password
  * Managing the ID token locally (in the app)
  * Attaching the token to outgoing HTTP requests
  * Attaching newly created state to users
  * Implementing sign-out functionality
  * Adding automatic sign-in & sign-out
* Animations
  * Completely manually controlled
  * AnimatedBuilder widget
  * AnimatedContainer & AnimatedCrossFade widgets
  * FadeTransition & SlideTransition widgets
  * FadeInImage widget
  * Adding "hero" transitions
  * Working with slivers
  * Implementing custom route transitions

## Getting Started

Read this for downloading and installing the app from your mobile device.

### Prerequisites

You'll need:

```
- Android Jelly Bean or later (version 4.1, API level 16).

- Installation of apps from unknown sources permitted (see the "Setting up your device"
section at https://www.cnet.com/tech/mobile/how-to-install-apps-outside-of-google-play/).

- The application's binary file (download from the "Releases" section in this project's
GitHub repository home page), then begin the installation by opening the file.
```

### How to use

1. Open the app.
2. Tap "Sign Up Instead".
3. Enter your email and a new password.
4. Tap "Sign Up".
5. Open the drawer.
6. Tap the "Your Products" item.
7. Tap the "+" icon at the upper-right corner of the screen for adding a new product.
8. Enter a title, price, description and image URL for the product you want to publish.
9. Tap "SAVE" at the upper-right corner of the screen.
10. If you want to edit or delete a product, tap the "pencil" or the "trash can" icons next to it, respectively.
11. Open the drawer again.
12. Tap the "Store" item.
13. Add the products you would like to buy to the cart by tapping their "add to cart" icons.
14. Once you finish selecting products, tap the "cart" icon at the upper-right corner of the screen.
15. Review your order and delete an entire item by dragging it to the right if necessary.
16. Tap "ORDER NOW".
17. Immediately after, you are taken to the "Orders" screen, where you can view all your orders and tap them for more details.
18. Once you finish using the app, open the drawer and tap "Sign Out".
19. To sign in again, enter your email and password, then tap "Sign In".

#### Screenshots

<p float="left">
  <img alt="App Screenshot 1" src="/dev_assets/images/app_screenshot_1.png" width="250" />
  <img alt="App Screenshot 2" src="/dev_assets/images/app_screenshot_2.png" width="250" />
  <img alt="App Screenshot 3" src="/dev_assets/images/app_screenshot_3.png" width="250" />
  <img alt="App Screenshot 4" src="/dev_assets/images/app_screenshot_4.png" width="250" />
  <img alt="App Screenshot 5" src="/dev_assets/images/app_screenshot_5.png" width="250" />
  <img alt="App Screenshot 6" src="/dev_assets/images/app_screenshot_6.png" width="250" />
  <img alt="App Screenshot 7" src="/dev_assets/images/app_screenshot_7.png" width="250" />
  <img alt="App Screenshot 8" src="/dev_assets/images/app_screenshot_8.png" width="250" />
  <img alt="App Screenshot 9" src="/dev_assets/images/app_screenshot_9.png" width="250" />
  <img alt="App Screenshot 10" src="/dev_assets/images/app_screenshot_10.png" width="250" />
  <img alt="App Screenshot 11" src="/dev_assets/images/app_screenshot_11.png" width="250" />
  <img alt="App Screenshot 12" src="/dev_assets/images/app_screenshot_12.png" width="250" />
  <img alt="App Screenshot 13" src="/dev_assets/images/app_screenshot_13.png" width="250" />
  <img alt="App Screenshot 14" src="/dev_assets/images/app_screenshot_14.png" width="250" />
</p>

## Built with

* [Dart 2.13.4](https://dart.dev/) - The programming language used
* [provider 6.0.0](https://pub.dev/packages/provider) - State management package

## Authors

* **David Itcovici** - [LinkedIn](https://www.linkedin.com/in/david-itcovici/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
