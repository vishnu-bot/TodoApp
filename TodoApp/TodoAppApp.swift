//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Vishnu on 03/12/25.
//

import SwiftUI

@main

struct TodoAppApp: App {
    @StateObject private var viewModel = CoreDataViewModel()
    
    init() {
        NotificationManager.shared.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(viewModel)
        }
    }
}
