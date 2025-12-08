//
//  File.swift
//  TodoApp
//
//  Created by Vishnu on 03/12/25.
//

import Foundation
import SwiftUI


struct Constants {
    
    
    // ContentView Strings
    static let allTaskString = "All Tasks"
    static let searchString = "Search"
    static let dashboardString = "Dashboard"
    static let todaysTaskString = "Today"
    
    static let addTaskString = "Add Task"
    
    // ContentView Icons
    static let date = Calendar.current.component(.day, from: Date())
    static let todayTaskIcon = "\(date).calendar"
    static let allTaskIcon = "checklist"
    static let searchIcon = "magnifyingglass"
    static let dashboardIcon = "gauge.chart.leftthird.topthird.rightthird"
    
    static let addButtonIcon = "plus"
    
    // To store today's Date
    static var todayDate = Calendar.current.startOfDay(for: Date())
    
    
    // For AllTaskView
    static let preSortIcon = "line.3.horizontal.decrease.circle.fill"
    static let postSortIcon = "line.3.horizontal.decrease.circle"
    static let preSortedTitle = "Sorted - Due Date"
    static let editTaskSubtitle = "Click save to save any changes"
        
    // For ListView
    static let uncheckedIcon = "circle"
    static let checkedIcon = "checkmark.circle.fill"
    
    // For TaskForms
    static let taskTitleString = "Task Name"
    static let taskDescriptionString = "Description"
    static let taskDueDateString = "Due Date"
    static let taskPriorityString = "Task Priority"
    static let taskCategoryString = "Task Category"
    static let saveButtonString = "Save"
    static let newTaskTitleString = "Add Task"
    
    static let taskTitleTextFeildPlaceholder = "New Task"
   
    // For TaskDetailView
    static let taskToggleString = "Task Completed"
    static let editTaskTitle = "Task Information"
    static let subTaskString = "Sub Tasks"
    static let doneButtonString = "Done"
    

    // Category Strings
    static let workCategoryString = "Work"
    static let personalCategoryString = "Personal"
    static let othersCategoryString = "Others"
    
    //Sub Task view
    static let addSubTaskIcon = "plus.circle.fill"
    static let addSubTaskString = "Add new Subtask..."
    

    
    
    
    
    
    
}

// Styles for different UI elements
extension Text {
    
    func saveButtonStyle() -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity)
            
            .background(Color.red.opacity(0.83))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}


extension HStack {
    func addButtonStyle() -> some View {
        self
            .foregroundStyle(.white)
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.red.opacity(0.93)))
                            )
    }
}

extension TextField {
    func taskTextFieldStyle() -> some View {
        self
            .padding()
            .cornerRadius(10)
            .background(Color(.secondarySystemBackground))
        
    }
}

extension TextEditor {
    func textEditorStyle() -> some View {
        self
            .scrollContentBackground(.hidden)
            .padding(.horizontal, 8)
            .frame(minHeight: 120)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.2), lineWidth: 1))
        
    }
    
}
