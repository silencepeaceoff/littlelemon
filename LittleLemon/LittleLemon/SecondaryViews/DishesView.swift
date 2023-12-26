//
//  DishesView.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/21/23.
//

import SwiftUI

struct DishesView: View {
  @State var searchText = ""
  
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
            MenuButton(isChecked: false, categoryName: "Starters")
            MenuButton(isChecked: false, categoryName: "Mains")
            MenuButton(isChecked: false, categoryName: "Desserts")
            MenuButton(isChecked: false, categoryName: "Drinks")
          }
        }
        .scrollIndicators(.hidden)
      }
      .padding()
      
      FetchedObjects(
        predicate: buildPredicate(searchText: searchText),
        sortDescriptors: buildSortDescriptors()
      ) { (dishes: [Dish]) in
        DishListView(dishes: dishes)
      }
    }
    .padding(.top, -12)
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
//          let dishCategory = dish.category ?? "" Maybe later need to upgrage
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

func buildPredicate(searchText: String) -> NSPredicate {
  if searchText.isEmpty {
    return NSPredicate(value: true)
  } else {
    return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
  }
}

func buildSortDescriptors() -> [NSSortDescriptor] {
  let sortDescriptor = NSSortDescriptor(
    key: "title",
    ascending: true,
    selector: #selector(NSString.localizedStandardCompare)
  )
  return [sortDescriptor]
}

#Preview {
  DishesView()
}
