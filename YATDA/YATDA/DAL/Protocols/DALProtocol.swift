import Foundation

protocol DALProtocol {
    // crud funcs - r
    func createReminder(_ reminder: Reminder) throws
    func updateReminder(_ reminder: Reminder) throws
    func deleteReminder(_ reminder: Reminder) throws
    func subscribe(onUpdate: @escaping ([Reminder]) -> Void)
}
