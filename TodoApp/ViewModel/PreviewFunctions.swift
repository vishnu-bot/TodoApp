//
//  PreviewFunctions.swift
//  TodoApp
//
//  Created by Vishnu on 04/12/25.
//

import Foundation
internal import CoreData

extension CoreDataViewModel {
    static var preview: CoreDataViewModel {
        let vm = CoreDataViewModel(inMemory: true)
        let viewContext = vm.container.viewContext
        
        for i in 0...5 {
            let newTask = TaskEntity(context: viewContext)
            newTask.id = UUID()
            newTask.title = "Sample Task \(i)"
            newTask.notes = "This is a sample note for task \(i)"
            newTask.dueDate = Date()
            newTask.priorityRaw = 1
            newTask.isCompleted = false        }
        
        try? viewContext.save()
        vm.fetchData()
        return vm
    }
}
