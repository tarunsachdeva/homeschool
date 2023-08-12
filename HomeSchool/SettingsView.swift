//
//  SettingsView.swift
//  HomeSchool
//
//  Created by Tarun Sachdeva on 2023-08-11.
//
import Foundation
import SwiftUI

struct SettingsView: View {
    var allActivities: [Activity]
    @Binding var selectedActivities: [String]
    @Binding var welcomeMessage: String

    var body: some View {
        List(allActivities) { activity in
            Toggle("\(activity.title) (\(activity.timeInMinutes) mins)", isOn: isSelected(activity))
        }
        
        Divider()

        VStack {
            Text("Welcome Message")
            TextField("Enter a welcome message", text: $welcomeMessage)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        }
    }

    private func isSelected(_ activity: Activity) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.selectedActivities.contains(activity.id) },
            set: { newValue in
                if newValue {
                    self.selectedActivities.append(activity.id)
                } else {
                    self.selectedActivities.removeAll { $0 == activity.id }
                }
            }
        )
    }
}
