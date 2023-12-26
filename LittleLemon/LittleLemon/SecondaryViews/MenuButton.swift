//
//  MenuButton.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/21/23.
//

import SwiftUI

struct MenuButton: View {
  @State var isChecked: Bool
  let categoryName: String
  
  var body: some View {
    Button {
      isChecked.toggle()
    } label: {
      ZStack {
        Text(categoryName)
          .font(Font.Theme.sectionCategory)
          .foregroundColor(Color.Theme.greenLL)
          .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
          .background(
            RoundedRectangle(cornerRadius: 16)
              .foregroundColor(isChecked ? Color.Theme.yellowLL : Color.Theme.grayLL)
              .frame(height: 32)
          )
      }
    }
  }
}

#Preview {
  MenuButton(isChecked: false, categoryName: "Drinks")
}
