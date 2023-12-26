//
//  LogoView.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/20/23.
//

import SwiftUI

struct LogoView: View {
  @EnvironmentObject var tabManager: TabManager
  
  var isMenuView = false
  var isUserProfile = false
  
  var body: some View {
    ZStack {
      Image("Logo")
      HStack {
        
        if isUserProfile {
          Button(action: {
            tabManager.selectedTab = .menu
          }, label: {
            Image(systemName: "arrow.left.circle.fill")
              .resizable()
              .frame(width: 30, height: 30)
              .foregroundColor(Color.Theme.greenLL)
          })
        }
        
        Spacer()
        
        if isMenuView {
          Button(action: {
            tabManager.selectedTab = .userProfile
          }, label: {
            Image("Profile")
              .resizable()
              .frame(width: 60, height: 60)
          })
        }
      }
    }
    .padding([.leading, .trailing], 16)
  }
}

#Preview {
  LogoView()
}
