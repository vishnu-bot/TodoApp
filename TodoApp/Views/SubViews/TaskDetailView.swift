//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by Vishnu on 04/12/25.
//

import SwiftUI

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
    @State private var categories: [String] = [ "Work", "Personal","Others"]
    @State private var selectedCategory: String = "Others"
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(spacing:35){
                    VStack(alignment: .leading){
                        Text("Task")
                            .font(.subheadline)
                        TextField("New Task", text: $title)
                            .padding()
                            .cornerRadius(8)
                            .background(Color(.secondarySystemBackground))
                    }
                    
                    VStack(alignment: .leading){
                        Text("Description")
                            .font(.subheadline)
                        TextEditor(text: $description)
                            .frame(minHeight: 120)
                            .padding(8)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)
                    }
                    
                    Toggle("Task Completed", isOn:$isCompleted)
                        .onChange(of: isCompleted) { _ in
                            viewModel.toggleUpdate(isCompleted: isCompleted, entity: entity!)
                        }
                    
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    
                    
                    HStack{
                        
                        Text("Task Priority")
                        Spacer()
                        Picker("Priority", selection: $selectedPriority) {
                            ForEach(priorities, id: \.self) { priority in
                                Text("Priority Level \(priority)").tag(priority)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    VStack(alignment: .leading){
                        Text("Task Category")
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
                        Text("Save")
                            .saveButtonStyle()

                        
                    }
                                        
                    
                    
                }
                .padding()
            }
            .navigationBarTitle("Edit Task")
        }
        .onAppear{
            if let entity = entity {
                title = entity.title ?? ""
                description = entity.notes ?? ""
                dueDate = entity.dueDate ?? Date()
                selectedPriority = Int(entity.priorityRaw)
                isCompleted = entity.isCompleted
                selectedCategory = entity.category ?? "Others"
            }
        }
    }
}

#Preview {
    // Use a nil entity for creating a new task preview
    TaskDetailView(entity: nil)
        .environmentObject(CoreDataViewModel.preview)
}
