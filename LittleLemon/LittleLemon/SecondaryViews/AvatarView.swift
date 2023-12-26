//
//  AvatarView.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/20/23.
//

import SwiftUI

struct AvatarView: View {
  @State var avatarImg: String
  
  var body: some View {
    Text("Avatar")
      .foregroundColor(Color.Theme.blackLL)
      .font(Font.Theme.describeText)
    
    HStack {
      Image(avatarImg)
        .resizable()
        .frame(width: 120, height: 120)
        .padding(.bottom, 12)
      
      Button {
        avatarImg = "Profile"
      } label: {
        ZStack {
          RoundedRectangle(cornerRadius: 8)
            .frame(height: 44)
            .foregroundColor(Color.Theme.greenLL)
          
          Text("Change")
            .font(Font.Theme.cardTitle)
            .foregroundColor(Color.Theme.grayLL)
        }
      }
      Button {
        avatarImg = ""
      } label: {
        ZStack {
          RoundedRectangle(cornerRadius: 8)
            .frame(height: 44)
            .foregroundColor(.white)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.Theme.greenLL, lineWidth: 1)
            )
          
          Text("Remove")
            .foregroundColor(Color.Theme.blackLL)
            .font(Font.Theme.cardTitle)
        }
      }
    }
  }
}

#Preview {
  AvatarView(avatarImg: "Profile")
}
