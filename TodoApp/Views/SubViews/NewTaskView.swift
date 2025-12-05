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
    @State private var newTask: String = ""
    @State private var description: String = ""
    @State private var dueDate: Date = Calendar.current.startOfDay(for: Date())
    @State private var priorities: [Int] = [1, 2, 3]
    @State private var selectedPriority: Int = 3
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack(spacing:35){
                    VStack(alignment: .leading){
                        Text("Task")
                            .font(.subheadline)
                        TextField("New Task", text: $newTask)
                            .padding()
                            .cornerRadius(8)
                            .background(Color(.secondarySystemBackground))
                    }
                    
                    VStack(alignment: .leading){
                        Text("Decription")
                            .font(.subheadline)
                        TextEditor(text: $description)
                            .frame(minHeight: 120)
                            .padding(8)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(8)
                    }
                    
                    
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                        
                    
                    HStack{
                        
                        Text("Choose Task Priority")
                        Spacer()
                        Picker("Priority", selection: $selectedPriority) {
                            ForEach(priorities, id: \.self) { priority in
                                Text("Priority Level \(priority)").tag(priority)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Button{
                        guard !newTask.isEmpty else { return }
                        viewModel.addTaskData(title: newTask, notes: description, dueDate: dueDate, isCompleted: false, priority: Int16(selectedPriority))
//                        viewModel.saveData()
                        newTask = ""
                        description = ""
                        dismiss()
                    } label: {
                        Text("Save")
                        
                        
                    }
                    
                    
                    
                }
                .padding()
            }
            .navigationBarTitle("Add New Task")
        }
        
    }
}

#Preview {
    NewTaskView()
        .environmentObject(CoreDataViewModel.preview)
}
