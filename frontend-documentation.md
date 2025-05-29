# Quizzy - Frontend Documentation

<div style="text-align: center;">
  <img src="quizzy/assets/logo/logo_whole.png" alt="quizzy-logo" style="width:400px;" />
</div>

---
This document details the frontend structure of the **Quizzy** Flutter mobile application. It covers the project's folder structure, coding standards, widget usage, and asset organization.

## Project Structure

Quizzy follows the **"Folder by Feature"** architecture for clarity and scalability.

```plaintext
quizzy/
│
├── assets/                      # All static assets (fonts, images, logos)
│   ├── fonts/
│   ├── images/
│   └── logo/
│
├── lib/
│   ├── core/                    # Reusable widgets and app-wide configuration
│   │   ├── app_colors.dart
│   │   ├── app_fonts.dart
│   │   ├── app_images.dart
│   │   └── widgets/
│   │       ├── app_bar.dart
│   │       ├── nav_bar.dart
│   │       ├── background_decoration.dart
│   │       ├── confirm_exit.dart
│   │       ├── login_signup_btn.dart
│   │       ├── profile_icon.dart
│   │       ├── quizzy_scaffold.dart
│   │       ├── quizzy_text_field.dart
│   │       ├── save_button.dart
│   │       └── search_with_qr.dart
│
│   └── views/                   # Feature-based UI implementation
│       ├── create-quiz/
│       │   └── widgets/
│       │       ├── create_question_card.dart
│       │       └── created_quizz_card.dart
│
│       ├── home/
│       │   └── widgets/
│       │       ├── quiz_card_group.dart
│       │       └── quiz_card.dart
│
│       ├── in-game/
│       │   └── widgets/
│       │       ├── answer_question_card.dart
│       │       ├── answered_question_card.dart
│       │       ├── player_in_game_card.dart
│       │       └── start_game_btn.dart
│
│       └── parameters/
│           └── widgets/
│               └── parameter_card.dart
```
<img src="documentation-img/folder-feature.png" alt="quizzy-logo" style="height:500px;" />

## Flutter Coding Standards

#### Widget Structure

- **Use `StatelessWidget` and `StatefulWidget` Appropriately**  
  Choose `StatelessWidget` when the widget does not manage any internal state, and `StatefulWidget` when the widget needs to manage dynamic state changes.

- **Extract Reusable UI Components into Custom Widgets**  
  Avoid code duplication by grouping frequently used UI elements or logic into separate reusable widgets.

#### Code Optimization

- **Use `const` Constructors Wherever Possible**  
  Use the `const` keyword to improve performance and reduce unnecessary rebuilds when widget trees contain static configurations.

#### Naming Conventions

- **Class Names: `UpperCamelCase`**  
  Example: `MyHomePage`, `UserProfileCard`

- **Variable and Function Names: `lowerCamelCase`**  
  Example: `userName`, `fetchUserData()`

#### Code Style

- **Default** flutter code **indentation**

## Core UI & Styling

### `app_colors.dart`
Defines consistent color constants used throughout the app for theming.

### `app_fonts.dart`
Declares font styles, sizes, and weights for a unified text appearance.

### `app_images.dart`
Holds paths to asset images for easy access and maintainability.

---

## Reusable Core Widgets

