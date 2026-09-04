# Minimalist Flutter Profile Interface

A modern, responsive, and highly interactive profile screen built with Flutter. This project demonstrates advanced UI/UX principles, including staggered cascade animations, global state management for dynamic theming (Light/Dark mode), and isolated widget state for interactive components.

## 📸 Screenshots


### Light Mode

<img width="1470" height="956" alt="Screenshot 2026-09-04 at 11 31 09 PM" src="https://github.com/user-attachments/assets/4ae5ff16-926c-4279-ace7-5255e627b041" />

### Dark Mode

<img width="1470" height="956" alt="Screenshot 2026-09-04 at 11 30 37 PM" src="https://github.com/user-attachments/assets/5c542fee-053d-455b-8880-4247185aa6a2" />

### Interactive State & Notifications

<img width="1470" height="956" alt="Screenshot 2026-09-04 at 11 31 29 PM" src="https://github.com/user-attachments/assets/2b7b0a6f-d7a2-42f2-bf09-b7bc89cd0b81" />

---

## ✨ Key Features

* **Dynamic Theming:** Seamless toggle between Light and Dark modes managed at the root level, dynamically adjusting all text, container, and border colors.
* **Staggered Animations:** Premium entrance cascade effect upon screen load using `AnimationController` and `SingleTickerProviderStateMixin`.
* **Responsive Layout:** Utilizes `LayoutBuilder` to adapt the UI structure seamlessly between mobile (stacked) and tablet/desktop (side-by-side) form factors.
* **Interactive State Management:** The 'Follow' button is an isolated `StatefulWidget` featuring touch-feedback scaling (`AnimatedScale`), smooth color morphing (`AnimatedContainer`), and functional `SnackBar` popup notifications.
* **Modern UI Elements:** Features a custom 'squircle' (rounded rectangle) avatar, subtle surface elevations, and meticulous typography.

## 🛠️ Tech Stack

* **Framework:** [Flutter](https://flutter.dev/)
* **Language:** Dart
* **Core Libraries:** `material.dart`

## 📂 Project Structure

The codebase is kept modular and clean, divided into two primary files:

```text
lib/
├── main.dart             # App entry point, Theme management, and root MaterialApp
└── profile_screen.dart   # Core UI layout, animations, and interactive widget classes<img width="1470" height="956" alt="Screenshot 2026-09-04 at 11 29 43 PM" src="https://github.com/user-attachments/assets/c64324cb-df21-453c-84a9-aedfb06bd47a" />
