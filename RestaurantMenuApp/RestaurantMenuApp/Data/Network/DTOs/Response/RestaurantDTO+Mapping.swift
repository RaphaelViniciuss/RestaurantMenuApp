//
//  RestaurantDTO+Mapping.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

extension RestaurantResponseDTO {

    func toDomain() -> Restaurant {
        .init(restaurantID: result.restaurantID,
              restaurantName: result.restaurantName,
              restaurantPhone: result.restaurantPhone,
              restaurantWebsite: result.restaurantWebsite,
              hours: result.hours,
              priceRange: result.priceRange,
              priceRangeNum: result.priceRangeNum,
              cuisines: result.cuisines,
              address: result.address.toDomain(),
              geo: result.geo.toDomain(),
              menus: result.menus.map { $0.toDomain() },
              lastUpdated: result.lastUpdated)
    }
}

extension RestaurantResponseDTO.AddressDTO {
    func toDomain() -> Restaurant.Address {
        .init(city: city,
              state: state,
              postalCode: postalCode,
              street: street,
              formatted: formatted)
    }
}

extension RestaurantResponseDTO.GeoDTO {
    func toDomain() -> Restaurant.Geo {
        .init(lat: lat,
              lon: lon)
    }
}

extension RestaurantResponseDTO.MenuDTO {
    func toDomain() -> Restaurant.Menu {
        .init(menuName: menuName,
              menuSections: menuSections.map { $0.toDomain() })
    }
}

extension RestaurantResponseDTO.MenuSectionDTO {
    func toDomain() -> Restaurant.MenuSection {
        .init(sectionName: sectionName,
              description: description,
              menuItems: menuItems.map { $0.toDomain() })
    }
}
extension RestaurantResponseDTO.MenuItemDTO {
    func toDomain() -> Restaurant.MenuItem {
        .init(name: name,
              description: description,
              pricing: pricing.map { $0.toDomain() },
              price: price)
    }
}

extension RestaurantResponseDTO.PricingDTO {
    func toDomain() -> Restaurant.Pricing {
        .init(price: price,
              currency: currency,
              priceString: priceString)
    }
}
