//
//  Login.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/18/23.
//

import SwiftUI

struct Login: View {
  @EnvironmentObject var session: SessionManager
  @State var firstName = ""
  @State var lastName = ""
  @State var email = ""
  @State var isLoggedIn = false
  @State var showingAlert = false

  var body: some View {
    NavigationView {
      VStack {
        LogoView()
        HeroView()

        VStack(alignment: .leading) {
          CustomTextField(valueField: $firstName, nameField: "First Name *", defaultField: "Tilly")
          CustomTextField(valueField: $lastName, nameField: "Last Name *", defaultField: "Doe")
          CustomTextField(valueField: $email, nameField: "Email *", defaultField: "tillydoe@example.com")
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)

          Spacer()

          Button {
            validateAndSaveData(firstName: firstName, lastName: lastName, email: email)
          } label: {
            ZStack {
              RoundedRectangle(cornerRadius: 10)
                .frame(height: 44)
                .foregroundColor(Color.Theme.yellowLL)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.Theme.orangeLL, lineWidth: 1)
                )

              Text("Register")
                .font(Font.Theme.logInOutButton)
                .foregroundColor(Color.Theme.blackLL)
            }
          }
        }
        .padding()

        Spacer()
      }
      .onAppear() {
        if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
          //MARK: - If you want to see the preview comment next row
          session.signIn()
        }
      }
      .padding()
      .alert("Please fill in all required fields correctly!", isPresented: $showingAlert) {
        Button("OK", role: .cancel) { }
      }
    }
  }

  func validateAndSaveData(firstName: String, lastName: String, email: String) {
    if isValidName(firstName) &&
        isValidFamilyName(lastName) &&
        isValidEmail(email: email) {

      isLoggedIn = true
      session.signIn()
      UserDefaults.standard.set(firstName, forKey: kFirstName)
      UserDefaults.standard.set(lastName, forKey: kLastName)
      UserDefaults.standard.set(email, forKey: kEmail)
      UserDefaults.standard.set(isLoggedIn, forKey: kIsLoggedIn)

    } else {
      showingAlert = true
    }
  }

}

func isValidName(_ name: String) -> Bool {
  let nameRegex = "^[A-Za-z]+$"
  let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
  return namePredicate.evaluate(with: name) && name.count >= 2
}

func isValidFamilyName(_ familyName: String) -> Bool {
  let familyNameRegex = "^[A-Za-z-]+$"
  let familyNamePredicate = NSPredicate(format: "SELF MATCHES %@", familyNameRegex)
  return familyNamePredicate.evaluate(with: familyName) && familyName.count >= 2
}

func isValidEmail(email: String) -> Bool {
  let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
  let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
  return emailPredicate.evaluate(with: email) && email.count >= 8
}

//MARK: - If you want to see the preview need to comment row - 58
//#Preview {
//  Login()
//}
