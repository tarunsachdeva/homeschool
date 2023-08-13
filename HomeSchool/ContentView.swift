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
    formatter.timeStyle = .short
    return formatter
}()

struct ContentView: View {
    @State private var currentDate = Date()
    @State private var allActivities: [Activity] = loadActivities()
    @State private var selectedActivities: [String] = UserDefaults.standard.array(forKey: "selectedActivities") as? [String] ?? [] {
        didSet {
            UserDefaults.standard.setValue(selectedActivities, forKey: "selectedActivities")
        }
    }
    
    @State private var welcomeMessage: String = UserDefaults.standard.string(forKey: "welcomeMessage") ?? "Welcome!" {
        didSet {
            UserDefaults.standard.set(welcomeMessage, forKey: "welcomeMessage")
        }
    }

    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            currentDate = Date()
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
                    Text("Today is \(currentDate, formatter: dateFormatter)")
                        .font(.title)

                    Text("\(currentDate, formatter: timeFormatter)")
                        .font(.title)
                        .padding()


                    HStack {
                        Text("Your Activities Today:")
                            .font(.title3)
                            .padding(.leading)
                        Spacer()  // Pushes the Text to the left
                    }

                    
                    // Activities List
                    List(allActivities.filter { selectedActivities.contains($0.id) }) { activity in
                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
                            Text("\(activity.title) (\(activity.timeInMinutes) mins)")
                        }
                    }

                    Spacer()
                }.onAppear(perform: startTimer)

                VStack {
                    Spacer()

                    HStack {
                        Spacer()

                        NavigationLink(destination: SettingsView(allActivities: allActivities, selectedActivities: $selectedActivities, welcomeMessage: $welcomeMessage)) {
                              Text("Settings")
//                            Image(systemName: "gear")
//                                .resizable()
//                                .frame(width: 24, height: 24)
//                                .padding()
//                                .background(Color.accentColor)
//                                .foregroundColor(.white)
//                                .cornerRadius(15)
//                                .padding(.bottom)
//                                .padding(.trailing)
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
