//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by Vishnu on 04/12/25.
//

import SwiftUI
internal import CoreData

struct TaskDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: CoreDataViewModel
    var entity: TaskEntity?
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Calendar.current.startOfDay(for: Date())
    @State private var priorities: [Int] = [1, 2, 3]
    @State private var selectedPriority: Int = 3
    @State private var isCompleted: Bool = false
    @State private var categories: [String] = [ Constants.workCategoryString,  Constants.personalCategoryString,Constants.othersCategoryString]
    @State private var selectedCategory: String = Constants.workCategoryString
    @State private var isShowingSubTasks = false
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(spacing:35){
                    
                    // Displays the title of the task and allows us to update
                    VStack(alignment: .leading){
                        Text(Constants.taskTitleString)
                            .bold()
                        TextField(Constants.newTaskTitleString, text: $title)
                            .taskTextFieldStyle()
                    }
                    
                    // Displays the desciption of the task and allows us to update
                    VStack(alignment: .leading){
                        Text(Constants.taskDescriptionString)
                            .bold()
                        TextEditor(text: $description)
                            .textEditorStyle()
                    }
                    
                    // to update the completion status of the project
                    Toggle(Constants.taskToggleString, isOn:$isCompleted)
                        .onChange(of: isCompleted) { _ in
                            viewModel.toggleUpdate(isCompleted: isCompleted, entity: entity!)
                        }
                    
                    // Date Picker for updating task info
                    DatePicker(Constants.taskDueDateString, selection: $dueDate, displayedComponents: .date)
                    
                    // Priority Selector
                    HStack{
                        
                        Text(Constants.taskPriorityString)
                        Spacer()
                        Picker("Priority", selection: $selectedPriority) {
                            ForEach(priorities, id: \.self) { priority in
                                Text("Priority Level \(priority)").tag(priority)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    // Category Selector
                    VStack(alignment: .leading){
                        Text(Constants.taskCategoryString)
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
                    
                    Button{
                        guard !title.isEmpty else { return }
                        if let entity = entity {
                            viewModel.updateTaskData(title: title, notes: description, dueDate: dueDate, isCompleted: isCompleted, priority: Int16(selectedPriority),category: selectedCategory ,entity: entity)
                        }
//                        else {
//                            viewModel.addTaskData(title: title, notes: description, dueDate: dueDate, isCompleted: false, priority: Int16(selectedPriority))
//                            viewModel.saveData()
//                        }
                        dismiss()
                    } label: {
                        Text(Constants.saveButtonString)
                            .saveButtonStyle()

                        
                    }
                                        
                    
                    
                }
                .padding()
            }
            .navigationBarTitle(Constants.editTaskTitle)
            .navigationSubtitle(Constants.editTaskSubtitle)
        }
        .onAppear{ // responsible for the data to appear at its respective places
            if let entity = entity {
                title = entity.title ?? ""
                description = entity.notes ?? ""
                dueDate = entity.dueDate ?? Date()
                selectedPriority = Int(entity.priorityRaw)
                isCompleted = entity.isCompleted
                selectedCategory = entity.category ?? Constants.othersCategoryString
            }
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                if entity != nil {
                    Button {
                        isShowingSubTasks = true
                    } label: {
                        Text(Constants.subTaskString)
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingSubTasks) {
            if let entity = entity {
                NavigationStack {
                    SubTaskView(parentTask: entity, context: viewModel.container.viewContext)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(Constants.doneButtonString) {
                                    isShowingSubTasks = false
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    // Use a nil entity for creating a new task preview
    TaskDetailView(entity: nil)
        .environmentObject(CoreDataViewModel.preview)
}
