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
        List{
            ForEach(item) { entity in
                HStack{
                    Image(systemName: entity.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(entity.isCompleted ? .red.opacity(0.93) : .gray)
                        .onTapGesture {
                            entity.isCompleted.toggle()
                            viewModel.saveData()
                        }
                    
                    Text(entity.title ?? "No Title")
                    //add modifier to make the text red if task is overdued
                    
                    NavigationLink(destination: TaskDetailView(entity: entity)) { }
                }
                
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let entity = item[index]
                    viewModel.deleteTask(entity: entity)
                }
            }
            .listStyle(.plain)
            
        }
        .scrollContentBackground(.hidden)
//        .background(Color.black.opacity(0.1))
    }
}

#Preview {
    ListView(item: CoreDataViewModel.preview.savedEntities)
        .environmentObject(CoreDataViewModel.preview)
}
