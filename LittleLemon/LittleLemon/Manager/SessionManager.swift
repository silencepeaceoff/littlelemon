//
//  SessionManager.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/26/23.
//

import Foundation

final class SessionManager: ObservableObject {

  enum UserDefaultKeys {
    static let hasSeenOnboarding = "hasSeenOnboarding"
  }

  enum CurrentState {
    case onboarding
    case loggedOut
    case loggedIn
  }

  @Published private(set) var currentState: CurrentState?

  func signIn() {
    currentState = .loggedIn
  }

  func signOut() {
    currentState = .loggedOut
    UserDefaults.standard.set(false, forKey: UserDefaultKeys.hasSeenOnboarding)
  }

  func completeOnboarding() {
    currentState = .loggedOut
    UserDefaults.standard.set(true, forKey: UserDefaultKeys.hasSeenOnboarding)
  }

  func configureCurrentState() {
    let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
    currentState = hasCompletedOnboarding ? .loggedOut : .onboarding
  }

}
