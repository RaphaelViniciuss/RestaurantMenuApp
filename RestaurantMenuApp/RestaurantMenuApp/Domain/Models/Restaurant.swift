//
//  Restaurant.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

struct Restaurant: Equatable {
    let restaurantID: Int
    let restaurantName, restaurantPhone: String
    let restaurantWebsite: String
    let hours, priceRange: String
    let priceRangeNum: Int
    let cuisines: [String]
    let address: Address
    let geo: Geo
    let menus: [Menu]
    let lastUpdated: String

    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        lhs.restaurantID == rhs.restaurantID
    }

    struct Address {
        let city, state, postalCode, street: String
        let formatted: String
    }

    struct Geo {
        let lat, lon: Double
    }

    struct Menu {
        let menuName: String
        let menuSections: [MenuSection]
    }

    struct MenuSection {
        let sectionName, description: String
        let menuItems: [MenuItem]
    }

    struct MenuItem {
        let name, description: String
        let pricing: [Pricing]
        let price: Double
    }

    struct Pricing {
        let price: Double
        let currency: String
        let priceString: String
    }
}
