//
//  SearchView.swift
//  TodoApp
//
//  Created by Vishnu on 05/12/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var searchVM = SearchViewModel()
    @State private var categories: [String] = ["All", "Work", "Personal", "Others"]
    @State private var category: String = "All"
    var body: some View {
        NavigationStack {
            
            VStack{
                Picker("Category", selection: $category) {
                    ForEach(categories, id: \.self) { cat in
                        Text(cat).tag(cat)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
//                .background(Color(.secondarySystemBackground))
                
            }
            
            ListView(item: searchVM.filteredTasks(category: category))
                .searchable(text: $searchVM.searchText, prompt: "Search tasks")
                .navigationTitle("Search")

        }
    }
}

#Preview {
    SearchView()
        .environmentObject(CoreDataViewModel.preview)
        
}
