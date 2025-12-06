//
//  File.swift
//  TodoApp
//
//  Created by Vishnu on 03/12/25.
//

import Foundation
import SwiftUI


struct Constants {

    
    static let allTaskString = "All Tasks"
    static let searchString = "Search"
    static let dashboardString = "Dashboard"
    static let todaysTaskString = "Today"
    
    static let addTaskString = "Add Task"
    
    
    static let date = Calendar.current.component(.day, from: Date())
    static let todayTaskIcon = "\(date).calendar"
    static let allTaskIcon = "checklist"
    static let searchIcon = "magnifyingglass"
    static let dashboardIcon = "gauge.chart.leftthird.topthird.rightthird"
    
    static let addButtonIcon = "plus"
}


extension Button {
    func addButtonStyle() -> some View {
        self
            .foregroundStyle(.white)
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.red.opacity(0.93)))
                            )
    }
    
    func saveButtonStyle() -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red.opacity(0.83))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
