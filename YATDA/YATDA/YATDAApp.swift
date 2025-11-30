// YATDAApp.swift
// Project: YATDA 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 29/10/2025 at 11.06.
// Copyright © 2025 ksd. All rights reserved.
//
// 

import SwiftUI
import Firebase

@main
struct YATDAApp: App {
    
    init() {
        FirebaseApp.configure()
        controller = Controller(DAL: FirebaseService())
        authStateController = AuthStateController()
    }
    
    @State var controller: Controller
    @State var authStateController: AuthStateController
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(controller)
                .environment(authStateController)
                .task {
                    controller.start()
                }
                .navigationTitle("Reminders")
        }
    }
}

