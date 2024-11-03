Ecom Mall

Ecom Mall is a Flutter-based e-commerce application that allows users to browse and purchase products across various categories. The app integrates with Firebase for backend services and utilizes the Bloc pattern for state management.
Features

    Product Browsing: Explore products by categories such as Foods and Drinks.
    Product Details: View detailed information, including images, descriptions, prices, and ratings.
    Shopping Cart: Add products to the cart, adjust quantities, and proceed to checkout.
    User Authentication: Sign up and log in to manage personal accounts.
    Responsive Design: Optimized for various screen sizes.

Getting Started
Prerequisites

Ensure you have the following installed:

    Flutter SDK
    Dart SDK
    Firebase CLI

Installation

    Clone the Repository

    bash

git clone https://github.com/roshdology123/ecom_mall.git

Navigate to the Project Directory

bash

cd ecom_mall

Install Dependencies

bash

flutter pub get

Set Up Firebase

    Create a Firebase project in the Firebase Console.
    Add Android and iOS apps to your Firebase project.
    Download the google-services.json file for Android and place it in the android/app directory.
    Download the GoogleService-Info.plist file for iOS and place it in the ios/Runner directory.
    Ensure Firebase Firestore is enabled and set up the necessary collections and documents as per the app's requirements.

Run the App

bash

    flutter run

Project Structure

The project follows a feature-based structure:

    lib/
        core/: Contains shared resources like themes, styles, and utilities.
        features/: Contains feature-specific modules.
            authentication/: Handles user sign-up and login functionalities.
            home/: Manages the home screen, including product listings and categories.
            product/: Manages product details and related functionalities.
            cart/: Manages the shopping cart and checkout process.

State Management

The app uses the Bloc pattern for state management, ensuring a clear separation between business logic and UI components.
Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.
License

This project is licensed under the MIT License. See the LICENSE file for details.
Acknowledgments

    Flutter
    Firebase
    Bloc

For more information, visit the official Flutter samples repository.
