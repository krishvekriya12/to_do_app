<div align="center">

  # 📝 Minimalist Flutter To-Do App
  
  **A fast, aesthetic, and responsive task management application built with Flutter & Hive.**

  [![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
  [![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
  [![Hive](https://img.shields.io/badge/Database-Hive-orange?style=for-the-badge&logo=hive&logoColor=white)](https://pub.dev/packages/hive_flutter)
  [![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-lightgrey?style=for-the-badge)](https://flutter.dev/)
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](LICENSE)

  <p align="center">
    <a href="#-features">Features</a> •
    <a href="#-screenshots">Screenshots</a> •
    <a href="#-project-structure">Project Structure</a> •
    <a href="#-getting-started">Getting Started</a> •
    <a href="#-roadmap">Roadmap</a>
  </p>

</div>

---

## 📱 Screenshots

<div align="center">
  <table>
    <tr>
      <td align="center"><b>🏠 Home Screen</b></td>
      <td align="center"><b>➕ Add Task Dialog</b></td>
      <td align="center"><b>🗑️ Swipe to Delete</b></td>
    </tr>
    <tr>
      <td><img src="screenshots/home.png" width="240" alt="Home Screen" /></td>
      <td><img src="screenshots/add_task.png" width="240" alt="Add Task Dialog" /></td>
      <td><img src="screenshots/swipe_delete.png" width="240" alt="Swipe to Delete" /></td>
    </tr>
    <tr>
      <td align="center"><em>Interactive task list with strike-through</em></td>
      <td align="center"><em>Quick entry popup dialog</em></td>
      <td align="center"><em>Smooth gesture-driven deletion</em></td>
    </tr>
  </table>
</div>

---

## ✨ Key Features

- ⚡ **Offline-First Storage**: Powered by [Hive](https://pub.dev/packages/hive_flutter), a blazing-fast, lightweight NoSQL key-value database for local persistence.
- 👆 **Smooth Swipe Gestures**: Integrated with [flutter_slidable](https://pub.dev/packages/flutter_slidable) for intuitive swipe-to-delete actions.
- 🎨 **Modern Yellow Palette**: Thoughtfully designed pastel yellow aesthetic with balanced contrast and Material 3 design principles.
- ✅ **Dynamic Task Status**: Instant strike-through visual feedback on task completion.
- 🛡️ **Input Validation**: Safe checks to prevent empty or whitespace-only task creation.
- 🔄 **Auto Controller Management**: Clean dialog inputs with automatic controller resets.

---

## 📂 Project Structure

```text
to_do_app/
├── android/                  # Android native configuration
├── ios/                      # iOS native configuration
├── lib/
│   ├── data/
│   │   └── database.dart     # Hive local database management & schema
│   ├── pages/
│   │   └── home_page.dart    # Main screen with task list & state handling
│   ├── util/
│   │   ├── dialog_box.dart   # Popup dialog for adding new tasks
│   │   ├── my_button.dart    # Custom reusable themed button component
│   │   └── todo_tile.dart    # Task item card with slidable actions & checkbox
│   └── main.dart             # App initialization, Hive startup & theming
├── screenshots/              # Application preview screenshots
├── pubspec.yaml              # Dependencies and asset declarations
└── README.md                 # Project documentation
```

---

## 🛠️ Tech Stack & Dependencies

| Layer | Technology | Purpose |
| :--- | :--- | :--- |
| **Framework** | [Flutter 3.x](https://flutter.dev/) | Cross-platform UI toolkit |
| **Language** | [Dart 3.x](https://dart.dev/) | Strongly-typed client-optimized language |
| **Local Database** | [hive_flutter](https://pub.dev/packages/hive_flutter) | Fast, encrypted/unencrypted local storage |
| **UI Components** | [flutter_slidable](https://pub.dev/packages/flutter_slidable) | Directional swipe actions on list items |

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version 3.0.0 or higher)
- [Android Studio](https://developer.android.com/studio) / [VS Code](https://code.visualstudio.com/) with Flutter extensions
- A physical device or emulator/simulator

### Installation & Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/to_do_app.git
   cd to_do_app
   ```

2. **Fetch all dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify setup:**
   ```bash
   flutter doctor
   ```

4. **Launch the application:**
   ```bash
   flutter run
   ```

---

## 🗺️ Roadmap & Future Enhancements

- [x] 🌓 **Dark Mode / Dynamic Themes**
- [x] ✏️ **Edit & Update Existing Tasks**
- [x] 🏷️ **Priority Flags** (High / Medium / Low)
- [x] ↩️ **Undo Delete SnackBar Action**
- [x] 🔍 **Search & Category Filters**
- [ ] 📅 **Due Dates & Time Reminders**

---

## 📄 License

This project is licensed under the [MIT License](LICENSE) - feel free to use and modify for personal and educational projects.

<div align="center">
  <sub>Built with ❤️ using Flutter</sub>
</div>
