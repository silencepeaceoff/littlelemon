//
//  UserProfile.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/18/23.
//

import SwiftUI

struct UserProfile: View {
  @Environment(\.presentationMode) var presentation
  @EnvironmentObject var tabManager: TabManager
  @EnvironmentObject var session: SessionManager

  @State var orderStatus = UserDefaults.standard.bool(forKey: kOrderStatus)
  @State var passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
  @State var specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
  @State var newsletter = UserDefaults.standard.bool(forKey: kNewsletter)

  @State var avatarImg = UserDefaults.standard.string(forKey: kAvatarImage) ?? "Profile"
  @State var firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
  @State var lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
  @State var email = UserDefaults.standard.string(forKey: kEmail) ?? ""
  @State var phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""

  var body: some View {
    NavigationView {
      ScrollView {
        LogoView(
          isUserProfile: true
        )
        VStack(alignment: .leading) {
          Text("Personal information")
            .foregroundColor(Color.Theme.blackLL)
            .font(Font.Theme.sectionTitle)
            .padding(.bottom, 12)

          AvatarView(avatarImg: avatarImg)

          CustomTextField(valueField: $firstName, nameField: "First Name", defaultField: "")
          CustomTextField(valueField: $lastName, nameField: "Last Name", defaultField: "")
          CustomTextField(valueField: $email, nameField: "Email", defaultField: "")
          CustomTextField(valueField: $phoneNumber, nameField: "Phone number", defaultField: "")

          Text("Email notifications")
            .foregroundColor(Color.Theme.blackLL)
            .font(Font.Theme.sectionTitle)
            .padding(.bottom, 12)

          NotificationView(isChecked: $orderStatus, name: "Order status")
          NotificationView(isChecked: $passwordChanges, name: "Password changes")
          NotificationView(isChecked: $specialOffers, name: "Special offers")
          NotificationView(isChecked: $newsletter, name: "Newsletter")

          Spacer()

          Button {
            UserDefaults.standard.setValue(false, forKey: kIsLoggedIn)
            eraseAllData()
            saveData()
            session.signOut()
            withAnimation {
              self.presentation.wrappedValue.dismiss()
            }
          } label: {

            ZStack {
              RoundedRectangle(cornerRadius: 10)
                .frame(height: 44)
                .foregroundColor(Color.Theme.yellowLL)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.Theme.orangeLL, lineWidth: 1)
                )

              Text("Log out")
                .font(Font.Theme.logInOutButton)
                .foregroundColor(Color.Theme.blackLL)
            }
          }
          .padding()

        }
        .padding()

        ChangesView(
          discardAction: {
            self.discardData()
          },
          saveAction: {
            self.saveData()
          }
        )
      }
      .scrollIndicators(.hidden)
    }
    .navigationBarBackButtonHidden(true)
  }

  func saveData() {
    UserDefaults.standard.set(firstName, forKey: kFirstName)
    UserDefaults.standard.set(lastName, forKey: kLastName)
    UserDefaults.standard.set(email, forKey: kEmail)
    UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)

    UserDefaults.standard.set(orderStatus, forKey: kOrderStatus)
    UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
    UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
    UserDefaults.standard.set(newsletter, forKey: kNewsletter)
  }

  func discardData() {
    firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""

    orderStatus = UserDefaults.standard.bool(forKey: kOrderStatus)
    passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
    specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
    newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
  }

  func eraseAllData() {
    firstName = ""
    lastName = ""
    email = ""
    phoneNumber = ""
    avatarImg = ""

    orderStatus = false
    passwordChanges = false
    specialOffers = false
    newsletter = false
  }

}

#Preview {
  UserProfile()
}
