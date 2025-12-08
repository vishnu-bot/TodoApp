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
    
    // This function is responsible for the sort functionality in AllTaskView (2nd screen the apps tabView)
    // This function returns a array of task Lists based on its dueDates
    // It has a additional functionality, where it return only the future task (not the past dated tasks) for better UX
    func sortTasks(_ tasks: [TaskEntity]) -> [TaskEntity] {
        switch selectedSortOption {
        case .defaultOrder:
            return tasks
        case .dueDate:
        // Filters out the tasks that are not due today and sorts them based on their due dates
            return tasks.filter { ($0.dueDate ?? Date()) >= Constants.todayDate }
                        .sorted { ($0.dueDate ?? Date()) < ($1.dueDate ?? Date()) }
        }
    }
    
    // toggles the sort vice versa
    func toggleSort() {
        if selectedSortOption == .defaultOrder {
            selectedSortOption = .dueDate
        } else {
            selectedSortOption = .defaultOrder
        }
    }
}
