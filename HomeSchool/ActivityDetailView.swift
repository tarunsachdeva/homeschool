//
//  ActivityDetailView.swift
//  HomeSchool
//
//  Created by Tarun Sachdeva on 2023-08-11.
//

import Foundation

import SwiftUI

struct ActivityDetailView: View {
    var activity: Activity
    @State private var timeRemaining: Int
    @State private var isRunning: Bool = false
    @State private var timer: Timer?

    init(activity: Activity) {
        self.activity = activity
        _timeRemaining = State(initialValue: activity.timeInMinutes * 60)
    }

    var body: some View {
        VStack {
            // Image or Video (using a placeholder for now)
            Text("\(timeRemaining / 60) minutes \(timeRemaining % 60) seconds remaining")
                .font(.title)
            
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            // Description
            Text(activity.description)
                .font(.body)
                .padding()
            
            if !isRunning {
                Button("Start") {
                    startCountdown()
                }.padding()
            }
        }
        .navigationTitle(activity.title)
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func startCountdown() {
        isRunning = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { tempTimer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                tempTimer.invalidate()
                isRunning = false
            }
        }
    }
}
