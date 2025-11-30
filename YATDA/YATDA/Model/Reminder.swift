// Reminder.swift
// Project: YATDA
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 29/10/2025 at 11.24.
// Copyright © 2025 ksd. All rights reserved.
//
//

import Foundation
import FirebaseFirestore


struct Reminder: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var isCompleted = false
}

extension Reminder {
    static let samples = [
        Reminder(title: "Build sample app", isCompleted: true),
        Reminder(title: "Create tutorial"),
        Reminder(title: "Praise swift", isCompleted: true),
        Reminder(title: "Graduate from Swift Bootcamp"),
    ]
}
