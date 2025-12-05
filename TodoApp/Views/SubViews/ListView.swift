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
                            viewModel.fetchData()
                        }
                    
                    Text(entity.title ?? "No Title")
                    
                    NavigationLink(destination: Text(entity.title ?? "No Title")) { }
                }
                
            }
            .onDelete(perform: viewModel.deleteData)
            .listStyle(.sidebar)
            
        }
        
    }
}

#Preview {
    ListView(item: CoreDataViewModel.preview.savedEntities)
        .environmentObject(CoreDataViewModel.preview)
}
