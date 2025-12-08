//
//  SubtaskViewModel.swift
//  TodoApp
//
//  Created by Vishnu on 07/12/25.
//

import Foundation
internal import CoreData
import Combine

class SubtaskViewModel: ObservableObject {
    
    let context: NSManagedObjectContext
    @Published var subtasks: [SubtaskEntity] = []
    
    // Establishes a connection to the Core Data context
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // This function is responsible for fetching the subtasks for a specific task (i.e. from its parent task)
    func fetchSubtasks(for task: TaskEntity) {
        let request: NSFetchRequest<SubtaskEntity> = SubtaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "parentTask == %@", task)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do {
            subtasks = try context.fetch(request)
        } catch {
            print("Error fetching subtasks: \(error)")
        }
    }
    
    // This function is responsible for adding a new subtask to the database
    func addNewSubtask(title: String, parentTask: TaskEntity) {
        let newSubtask = SubtaskEntity(context: context)
        newSubtask.subtaskID = UUID()
        newSubtask.title = title
        newSubtask.isCompleted = false
        newSubtask.parentTask = parentTask
        
        saveData()
        fetchSubtasks(for: parentTask)
    }
    
    // This function is responsible for toggling the completion status of a subtask
    func toggleSubtask(subtask: SubtaskEntity, parentTask: TaskEntity) {
        subtask.isCompleted.toggle()
        saveData()
        // Fetches the updated subtasks for the parent task
        fetchSubtasks(for: parentTask)
    }
    
//    func deleteSubtask(subtask: SubtaskEntity, parentTask: TaskEntity) {
//        context.delete(subtask)
//        saveData()
//        fetchSubtasks(for: parentTask)
//    }
    
    // This function is responsible for deleting a subtask from the database
    func deleteSubtask(at offsets: IndexSet, parentTask: TaskEntity) {
        for index in offsets {
            let subtask = subtasks[index]
            context.delete(subtask)
        }
        saveData()
        fetchSubtasks(for: parentTask)
    }
    
    // This function is responsible for saving the subtask data to the database
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving subtask data: \(error)")
        }
    }
}
