//
//  SortViewModel.swift
//  TodoApp
//
//  Created by Vishnu on 06/12/25.
//

import SwiftUI
import Foundation
import Combine

class SortViewModel: ObservableObject {
    
    enum SortOption: String, CaseIterable {
        case defaultOrder = "Default"
        case dueDate = "DueDate"
    }
    
    @Published var selectedSortOption: SortOption = .defaultOrder
    
    func sortTasks(_ tasks: [TaskEntity]) -> [TaskEntity] {
        switch selectedSortOption {
        case .defaultOrder:
            return tasks
        case .dueDate:
            return tasks.sorted { $0.dueDate ?? Date.now < $1.dueDate ?? Date.now}
        }
    }
    
    func toggleSort() {
        if selectedSortOption == .defaultOrder {
            selectedSortOption = .dueDate
        } else {
            selectedSortOption = .defaultOrder
        }
    }
}
