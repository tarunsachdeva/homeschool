//
//  Activity.swift
//  HomeSchool
//
//  Created by Tarun Sachdeva on 2023-08-11.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id: String
    var title: String
    var description: String
    let timeInMinutes: Int
}

func loadActivities() -> [Activity] {
    guard let url = Bundle.main.url(forResource: "activities", withExtension: "json") else {
        fatalError("Could not find activities.json in the bundle.")
    }

    do {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Activity].self, from: data)
    } catch {
        fatalError("Could not load activities: \(error)")
    }
}
