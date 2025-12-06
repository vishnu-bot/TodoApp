//
//  ContentView.swift
//  TodoApp
//
//  Created by Vishnu on 03/12/25.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView{
            Tab(Constants.todaysTaskString, systemImage: Constants.todayTaskIcon){
                HomeView()
            }
            Tab(Constants.allTaskString, systemImage: Constants.allTaskIcon){
                AllTaskView()
            }
            Tab(Constants.searchString, systemImage: Constants.searchIcon){
                SearchView()
            }
            Tab(Constants.dashboardString, systemImage: Constants.dashboardIcon){
                DashboardView()
            }
        }
        .tint(Color(.red))
    }
}

#Preview {
    ContentView()
        .environmentObject(CoreDataViewModel.preview)
}
