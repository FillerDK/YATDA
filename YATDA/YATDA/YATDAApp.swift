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

