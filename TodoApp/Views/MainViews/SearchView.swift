//
//  SearchView.swift
//  TodoApp
//
//  Created by Vishnu on 05/12/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchVM = SearchViewModel()
    // Items for the Picker below the search bar.
    @State private var categories: [String] = ["All", Constants.workCategoryString, Constants.personalCategoryString, Constants.othersCategoryString]
    @State private var category: String = "All"
    var body: some View {
        NavigationStack {
            
            // Picker with different Categories ("All tasks", "Work related tasks", "Personal Tasks", "Other task Categories") to choose from.
            VStack{
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) { cat in
                        Text(cat).tag(cat)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                
            }
        // Gets the all tasks depending on the categories chose or searched task or combination of both
            ListView(item: searchVM.filteredTasks(category: category))
                .searchable(text: $searchVM.searchText, prompt: "Search tasks")
                .navigationTitle(Constants.searchString)

        }
    }
}

#Preview {
    SearchView()
        .environmentObject(CoreDataViewModel.preview)
        
}
