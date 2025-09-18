# Tasky


Tasky is a simple and elegant to-do list application built with Flutter. It provides a clean, dark-themed interface to help you manage your daily tasks efficiently. The app stores all data locally on your device.

## Key Features

- **Personalized Onboarding**: A welcoming screen that prompts new users for their name.
- **Clean Dashboard**: A main screen that greets the user and provides an overview of their tasks.
- **Task Management**:
  - Add new tasks with a title, a detailed description, and a high-priority flag.
  - Mark tasks as complete with a simple checkbox.
  - Delete tasks that are no longer needed.
- **State Persistence**: Your name and tasks are saved locally using `shared_preferences`, so your data is available every time you open the app.
- **Responsive UI**: A smooth and intuitive user experience with a bottom navigation bar to switch between views.
- **Cross-Platform**: Built with Flutter, allowing deployment across mobile, web, and desktop from a single codebase.

## Technologies Used

- **Framework**: Flutter
- **State & Data Persistence**: `shared_preferences` for local storage.
- **UI Packages**:
  - `flutter_svg` for rendering sharp SVG assets.
  - `snackly` for displaying in-app notifications.

## Project Structure

The core application logic is organized within the `lib` directory:

```
lib/
├── main.dart             # Application entry point
├── models/
│   └── task_model.dart   # Data model for a task
└── views/
    ├── add_task_view.dart      # Screen for adding a new task
    ├── complete_tasks_view.dart # Placeholder for completed tasks view
    ├── home_view.dart          # Main dashboard screen
    ├── main_view.dart          # Main widget with bottom navigation
    ├── profile_view.dart
    ├── tasks_view.dart
    └── welcom_view.dart        # Onboarding screen for new users
```

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- A code editor like VS Code or Android Studio.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/enadabulawi/Tasky.git
    ```
2.  **Navigate to the project directory:**
    ```sh
    cd Tasky
    ```
3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
4.  **Run the application:**
    ```sh
    flutter run
