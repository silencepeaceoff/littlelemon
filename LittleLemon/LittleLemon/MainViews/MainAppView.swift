//
//  MainAppView.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/26/23.
//

import SwiftUI

struct MainAppView: View {
  @StateObject private var session = SessionManager()

  var body: some View {
    ZStack {
      switch session.currentState {

      case .loggedIn:
        Home()
          .environmentObject(session)
          .transition(.opacity)

      case .loggedOut:
        Login()
          .environmentObject(session)
          .transition(.opacity)

      case .onboarding:
        Onboarding(action: session.completeOnboarding)
          .transition(.opacity)

      default:
        Color(.black)
          .ignoresSafeArea()
      }
    }
    .animation(.easeInOut, value: session.currentState)
    .onAppear(perform: {
      session.configureCurrentState()
    })
  }
}

#Preview {
  MainAppView()
}
