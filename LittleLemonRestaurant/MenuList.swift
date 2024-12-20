//
//  MenuList.swift
//  LittleLemonRestaurant
//
//  Created by Yasin Özdemir on 18.12.2024.
//


struct MenuList: Decodable {
    let menu: [MenuItem]?
}

// MARK: - Menu
struct MenuItem: Decodable {
    let id: Int?
    let title, description, price: String?
    let image: String?
    let category: String?
}
