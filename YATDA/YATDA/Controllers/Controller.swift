//
//  Controller.swift
//  YATDA
//
//  Created by dmu mac 35 on 06/11/2025.
//

import Foundation

@Observable
class Controller {
    var reminders: [Reminder] = []
    var DAL: any DALProtocol
    
    init (DAL: any DALProtocol) {
        self.DAL = DAL
    }
    
    func start() {
        DAL.subscribe { [weak self] reminders in
            if Thread.isMainThread {
                self?.reminders = reminders
            } else {
                DispatchQueue.main.async {
                    self?.reminders = reminders
                }
            }
        }
    }
    // add crud funcs
    func addReminder(_ reminder: Reminder) {
        do {
            try DAL.createReminder(reminder)
        } catch {
            print("Error adding reminder")
        }
    }
    
    func updateReminder(_ reminder: Reminder) {
        do {
            try DAL.updateReminder(reminder)
        } catch {
            print("Error updating reminder")
        }
    }
    
    func deleteReminder(_ reminder: Reminder) {
        do {
            try DAL.deleteReminder(reminder)
        } catch {
            print("Error deleting reminder")
        }
    }
}

