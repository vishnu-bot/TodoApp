//
//  NewTaskView.swift
//  TodoApp
//
//  Created by Vishnu on 04/12/25.
//

import SwiftUI

struct NewTaskView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: CoreDataViewModel
    @FocusState private var isFocused: Bool
    @State private var newTask: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Calendar.current.startOfDay(for: Date())
    @State private var priorities: [Int] = [1, 2, 3]
    @State private var selectedPriority: Int = 3
    @State private var categories: [String] = [ Constants.workCategoryString, Constants.personalCategoryString,Constants.othersCategoryString]
    @State private var selectedCategory: String = Constants.othersCategoryString
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(spacing:35){
                    // Task Name input field
                    VStack(alignment: .leading){
                    
                        Text(Constants.taskTitleString)
                            .bold()
                        
                        TextField(Constants.taskTitleTextFeildPlaceholder, text: $newTask)
                            .taskTextFieldStyle()
                        
                    }
                    
                    // Task Description input field
                    VStack(alignment: .leading){
                        
                        Text(Constants.taskDescriptionString)
                            .bold()
                        
                        TextEditor(text: $description)
                            .textEditorStyle()
                    }
                    
                    // Due Date picker
                    DatePicker(Constants.taskDueDateString, selection: $dueDate, displayedComponents: .date)
                        .bold()
                        
                    // Priority picker
                    HStack{
                        
                        Text(Constants.taskPriorityString)
                            .bold()
                        Spacer()
                        Picker("Priority", selection: $selectedPriority) {
                            ForEach(priorities, id: \.self) { priority in
                                Text("Priority Level \(priority)").tag(priority)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    // Task Category Picker
                    VStack(alignment: .leading){
                        Text(Constants.taskCategoryString)
                            .bold()
                            .padding(.horizontal,2.5)
                        HStack{
                            Picker("Category", selection: $selectedCategory) {
                                ForEach(categories, id: \.self) { category in
                                    Text("\(category)").tag(category)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    
                    // Save Button
                    Button{
                        guard !newTask.isEmpty else { return }
                        viewModel.addTaskData(title: newTask, notes: description, dueDate: dueDate, isCompleted: false, priority: Int16(selectedPriority),category: selectedCategory)
                        dismiss()
                    } label: {
                        Text(Constants.saveButtonString)
                            .saveButtonStyle()
                        
                    }
                    
                    
                    
                    
                }
                .padding()
            }
            .navigationBarTitle(Constants.newTaskTitleString)
        }
        
    }
}

#Preview {
    NewTaskView()
        .environmentObject(CoreDataViewModel.preview)
}
