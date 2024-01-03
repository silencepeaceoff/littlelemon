//
//  Onboarding.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/24/23.
//

import SwiftUI

struct Onboarding: View {
  @EnvironmentObject var session: SessionManager
  @State private var isOnboardingActive = false
  @State private var firstScreenAnimating = false
  @State private var secondScreenAnimating = false
  let action: () -> Void

  var body: some View {
    ZStack {
      Color.Theme.greenLL
        .ignoresSafeArea(edges: .all)

      TabView {
        VStack(spacing: 10) {
          Text("Welcome!")
            .font(Font.Theme.displayTitle)
            .foregroundColor(Color.Theme.yellowLL)

          Image(systemName: "hand.thumbsup.fill")
            .resizable()
            .scaledToFit()
            .frame(height: 100)
            .foregroundStyle(.yellow)
            .symbolEffect(.pulse)

          Text("Thank you for download our application. Before we start, please let us get to know you so we can serve you better!")
            .multilineTextAlignment(.center)
            .font(Font.Theme.displaySubtitle)
            .foregroundColor(Color.Theme.grayLL)
            .padding()
        }
        .onAppear {
          firstScreenAnimating.toggle()
        }
        .padding()

        VStack(spacing: 10) {
          Text("""
                  We working hard and hope that you will become our regular customer
               """)
          .multilineTextAlignment(.center)
          .font(Font.Theme.displaySubtitle)
          .foregroundColor(Color.Theme.grayLL)
          .padding()

          Spacer()

          Image(systemName: "heart.fill")
            .resizable()
            .scaledToFit()
            .frame(height: 100)
            .foregroundStyle(.red)
            .symbolEffect(.bounce.down, value: secondScreenAnimating)

          Spacer()

          Button("Continue") {
            isOnboardingActive = true
            action()
          }
          .font(Font.Theme.onboardingButton)
          .foregroundStyle(Color.Theme.blackLL)
          .frame(width: 150, height: 50)
          .background(Color.Theme.yellowLL, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
          .transition(.scale.combined(with: .opacity))
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.Theme.orangeLL, lineWidth: 1)
          )

          Spacer()

          Text("Little Lemon Team")
            .multilineTextAlignment(.center)
            .font(Font.Theme.displaySubtitle)
            .foregroundColor(Color.Theme.yellowLL)
            .padding(.bottom, 40)
        }
        .onAppear {
          secondScreenAnimating.toggle()
        }
        .padding()

      }
      .tabViewStyle(.page)
      .indexViewStyle(.page(backgroundDisplayMode: .always))

    }
    .onAppear {
      if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
        isOnboardingActive = true
      }
    }
  }
}

func nothing() {}

#Preview {
  Onboarding(action: nothing)
}
