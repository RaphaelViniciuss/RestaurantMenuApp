//
//  RestaurantDTO+Response.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

struct RestaurantResponseDTO: Decodable {

    let result: RestaurantDTO

    private enum CodingKeys: String, CodingKey {
        case result
    }
}

extension RestaurantResponseDTO {

    struct RestaurantDTO: Decodable {
        let restaurantName, restaurantPhone: String
        let restaurantWebsite: String
        let hours, priceRange: String
        let priceRangeNum, restaurantID: Int
        let cuisines: [String]
        let address: AddressDTO
        let geo: GeoDTO
        let menus: [MenuDTO]
        let lastUpdated: String

        private enum CodingKeys: String, CodingKey {
            case restaurantName     = "restaurant_name"
            case restaurantPhone    = "restaurant_phone"
            case restaurantWebsite  = "restaurant_website"
            case hours
            case priceRange         = "price_range"
            case priceRangeNum      = "price_range_num"
            case restaurantID       = "restaurant_id"
            case cuisines
            case address
            case geo
            case menus
            case lastUpdated        = "last_updated"

        }
    }
}

// MARK: Localization
extension RestaurantResponseDTO {

    struct AddressDTO: Decodable {
        let city, state, postalCode, street, formatted: String

        private enum CodingKeys: String, CodingKey {
            case city
            case state
            case postalCode = "postal_code"
            case street
            case formatted
        }
    }

    struct GeoDTO: Decodable {
        let lat, lon: Double

        private enum CodingKeys: String, CodingKey {
            case lat
            case lon
        }
    }
}

// MARK: Menu
extension RestaurantResponseDTO {

    struct MenuDTO: Decodable {
        let menuName: String
        let menuSections: [MenuSectionDTO]

        private enum CodingKeys: String, CodingKey {
            case menuName       = "menu_name"
            case menuSections   = "menu_sections"
        }
    }

    struct MenuSectionDTO: Decodable {
        let sectionName, description: String
        let menuItems: [MenuItemDTO]

        private enum CodingKeys: String, CodingKey {
            case sectionName    = "section_name"
            case description
            case menuItems      = "menu_items"
        }
    }

    struct MenuItemDTO: Decodable {
        let name, description: String
        let pricing: [PricingDTO]
        let price: Double

        private enum CodingKeys: String, CodingKey {
            case name
            case description
            case pricing
            case price
        }
    }

    struct PricingDTO: Decodable {
        let price: Double
        let currency: String
        let priceString: String

        private enum CodingKeys: String, CodingKey {
            case price
            case currency
            case priceString
        }
    }
}
