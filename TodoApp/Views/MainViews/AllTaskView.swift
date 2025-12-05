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
    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottomTrailing) {
                ListView(item: viewModel.savedEntities)
                Button{
                    isPresentingNewTask = true
                } label:{
                    HStack(spacing: 10){
                        Image(systemName: Constants.addButtonIcon)
                        Text(Constants.addTaskString)
                    }
                    
                }
                .addButtonStyle()
                .padding(18)
                
            }
            .sheet(isPresented: $isPresentingNewTask) {
                NewTaskView()
            }
            .navigationTitle(Constants.allTaskString)
        }
        
    }

}

#Preview {
    AllTaskView()
        .environmentObject(CoreDataViewModel.preview)
}
