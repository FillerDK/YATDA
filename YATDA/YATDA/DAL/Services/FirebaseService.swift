//
//  FirebaseService.swift
//  YATDA
//
//  Created by dmu mac 35 on 06/11/2025.
//

import Firebase
import FirebaseFirestore
import Foundation

class FirebaseService: DALProtocol, SubscriberProtocol {
    let dbRef = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?

    func createReminder(_ reminder: Reminder) throws {
        do {
            let ref =
                try dbRef
                .collection("reminders")
                .addDocument(from: reminder)
            print("Document added with ID: \(ref.documentID)")
        } catch {
            print("Error adding document: \(error)")
            throw error
        }
    }

    func updateReminder(_ reminder: Reminder) throws {
        guard let documentId = reminder.id else {
            fatalError("Reminder \(reminder.title) has no document ID.")
        }
        do {
            try dbRef
                .collection("reminders")
                .document(documentId)
                .setData(from: reminder, merge: true)
        } catch {
            print("Error updating document: \(error)")
            throw error
        }
    }

    func deleteReminder(_ reminder: Reminder) throws {
        guard let documentId = reminder.id else {
            fatalError("Reminder \(reminder.title) has no document ID.")
        }
        dbRef
            .collection("reminders")
            .document(documentId)
            .delete()
        print("Document successfully deleted!")
    }

    func subscribe(onUpdate: @escaping ([Reminder]) -> Void) {
        let query = dbRef.collection("reminders")
        
        listenerRegistration = query
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                print("Mapping \(documents.count) documents")
                let reminders = documents.compactMap { queryDocumentSnapshot in
                    do {
                        return try queryDocumentSnapshot.data(as: Reminder.self)
                    }
                    catch {
                        print("Error while trying to map document \(queryDocumentSnapshot.documentID): \(error.localizedDescription)")
                        return nil
                    }
                }
                onUpdate(reminders)
            }
    }

    func unsubscribe() {
        if listenerRegistration != nil {
            listenerRegistration?.remove()
            listenerRegistration = nil
        }
    }
}
