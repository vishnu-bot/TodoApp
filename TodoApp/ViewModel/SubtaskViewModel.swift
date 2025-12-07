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
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchSubtasks(for task: TaskEntity) {
        // Since we have a relationship, we can just use that, but for a sorted list we might want to sort the set.
        // Or we can fetch from context with a predicate.
        // Let's use the relationship for simplicity if possible, but a fetch request is often safer for updates.
        let request: NSFetchRequest<SubtaskEntity> = SubtaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "parentTask == %@", task)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do {
            subtasks = try context.fetch(request)
        } catch {
            print("Error fetching subtasks: \(error)")
        }
    }
    
    func addNewSubtask(title: String, parentTask: TaskEntity) {
        let newSubtask = SubtaskEntity(context: context)
        newSubtask.subtaskID = UUID()
        newSubtask.title = title
        newSubtask.isCompleted = false
        newSubtask.parentTask = parentTask
        
        saveData()
        fetchSubtasks(for: parentTask)
    }
    
    func toggleSubtask(subtask: SubtaskEntity, parentTask: TaskEntity) {
        subtask.isCompleted.toggle()
        saveData()
        fetchSubtasks(for: parentTask)
    }
    
//    func deleteSubtask(subtask: SubtaskEntity, parentTask: TaskEntity) {
//        context.delete(subtask)
//        saveData()
//        fetchSubtasks(for: parentTask)
//    }
    
    func deleteSubtask(at offsets: IndexSet, parentTask: TaskEntity) {
        for index in offsets {
            let subtask = subtasks[index]
            context.delete(subtask)
        }
        saveData()
        fetchSubtasks(for: parentTask)
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving subtask data: \(error)")
        }
    }
}