| Widget                       | Preview                             | Purpose |
|-----------------------------|-------------------------------------|---------|
| **app_bar.dart**            | <img src="documentation-img/app-bar.png" width="300px"/> | Custom app bar widget used in multiple screens. |
| **nav_bar.dart**            | <img src="documentation-img/nav-bar.png" width="300px"/> | Bottom navigation bar with app-wide navigation. |
| **background_decoration.dart** | <img src="documentation-img/bg-decoration.png" width="200px"/> | Applies themed background decoration (e.g., gradients or images). |
| **confirm_exit.dart**       | <img src="documentation-img/confirm-exit.png" width="200px"/> | Displays a confirmation dialog before exiting a screen or the app. |
| **login_signup_btn.dart**   | <img src="documentation-img/login-signup.png" width="300px"/> | Styled button used on login and signup screens. |
| **profile_icon.dart**       | <img src="documentation-img/profile-icon.png" width="150px"/> | Widget representing a user's avatar or profile. |
| **quizzy_scaffold.dart**    |  | Custom scaffold for consistent page layout. |
| **quizzy_text_field.dart**  | <img src="documentation-img/text.png" width="300px"/> | Styled text field widget used across the app. |
| **save_button.dart**        | <img src="documentation-img/save.png" width="250px"/> | Consistent save button used in forms or settings. |
| **search_with_qr.dart**     | <img src="documentation-img/search_with_qr.png" width="300px"/> | Composite widget for searching quizzes with optional QR scanning. |

---

## Feature-Based Widgets

### `create-quiz` Feature

| Widget                     | Preview                                                                 | Purpose                                              |
|---------------------------|-------------------------------------------------------------------------|------------------------------------------------------|
| **create_question_card.dart** | <img src="documentation-img/create-question.png" width="250px" /> | UI card to add a new quiz question dynamically. <br>**Props:**<br>- `QuestionData data`<br>- `VoidCallback onCopy` |
| **created_quizz_card.dart**   | <img src="documentation-img/created-quiz.png" width="250px" />   | Displays a preview or summary of a created quiz. <br>**Props:**<br>- `String quizName`<br>- `String quizDescription`<br>- `String? quizImageUrl` |

---

### `home` Feature

| Widget                  | Preview                                                           | Purpose                                                  |
|------------------------|-------------------------------------------------------------------|----------------------------------------------------------|
| **quiz_card.dart**      | <img src="documentation-img/quiz_card.png" width="250px" />      | Card widget showing a quiz’s name, thumbnail, and quick info. <br>**Props:**<br>- `String label`<br>- `String? imageUrl` |
| **quiz_card_group.dart**| <img src="documentation-img/quiz_card_group.png" width="250px" />| Groups quiz cards by category or filter. <br>**Props:**<br>- `String title`<br>- `List<QuizCardSmall> cards` |

---

### `in-game` Feature

| Widget                         | Preview                                                                | Purpose                                          |
|-------------------------------|------------------------------------------------------------------------|--------------------------------------------------|
| **answer_question_card.dart**   | <img src="documentation-img/question.png" width="250px" />   | Card that allows a player to select their answer. <br>**Props:**<br>- `VoidCallback onConfirm` |
| **answered_question_card.dart**| <img src="documentation-img/answered-question.png" width="250px" /> | Shows the answer and whether it was correct. |
| **player_in_game_card.dart**   | <img src="documentation-img/player.png" width="150px" />   | Displays a player's score and progress in a game. <br>**Props:**<br>- `String playerName` |
| **start_game_btn.dart**        | <img src="documentation-img/start.png" width="200px" />        | Button to begin the quiz game. <br>**Props:**<br>- `VoidCallback onPressed`<br>- `String text` |

---

### `parameters` Feature

| Widget              | Preview                                                             | Purpose                                           |
|--------------------|---------------------------------------------------------------------|---------------------------------------------------|
| **parameter_card.dart** | <img src="documentation-img/parameters.png" width="250px" /> | Displays and allows modification of app/user settings. <br>**Props:**<br>- `IconData icon`<br>- `String text`<br>- `VoidCallback onTap` |

---

## Assets

### Fonts
Custom fonts are stored in `assets/fonts/` and declared in `pubspec.yaml`.

### Images
All image files (e.g., icons, quiz thumbnails) are in `assets/images/`.

### Logos
App logos and branding visuals are in `assets/logo/`.

---

## Notes

- This app follows **clean UI principles** with emphasis on component reusability and separation of concerns.
- The **Folder by Feature** structure improves maintainability and helps scale the app by keeping logic and widgets localized.
