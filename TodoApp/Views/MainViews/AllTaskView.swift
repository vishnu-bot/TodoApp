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
                ListView(item: sortVM.sortTasks(viewModel.savedEntities))
                
                
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
            .sheet(isPresented: $isPresentingNewTask) {
                NewTaskView()
            }
            .navigationTitle(sortVM.selectedSortOption == .dueDate ? "Sorted - Due Date" : Constants.allTaskString)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sortVM.toggleSort()
                    } label: {
                        Label("Sort", systemImage: sortVM.selectedSortOption == .dueDate ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
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
