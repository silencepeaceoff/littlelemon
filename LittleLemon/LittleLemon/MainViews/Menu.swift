//
//  Menu.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/17/23.
//

import SwiftUI

struct Menu: View {
  @Environment(\.managedObjectContext) private var viewContext
  @State private var isMenuLoaded = false

  var body: some View {
    NavigationView {
      ScrollView {
        LogoView(isMenuView: true)
        HeroView()
        DishesView()
      }
    }
    .onAppear() {
      if !isMenuLoaded {
        getMenuData()
        isMenuLoaded = true
      }
    }
  }

  func getMenuData() {
    PersistenceController.shared.clear()
    guard let url = URL(
      string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
    ) else { return }

    let request = URLRequest(url: url)
    let dataTask = URLSession.shared.dataTask(with: request)
    { data, response, error in
      if let error = error {
        print("Network request error: \(error)")
        return
      }

      if let data = data {
        do {
          let menuList = try JSONDecoder().decode(MenuList.self, from: data)
          DispatchQueue.main.async {
            saveMenuToCoreData(menuList.menu)
          }
        } catch {
          print("Error decoding JSON: \(error)")
        }
      }
    }
    dataTask.resume()
  }

  func saveMenuToCoreData(_ menuItems: [MenuItem]) {
    for menu in menuItems {
      let newDish = Dish(context: PersistenceController.shared.container.viewContext)
      newDish.title = menu.title
      newDish.image = menu.image
      newDish.price = menu.price
      newDish.category = menu.category
      newDish.descrpt = menu.description
    }

    do {
      try PersistenceController.shared.container.viewContext.save()
    } catch {
      print("Error saving to CoreData: \(error.localizedDescription)")
    }

  }
}

#Preview {
  Menu()
}
