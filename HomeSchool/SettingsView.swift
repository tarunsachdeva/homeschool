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
        VStack {
            Text("Settings")
                .font(.title3)
                .padding()
            
            Divider()
            
            HStack {
                Text("Customize Activity List")
                    .font(.headline)
                    .padding(.leading)
                Spacer()  // Pushes the Text to the left
            }

            List(allActivities) { activity in
                Toggle("\(activity.title) (\(activity.timeInMinutes) mins)", isOn: isSelected(activity))
            }
            
            HStack {
                Text("Custom Welcome Message")
                    .font(.headline)
                    .padding(.leading)
                Spacer()  // Pushes the Text to the left
            }

            TextField("Enter a welcome message", text: $welcomeMessage)
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
