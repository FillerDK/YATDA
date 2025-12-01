import Foundation
import FirebaseAuth

@Observable
class AuthStateController {
    var authenticationState: AuthenticationState = .unauthenticated
    var user: FirebaseAuth.User?
    var displayName = ""

    // Keep a reference to the Firebase Auth state change listener
    private var authStateHandler: AuthStateDidChangeListenerHandle?

    init() {
        registerAuthStateHandler()
    }

    deinit {
        if let authStateHandler {
            Auth.auth().removeStateDidChangeListener(authStateHandler)
        }
    }

    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { _, user in
                self.user = user
                self.authenticationState = (user == nil) ? .unauthenticated : .authenticated
                self.displayName = user?.email ?? ""
            }
        }
    }
}
