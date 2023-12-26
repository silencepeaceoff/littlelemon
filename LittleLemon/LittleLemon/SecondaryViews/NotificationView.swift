//
//  NotificationView.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/20/23.
//

import SwiftUI

struct NotificationView: View {
  @Binding var isChecked: Bool
  let name: String

  var body: some View {
    HStack(spacing: 14) {
      Button {
        isChecked.toggle()
      } label: {
        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
          .resizable()
          .frame(width: 20, height: 20)
          .foregroundColor(Color.Theme.greenLL)
      }
      Text(name)
        .font(Font.Theme.checkboxText)
        .foregroundColor(Color.Theme.blackLL)
    }
  }
}

#Preview {
  NotificationView(isChecked: .constant(false), name: "Newsletter")
}
