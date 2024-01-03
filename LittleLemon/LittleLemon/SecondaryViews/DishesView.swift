//
//  DishesView.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/21/23.
//

import SwiftUI
import CoreData

struct DishesView: View {
  @State var searchText = ""
  @State var startersIsEnabled = true
  @State var mainsIsEnabled = true
  @State var dessertsIsEnabled = true
  @State var drinksIsEnabled = true

  var body: some View {
    VStack(spacing: 0) {
      HStack {

        ZStack {
          RoundedRectangle(cornerRadius: 20.0, style: .continuous)
            .frame(width: 50, height: 40)
            .foregroundColor(Color.Theme.darkGrayLL)
          Image(systemName: "magnifyingglass")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(Color.Theme.blackLL)
            .bold()
        }

        TextField(
          "",
          text: $searchText,
          prompt: Text("Search Menu").foregroundColor(.white)
        )
        .foregroundColor(.white)
        .textFieldStyle(CustomTextFieldStyle())
      }
      .padding([.leading, .trailing, .bottom])
      .background(Color.Theme.greenLL)

      VStack(alignment: .leading) {
        Text("ORDER FOR DELIVERY!")
          .foregroundColor(Color.Theme.blackLL)
          .font(Font.Theme.sectionTitle)

        ScrollView(.horizontal) {
          HStack(spacing: 20) {
            MenuButton(isChecked: $startersIsEnabled, categoryName: "Starters")
            MenuButton(isChecked: $mainsIsEnabled, categoryName: "Mains")
            MenuButton(isChecked: $dessertsIsEnabled, categoryName: "Desserts")
            MenuButton(isChecked: $drinksIsEnabled, categoryName: "Drinks")
          }
        }
        .scrollIndicators(.hidden)
      }
      .padding()

      FetchedObjects(
        predicate: buildPredicate(),
        sortDescriptors: buildSortDescriptors()
      ) { (dishes: [Dish]) in
        DishListView(dishes: dishes)
      }
    }
    .padding(.top, -12)
  }

  func buildPredicate() -> NSCompoundPredicate {
    let search = searchText == "" ?
    NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)

    let starters = startersIsEnabled ?
    NSPredicate(value: true) : NSPredicate(format: "category != %@", "starters")

    let mains = mainsIsEnabled ?
    NSPredicate(value: true) : NSPredicate(format: "category != %@", "mains")

    let desserts = dessertsIsEnabled ?
    NSPredicate(value: true) : NSPredicate(format: "category != %@", "desserts")

    let drinks = drinksIsEnabled ?
    NSPredicate(value: true) : NSPredicate(format: "category != %@", "drinks")

    let compoundPredicate = NSCompoundPredicate(
      andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks]
    )

    return compoundPredicate
  }

  func buildSortDescriptors() -> [NSSortDescriptor] {
    let sortDescriptor = NSSortDescriptor(
      key: "title",
      ascending: true,
      selector: #selector(NSString.localizedStandardCompare)
    )
    return [sortDescriptor]
  }

}

struct DishListView: View {
  let dishes: [Dish]

  var body: some View {
    VStack {
      ForEach(dishes) { dish in

        Divider().background(Color.Theme.grayLL)

        HStack {
          let dishTitle = dish.title ?? ""
          let dishPrice = dish.price ?? ""
          let dishImage = dish.image ?? ""
          let dishCategory = dish.category ?? ""
          let dishDescription = dish.descrpt ?? ""

          VStack(alignment: .leading, spacing: 12) {

            Text(dishTitle)
              .foregroundColor(Color.Theme.blackLL)
              .font(Font.Theme.cardTitle)

            Text(dishDescription)
              .lineLimit(2)
              .foregroundColor(Color.Theme.greenLL)
              .font(Font.Theme.paragraphText)

            Text("$" + dishPrice)
              .foregroundColor(Color.Theme.greenLL)
              .font(Font.Theme.highlightText)

          }

          Spacer()

          AsyncImage(url: URL(string: dishImage)) { image in
            image
              .resizable()

          } placeholder: {
            ProgressView()
          }
          .frame(width: 100, height: 100)

        }
      }
    }
    .padding()
  }
}

#Preview {
  DishesView()
}
