//
//  MenuList.swift
//  LittleLemon
//
//  Created by Dmitrii Tikhomirov on 12/19/23.
//

import Foundation

struct MenuList: Decodable {
  let menu: [MenuItem]
}

struct MenuItem: Decodable {
  let title: String
  let description: String
  let price: String
  let image: String
  let category: String
}
