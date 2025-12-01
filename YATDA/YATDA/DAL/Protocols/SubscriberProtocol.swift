import Foundation

protocol SubscriberProtocol {
    func subscribe(onUpdate: @escaping ([Reminder]) -> Void)
    func unsubscribe()
}
