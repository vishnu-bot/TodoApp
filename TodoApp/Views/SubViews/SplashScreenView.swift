//
//  SplashScreenView.swift
//  TodoApp
//
//  Created by Vishnu on 09/12/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive: Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    Image("Image") // Ensure this image name matches your asset catalog
                        .resizable()
                        .scaledToFit()
                        .frame(width: 153, height: 123)
                    
                    Text("TodoApp")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.secondary)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            // Use a background color if your splash screen has one, otherwise default system background
//            .background(Color.black) // Assuming dark background based on white text
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
        .environmentObject(CoreDataViewModel.preview)
}
