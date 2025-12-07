//
//  HomeView.swift
//  TodoApp
//
//  Created by Vishnu on 04/12/25.
//

import SwiftUI

struct HomeView: View {
    @State private var isPresentingNewTask = false
    @EnvironmentObject var viewModel: CoreDataViewModel
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing) {
                ListView(item: viewModel.todayItems)
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
            
            .navigationTitle(Constants.todaysTaskString)
        }
        
    }
}

#Preview {
    HomeView()
        .environmentObject(CoreDataViewModel.preview)
}
