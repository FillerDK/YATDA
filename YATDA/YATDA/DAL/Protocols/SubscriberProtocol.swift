//
//  SubscriberProtocol.swift
//  YATDA
//
//  Created by dmu mac 35 on 06/11/2025.
//

import Foundation

protocol SubscriberProtocol {
    func subscribe(onUpdate: @escaping ([Reminder]) -> Void)
    func unsubscribe()
}
