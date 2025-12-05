//
//  Model.swift
//  TodoApp
//
//  Created by Vishnu on 03/12/25.
//

import CoreData
import Foundation
import Combine

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [TaskEntity] = []
    
    init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "TodoContainer")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("There was a problem loading the date from CORE DATA: \(error)")
            } else {
                print("date fetched from CORE DATA")
            }
                
        }
        fetchData()
        
    }
    

    // Refreshs or gets the stored data from CORE DATA
    func fetchData(){
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        do{
            savedEntities = try container.viewContext.fetch(request)
        }catch{
            print("There was a problem fetching the data from CORE DATA: \(error)")
        }
    }
    
    // function to add the data to the CORE DATA
    func addTaskData(title: String, notes: String?, dueDate: Date, isCompleted: Bool, priority: Int16){
        let newTask = TaskEntity(context: container.viewContext)
        newTask.id = UUID()
        newTask.title = title
        newTask.notes = notes ?? ""
        newTask.createdAt = Date.now
        newTask.updatedAt = Date.now
        newTask.dueDate = dueDate
        newTask.priorityRaw = priority
        newTask.isCompleted = isCompleted
        saveData()
    }
    
    func updateTaskData(title: String, notes: String?, dueDate: Date, isCompleted: Bool, priority: Int16, entity: TaskEntity){
        entity.title = title ?? entity.title
        entity.notes = notes ?? entity.notes
        entity.updatedAt = Date.now
        entity.dueDate = dueDate
        entity.priorityRaw = priority
        entity.isCompleted = isCompleted
        saveData()
        
        
    }
    
    // function to delete from DB
    func deleteData(indexSet: IndexSet){
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    // saves the data from UI to CORE DATA
    func saveData(){
        do{
            try container.viewContext.save()
            fetchData()
        } catch let error {
            print("Error saving data to Core Data: \(error)")
        }
    }
    
    // Return today due dated tasks and uncompleted tasks to today HomeView
    var todayItems: [TaskEntity] {
        savedEntities.filter { entity in
            guard let due = entity.dueDate else { return false }
            return (Calendar.current.isDateInToday(due) && entity.isCompleted == false)
        }
    }
    
    //used to update toggle button in TaskDetailView with needing to click save button
    func toggleUpdate(isCompleted: Bool, entity: TaskEntity){
        entity.isCompleted = isCompleted
        saveData()
    }
}
