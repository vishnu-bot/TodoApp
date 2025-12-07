//
//  SubTaskView.swift
//  TodoApp
//
//  Created by Vishnu on 07/12/25.
//

import SwiftUI
internal import CoreData

struct SubTaskView: View {
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    @StateObject var viewModel: SubtaskViewModel
    let parentTask: TaskEntity
    
    @State private var newSubtaskTitle: String = ""
    @FocusState private var isFocused: Bool
    
    init(parentTask: TaskEntity, context: NSManagedObjectContext) {
        self.parentTask = parentTask
        _viewModel = StateObject(wrappedValue: SubtaskViewModel(context: context))
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.subtasks as [SubtaskEntity], id: \.objectID) { subtask in
                    HStack {
                        Image(systemName: (subtask.isCompleted ? "checkmark.circle.fill" : "circle"))
                            .foregroundColor(subtask.isCompleted ? .red : .gray)
                            .onTapGesture {
                                viewModel.toggleSubtask(subtask: subtask, parentTask: parentTask)
                            }
                        
                        Text(subtask.title ?? "")
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteSubtask(at: indexSet, parentTask: parentTask)
                }
            }
            .listStyle(.plain)
            
            HStack {
                TextField("Add new subtask...", text: $newSubtaskTitle)
                    .cornerRadius(8)
                    .background(Color(.secondarySystemBackground))
                    .focused($isFocused)
                    .submitLabel(.done)
                    .onSubmit {
                        addSubtask()
                    }
                
                Button {
                    addSubtask()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
                .disabled(newSubtaskTitle.isEmpty)
            }
            .padding()
            .background(Color(.systemBackground))
        }
        .navigationTitle("Subtasks")
        .onAppear {
            viewModel.fetchSubtasks(for: parentTask)
        }
    }
    
    private func addSubtask() {
        guard !newSubtaskTitle.isEmpty else { return }
        viewModel.addNewSubtask(title: newSubtaskTitle, parentTask: parentTask)
        newSubtaskTitle = ""
        isFocused = true
    }
}
