# Secret Santa Assignment 🎅🎁

A **Secret Santa Assignment Generator** built with Flutter and Riverpod. This app allows users to upload an employee list, upload previous assignments (optional), and generate a new Secret Santa assignment while ensuring fairness (no self-assignments or repeated pairs from previous years). 

---

## 📂 Project Structure

```bash
📦 secret_santa_project
├── 📁 lib
│   ├── 📁 models          # Data models (Employee, Assignments, etc.)
│   ├── 📁 providers       # State management (Riverpod)
│   ├── 📁 services        # Business logic (CSV parsing, Secret Santa logic)
│   ├── 📁 screens        # UI screens (Home, Assignment Display, etc.)
│   ├── 📁 widgets        # Reusable UI components (File picker, buttons)
│   ├── main.dart        # Entry point of the app
├── 📁 assets
│   ├── snowflake_bg.png  # Background image
├── 📁 test               # Unit tests
└── pubspec.yaml         # Flutter dependencies & assets
```

---

## 🚀 Installation & Running the Project

### **1️⃣ Clone the Repository**
```bash
git clone [https://github.com/yourusername/secret-santa.git](https://github.com/dinesh-dot-com/secret-santa-flutter.git
cd secret-santa
```

### **2️⃣ Install Dependencies**
```bash
flutter pub get
```

### **3️⃣ Run the App**
#### **For Web**
```bash
flutter run -d chrome
```
#### **For Android/iOS**
```bash
flutter run
```

---

## 🖥️ Screens Overview

### **🏠 Home Screen**
- Upload Employee List (CSV)
- Upload Previous Assignments (CSV) *(Optional)*
- Generate Secret Santa Assignments

![Home Screen]
![localhost_61449_(Samsung Galaxy S20 Ultra)](https://github.com/user-attachments/assets/ec481944-c725-40e4-a491-d73d6729a6bd)

(https://via.placeholder.com/600x300)  

### **📜 Assignment Screen**
- Displays assigned Secret Santa pairs
- Option to download assignments as CSV

![Assignment Screen]

![localhost_61449_(Samsung Galaxy S20 Ultra) (1)](https://github.com/user-attachments/assets/2b691164-7ac4-4974-b3a8-59d10b52f20d)


## 🔧 Features
✅ Upload employee list via CSV  
✅ Supports previous assignments to avoid duplicate pairings  
✅ Generates fair Secret Santa assignments  
✅ Responsive UI with a festive theme  
✅ Download assignment results as CSV  

---

## 🛠️ Technologies Used
- **Flutter** (Dart)
- **Riverpod** (State Management)
- **csv** package (CSV Parsing)
- **file_picker** (For file selection)



**Happy Gifting! 🎄🎁**
