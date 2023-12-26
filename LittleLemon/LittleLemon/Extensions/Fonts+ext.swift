//
//  Fonts+ext.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/24/23.
//

import SwiftUI

extension Font {
  struct Theme {
    static let displayTitle = Font.custom("MarkaziText-Medium", size: 64)
    static let displaySubtitle = Font.custom("MarkaziText-Regular", size: 40)

    static let leadText = Font.custom("Karla-Medium", size: 18)

    static let onboardingButton = Font.custom("Karla-ExtraBold", size: 24)
    static let logInOutButton = Font.custom("Karla-ExtraBold", size: 18)

    static let sectionTitle = Font.custom("Karla-ExtraBold", size: 20)
    static let sectionCategory = Font.custom("Karla-ExtraBold", size: 16)

    static let cardTitle = Font.custom("Karla-Bold", size: 18)
    static let paragraphText = Font.custom("Karla-Regular", size: 16)
    static let highlightText = Font.custom("Karla-Medium", size: 16)

    static let describeText = Font.custom("Karla-Bold", size: 14)
    static let checkboxText = Font.custom("Karla-Regular", size: 18)
  }
}
