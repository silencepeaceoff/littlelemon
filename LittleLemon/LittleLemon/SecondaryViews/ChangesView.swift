//
//  ChangesView.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/25/23.
//

import SwiftUI

struct ChangesView: View {
  var discardAction: () -> Void
  var saveAction: () -> Void
  
  @State var discardAlert = false
  @State var saveAlert = false
  
  var body: some View {
    HStack(spacing: 20) {
      
      Button {
        discardAction()
        discardAlert = true
      } label: {
        ZStack {
          RoundedRectangle(cornerRadius: 8)
            .frame(height: 44)
            .foregroundColor(.white)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.Theme.greenLL, lineWidth: 1)
            )
          
          Text("Discard changes")
            .foregroundColor(Color.Theme.blackLL)
            .font(Font.Theme.cardTitle)
        }
      }
      .alert(Text("Changes is discard!"), isPresented: $discardAlert) {
        
      }
      
      Button {
        saveAction()
        saveAlert = true
      } label: {
        ZStack {
          RoundedRectangle(cornerRadius: 8)
            .frame(height: 44)
            .foregroundColor(Color.Theme.greenLL)
          
          Text("Save changes")
            .font(Font.Theme.cardTitle)
            .foregroundColor(Color.Theme.grayLL)
        }
      }
      .alert(Text("Changes is saved!"), isPresented: $saveAlert) {}
    }
    .padding([.leading, .trailing], 32)
  }
}

func nothing1() {}

#Preview {
  ChangesView(discardAction: nothing1, saveAction: nothing1)
}
