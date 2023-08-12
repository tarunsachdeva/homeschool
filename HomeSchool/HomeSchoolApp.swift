//
//  HomeSchoolApp.swift
//  HomeSchool
//
//  Created by Tarun Sachdeva on 2023-08-11.
//

import SwiftUI

@main
struct YourApp: App {
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Show splash for 3 seconds
                            showSplash = false
                        }
                    }
            } else {
                // Your main ContentView or initial view
                ContentView()
            }
        }
    }
}
