//
//  Home.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/17/23.
//

import SwiftUI

struct Home: View {
  @StateObject private var tabManager = TabManager()
  let persistence = PersistenceController.shared

  var body: some View {
    TabView(selection: $tabManager.selectedTab) {

      Menu()
        .environment(\.managedObjectContext, persistence.container.viewContext)
        .tabItem {
          Label("Menu", systemImage: "list.dash")
        }
        .tag(Tab.menu)

      UserProfile()
        .tabItem {
          Label("Profile", systemImage: "square.and.pencil")
        }
        .tag(Tab.userProfile)

    }
    .environmentObject(tabManager)
    .navigationBarBackButtonHidden(true)
  }
}

#Preview {
  Home()
}
