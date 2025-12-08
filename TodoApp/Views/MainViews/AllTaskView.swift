//
//  AllTaskView.swift
//  TodoApp
//
//  Created by Vishnu on 04/12/25.
//

import SwiftUI

struct AllTaskView: View {
    @State private var isPresentingNewTask = false
    @EnvironmentObject private var viewModel: CoreDataViewModel
    @StateObject private var sortVM = SortViewModel()
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing) {
                // Returns the List of all tasks
                ListView(item: sortVM.sortTasks(viewModel.savedEntities))
                
                // Button to Add new task.
                Button{
                    isPresentingNewTask = true
                } label:{
                    HStack(spacing: 10){
                        Image(systemName: Constants.addButtonIcon)
                        Text(Constants.addTaskString)
                    }
                    .addButtonStyle()
                }
                .padding(18)
                
                
            }
            // Opens a new sub page for the NewTaskView()
            .sheet(isPresented: $isPresentingNewTask) {
                NewTaskView()
            }
            .navigationTitle(sortVM.selectedSortOption == .dueDate ? Constants.preSortedTitle : Constants.allTaskString)
            // Button to enable sort Functionality
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sortVM.toggleSort()
                    } label: {
                        Label("Sort", systemImage: sortVM.selectedSortOption == .dueDate ? Constants.preSortIcon : Constants.postSortIcon)
                    }
                }
            }
            
        }
    }

}

#Preview {
    AllTaskView()
        .environmentObject(CoreDataViewModel.preview)
}
