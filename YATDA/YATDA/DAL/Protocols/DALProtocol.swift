//
//  DALProtocol.swift
//  YATDA
//
//  Created by dmu mac 35 on 06/11/2025.
//

import Foundation

protocol DALProtocol {
    // crud funcs - r
    func createReminder(_ reminder: Reminder) throws
    func updateReminder(_ reminder: Reminder) throws
    func deleteReminder(_ reminder: Reminder) throws
    func subscribe(onUpdate: @escaping ([Reminder]) -> Void)
}
