//
//  CustomTextField.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/21/23.
//

import SwiftUI

struct CustomTextField: View {
  @Binding var valueField: String
  let nameField: String
  let defaultField: String
  
  var body: some View {
    Text(nameField)
      .foregroundColor(Color.Theme.blackLL)
      .font(Font.Theme.describeText)
    
    TextField(defaultField, text: $valueField)
      .textFieldStyle(CustomTextFieldStyle())
      .font(Font.Theme.paragraphText)
      .padding(.bottom, 10)
  }
}

#Preview {
  CustomTextField(valueField: .constant("Any"), nameField: "First Name *", defaultField: "Lila")
}

struct CustomTextFieldStyle: TextFieldStyle {
  func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
      .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 6))
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.Theme.darkGrayLL, lineWidth: 2)
      )
  }
}
