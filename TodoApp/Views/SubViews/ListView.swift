//
//  ListView.swift
//  TodoApp
//
//  Created by Vishnu on 04/12/25.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var viewModel: CoreDataViewModel
    var item: [TaskEntity]
    var body: some View {
        
        //List View of tasks
        List{
            ForEach(item) { entity in
                HStack{
                    Image(systemName: entity.isCompleted ? Constants.checkedIcon : Constants.uncheckedIcon)
                        .foregroundColor(entity.isCompleted ? .red.opacity(0.93) : .gray)
                        .onTapGesture {
                            entity.isCompleted.toggle()
                            viewModel.saveData()
                        }
                    
                    Text(entity.title ?? "No Title")
                        .foregroundColor(entity.dueDate ?? Date() < Constants.todayDate && !entity.isCompleted ? .red : .primary)
                    
                    // Clicking the list, guides us to the detailed information of a particular task
                    NavigationLink(destination: TaskDetailView(entity: entity)) { }
                }
                
            }
            // Delete Functionality
            .onDelete { indexSet in
                for index in indexSet {
                    let entity = item[index]
                    viewModel.deleteTask(entity: entity)
                }
            }
            .listStyle(.plain)
            
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    ListView(item: CoreDataViewModel.preview.savedEntities)
        .environmentObject(CoreDataViewModel.preview)
}
