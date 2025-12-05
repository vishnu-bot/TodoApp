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

    var filteredTasks: [TaskEntity] {
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

