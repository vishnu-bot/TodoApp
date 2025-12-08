//
//  SearchViewModel.swift
//  TodoApp
//
//  Created by Vishnu on 05/12/25.
//

import Foundation
import Combine
import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    let coreData = CoreDataViewModel()
    
    
//    @State private var categories: [String] = ["All", "Work", "Personal", "Others"]
    @State private var category: String = "All"
    
    enum categories: String{
        case all = "All"
        case work = "Work"
        case personal = "Personal"
        case others = "Others"
    }

    // This function Filters tasks based on categories, and searches for specify task.
    // It can also search tasks within a filtered category.
    // Working is displayed in SearchView (the Search page in the app)
    func filteredTasks(category: String) -> [TaskEntity] {
        coreData.fetchData()
        if(category == "Others"){
            
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return coreData.savedEntities.filter { $0.category == "Others"}
            } else {
                return coreData.savedEntities.filter { $0.category == "Others" && ($0.title ?? "").localizedCaseInsensitiveContains(searchText) }
            }
        } else if (category == "Work"){
            
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return coreData.savedEntities.filter { $0.category == "Work"}
            } else {
                return coreData.savedEntities.filter { $0.category == "Work" && ($0.title ?? "").localizedCaseInsensitiveContains(searchText) }
            }
        } else if (category == "Personal"){
            
            if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return coreData.savedEntities.filter { $0.category == "Personal"}
            } else {
                return coreData.savedEntities.filter { $0.category == "Personal" && ($0.title ?? "").localizedCaseInsensitiveContains(searchText) }
            }
        }
        coreData.fetchData()
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return coreData.savedEntities
        } else {
            return coreData.savedEntities.filter { ($0.title ?? "").localizedCaseInsensitiveContains(searchText) }
        }
        
        
    }

    func getSearchTask(by title: String) {
        self.searchText = title
    }
}

