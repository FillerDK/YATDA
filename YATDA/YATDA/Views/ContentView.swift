// ContentView.swift
// Project: YATDA 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 29/10/2025 at 11.06.
// Copyright © 2025 ksd. All rights reserved.
//
// 

import SwiftUI
import Firebase

struct ContentView: View {
    @Environment(Controller.self) private var controller: Controller
    @Environment(AuthStateController.self) private var authStateController: AuthStateController
    @State private var isShowingUpdateReminder = false
    @State private var isAddReminderDialogPresented = false
    @State private var selectedReminder: Reminder?

    private func presentAddReminderView() {
        isAddReminderDialogPresented.toggle()
    }

    var body: some View {
        List(controller.reminders.indices, id: \.self) { index in
            let reminder = controller.reminders[index]
            HStack {
                Image(systemName: reminder.isCompleted
                      ? "largecircle.fill.circle"
                      : "circle")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        var updated = reminder
                        updated.isCompleted.toggle()
                        controller.updateReminder(updated)
                    }

                Text(reminder.title)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button(role: .destructive) {
                    controller.deleteReminder(reminder)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
            // Har ingen funktionel effekt endnu
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                Button {
                    selectedReminder = reminder
                    isShowingUpdateReminder = true
                } label: {
                    Label("Update", systemImage: "pencil")
                }
                .tint(Color(hue: 60/360, saturation: 10, brightness:  0.75))
            }
        }
        
        // toolbars
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: presentAddReminderView) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
        }
        
        // sheets
        // Add reminder
        .sheet(isPresented: $isAddReminderDialogPresented) {
            AddReminderView { reminder in
                controller.addReminder(reminder)
            }
        }
        /*
        // Update reminder
        .sheet(item: $selectedReminder) { reminder in
            UpdateReminderView(reminder: reminder) { updatedReminder in
                controller.update(updatedReminder)
            }
        }
        */
    }
}

#Preview {
    @Previewable @State var authController = AuthStateController()
    
    // Ensure Firebase is configured for previews.
    if FirebaseApp.app() == nil {
        FirebaseApp.configure()
    }

    // Use the real DAL and Controller.
    let controller = Controller(DAL: FirebaseService())

    // Start the subscription so reminders populate in the preview.
    // Using .task in the App isn’t run here, so we call it explicitly.
    controller.start()
    
    return ContentView()
        .environment(controller)
        .environment(authController)
}
