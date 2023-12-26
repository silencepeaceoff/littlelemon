//
//  HeroView.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/20/23.
//

import SwiftUI

struct HeroView: View {
  var body: some View {
    ZStack(alignment: .center) {
      Rectangle()
        .foregroundColor(Color.Theme.greenLL)
        .frame(height: 260)
      
      VStack(alignment: .leading, spacing: -16) {
        Text("Little Lemon")
          .foregroundColor(Color.Theme.yellowLL)
          .font(Font.Theme.displayTitle)
          .padding(.top, -16)
        
        HStack(alignment: .bottom, spacing: 16) {
          VStack(alignment: .leading) {
            Text("Chicago")
              .foregroundColor(.white)
              .font(Font.Theme.displaySubtitle)
              .padding(.bottom)
            
            Text("""
               We are a family owned
               Mediterranean restaurant,
               focused on traditional
               recipes served with a
               modern twist.
               """)
            .foregroundColor(.white)
            .font(Font.Theme.leadText)
          }
          
          Image("Hero image")
            .resizable()
            .frame(width: 120, height: 160)
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
      }
      .padding([.leading, .trailing], 4)
    }
  }
}

#Preview {
  HeroView()
}
