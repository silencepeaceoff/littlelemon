//
//  TabManager.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/25/23.
//

import Foundation

enum Tab {
  case menu
  case userProfile
}

final class TabManager: ObservableObject {
  @Published var selectedTab: Tab = .menu
}
