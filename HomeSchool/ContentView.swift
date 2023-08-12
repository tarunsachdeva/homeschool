//
//  ContentView.swift
//  HomeSchool
//
//  Created by Tarun Sachdeva on 2023-08-11.
//

import SwiftUI

// Date formatter for the date
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()

// Date formatter for the time
let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView: View {
    @State private var allActivities: [Activity] = loadActivities()
    @State private var selectedActivities: [String] = UserDefaults.standard.array(forKey: "selectedActivities") as? [String] ?? [] {
        didSet {
            UserDefaults.standard.setValue(selectedActivities, forKey: "selectedActivities")
        }
    }
    
    @State private var welcomeMessage: String = UserDefaults.standard.string(forKey: "welcomeMessage") ?? "" {
        didSet {
            UserDefaults.standard.set(welcomeMessage, forKey: "welcomeMessage")
        }
    }


    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Welcome message (if not empty)
                    if !welcomeMessage.isEmpty {
                        Text(welcomeMessage)
                            .font(.title)
                            .padding()
                    }
                    
                    // Date and Time
                    Text("Today is \(Date(), formatter: dateFormatter)")
                        .font(.title)

                    Text("\(Date(), formatter: timeFormatter)")
                        .font(.title)
                        .padding()

                    Text("Your Activities Today:")
                        .font(.title3)
                        .padding(.leading)
                    
                    // Activities List
                    List(allActivities.filter { selectedActivities.contains($0.id) }) { activity in
                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
                            Text("\(activity.title) (\(activity.timeInMinutes) mins)")
                        }
                    }

                    Spacer()
                }

                VStack {
                    Spacer()

                    HStack {
                        Spacer()

                        NavigationLink(destination: SettingsView(allActivities: allActivities, selectedActivities: $selectedActivities, welcomeMessage: $welcomeMessage)) {
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(15)
                                .padding(.bottom)
                                .padding(.trailing)
                        }
                    }
                }
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
