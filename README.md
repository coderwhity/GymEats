# **Gym Eats 🏋️‍♂️🍴**

  

**App Description**

Gym Eats is a Flutter application designed to help gym enthusiasts find and manage easy and nutritious recipes. The app uses AI-generated recipes based on available food ingredients to provide users with personalized meal suggestions.

  
Usage

*   Home Page: View and search for recipes. 🔍
*   Recipe Details: Get detailed information about each recipe, including AI-generated suggestions. 📋
*   Basket Page : Displays items in basket and there quantity, 🛒
*   Item Search Page : Search item and display's information about item. 🔎


**Prerequisites**

  

Before you begin, ensure you have met the following requirements:

*   Flutter SDK: Ensure you have Flutter installed on your machine. You can download it from flutter.dev.
*   Firebase Project: Create a Firebase project and configure it for your Flutter app. Follow the steps provided on the Firebase dashboard for adding a new Flutter app.
*   Gemini API: The app uses Gemini AI for generating recipes. Store your Gemini API key in Firestore under a specific document or configuration file. Additionally, create a .env file in the root of your project with the following content:

  

```GEMINI\_API\_KEY='your\_api\_key'```

  

Replace 'your\_api\_key' with your actual Gemini API key.

  

**Installation**

  

Clone the repository to your local machine:

```git clone https://github.com/coderwhity/GymEats.git```

  

Navigate to the Project Directory

```cd GymEats```

  

**Install Dependencies**

Install the necessary dependencies for the Flutter project:

```flutter pub get```

  

**Configure Firebase**

  

To configure Firebase in your project, follow these steps:

Ensure you have Firebase CLI installed. You can install it via npm:

```npm install -g firebase-tools```

  

Log in to Firebase using the CLI:

```firebase login```

  

Initialize Firebase in your project:

```firebase init```

  

Follow the prompts to configure Firebase for your Flutter project.

Build and Run the App

  

Run the app on an emulator or a physical device:

```flutter run```
  

License

This project is licensed under the MIT License. See the LICENSE file for details.
