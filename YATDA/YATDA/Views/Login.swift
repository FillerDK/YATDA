//
//  Login.swift
//  YATDA
//
//  Created by dmu mac 35 on 20/11/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedIn: Bool = false
    @State private var errorMessage: String? = nil
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button(action: { login() }) {
                Text("Sign in")
            }
        }
        .padding()
    }
    
    // SKAL IKKE VÆRE HER. Skal i AuthenticateService
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {

                print("success")
            }
        }
    }
    
    @MainActor
    func signIn() async {
        do {
            let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
            let user = authDataResult.user
            
            print("Signed in as user \(user.uid), with email: \(user.email ?? "")")
            self.isSignedIn = true
        }
        catch {
            print("There was an issue when trying to sign in: \(error)")
            self.errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    Login()
}
