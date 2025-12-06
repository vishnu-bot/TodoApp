# TodoApp

A powerful and intuitive Todo application built for iOS using SwiftUI and Core Data. Manage your daily tasks efficiently with categorization, real-time search, and visual insights.

## Features

- **📝 Task Management**: Easily add, edit, and delete tasks. Mark them as complete with a simple tap.
- **🗂️ Categories**: Organize your tasks into **Work**, **Personal**, and **Others** to keep your life structured.
- **📅 Today's Focus**: The Home tab highlights tasks due today, helping you stay focused on what matters now.
- **🔍 Advanced Search**: Find any task instantly with real-time search and filter by category.
- **📊 Dashboard**: Get visual insights into your productivity with a dedicated dashboard showing completion rates and task breakdowns.
- **Sort & Filter**: Sort your tasks by due date to prioritize deadlines.
- **💾 Local Persistence**: All your data is stored securely on your device using Core Data.

## Tech Stack

- **Language**: Swift 5
- **UI Framework**: SwiftUI
- **Data Persistence**: Core Data
- **Architecture**: MVVM (Model-View-ViewModel)
- **Charts**: Swift Charts (for Dashboard visualizations)

## Project Structure

- **Views**: Contains all the UI components (HomeView, ListView, TaskDetailView, etc.).
- **ViewModel**: Handles business logic and data manipulation (CoreDataViewModel, SearchViewModel, SortViewModel).
- **Model**: Core Data entities and persistence logic.

## Getting Started

1.  Clone the repository.
2.  Open `TodoApp.xcodeproj` in Xcode.
3.  Build and run on the iOS Simulator or a physical device.

## Requirements

- iOS 26.0+
- Xcode 16.0+

