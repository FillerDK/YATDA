//
//  UpdateReminderView.swift
//  YATDA
//
//  Created by dmu mac 35 on 28/11/2025.
//

import SwiftUI

struct UpdateReminderView: View {
    enum FocusableField: Hashable {
        case title
    }

    @FocusState
    private var focusedField: FocusableField?

    @State
    private var reminder: Reminder     // lokal kopi som du redigerer i

    @Environment(\.dismiss)
    private var dismiss

    let onCommit: (_ reminder: Reminder) -> Void

    private func commit() {
        onCommit(reminder)
        dismiss()
    }

    private func cancel() {
        dismiss()
    }

    init(reminder: Reminder, onCommit: @escaping (_ reminder: Reminder) -> Void) {
        _reminder = State(initialValue: reminder)   // vigtig!
        self.onCommit = onCommit
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $reminder.title)
                    .focused($focusedField, equals: .title)
            }
            .navigationTitle("Edit Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: cancel) {
                        Text("Cancel")
                    }
                    .buttonStyle(.borderedProminent)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: commit) {
                        Text("Update")
                    }
                    .disabled(reminder.title.isEmpty)
                    .buttonStyle(.borderedProminent)
                }
            }
            .onAppear {
                focusedField = .title
            }
        }
    }
}


#Preview {
    /*
    UpdateReminderView(
        reminder: Reminder(title: "Test"),
        onCommit: { reminder in
        print("Reminder updated with title: \(reminder.title)")
    })
    */
}
