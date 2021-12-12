//
//  RestaurantModel.swift
//  RestaurantMenuAppTests
//
//  Created by Raphael Vinicius on 12/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation
@testable import RestaurantMenuApp

struct RestaurantMock {
    var restaurantID: Int
    var restaurantName, restaurantPhone: String
    var restaurantWebsite: String
    var hours, priceRange: String
    var priceRangeNum: Int
    var cuisines: [String]
    var address: AddressMock
    let geo: GeoMock
    let menus: [MenuMock]
    var lastUpdated: String

    init(restaurantID: Int = 1,
         restaurantName: String = "Fake Restaurant",
         restaurantPhone: String = "+99 99 999999999",
         restaurantWebsite: String = "www.fakerestaurant.com",
         hours: String = "Daily: 6am-11pm",
         priceRange: String = "$$$",
         priceRangeNum: Int = 3,
         cuisines: [String] = ["American", "Burgers"],
         address: AddressMock = AddressMock(),
         geo: GeoMock = GeoMock(),
         menus: [MenuMock] = [MenuMock()],
         lastUpdated: String = "2021-01-01T010:00:00.000Z") {
        self.restaurantID = restaurantID
        self.restaurantName = restaurantName
        self.restaurantPhone = restaurantPhone
        self.restaurantWebsite = restaurantWebsite
        self.hours = hours
        self.priceRange = priceRange
        self.priceRangeNum = priceRangeNum
        self.cuisines = cuisines
        self.address = address
        self.geo = geo
        self.menus = menus
        self.lastUpdated = lastUpdated
    }

    var data: Restaurant {
        .init(restaurantID: restaurantID,
              restaurantName: restaurantName,
              restaurantPhone: restaurantPhone,
              restaurantWebsite: restaurantWebsite,
              hours: hours,
              priceRange: priceRange,
              priceRangeNum: priceRangeNum,
              cuisines: cuisines,
              address: address.data,
              geo: geo.data,
              menus: menus.map { $0.data },
              lastUpdated: lastUpdated)
    }
}

struct AddressMock {
    let city, state, postalCode, street: String
    let formatted: String

    init(city: String = "New York",
         state: String = "NY",
         postalCode: String = "54637",
         street: String = "876 St. Mark’s Pl",
         formatted: String = "876 St. Mark’s Pl New York, NY 54637") {
        self.city = city
        self.state = state
        self.postalCode = postalCode
        self.street = street
        self.formatted = formatted
    }

    var data: Restaurant.Address {
        .init(city: city, state: state, postalCode: postalCode, street: street, formatted: formatted)
    }
}

struct GeoMock {
    let lat, lon: Double

    init(lat: Double = 40.728951,
         lon: Double = -73.988584) {
        self.lat = lat
        self.lon = lon
    }

    var data: Restaurant.Geo {
        .init(lat: lat, lon: lon)
    }
}

struct MenuMock {
    let menuName: String
    let menuSections: [MenuSectionMock]

    init(menuName: String = "Main",
         menuSections: [MenuSectionMock] = [MenuSectionMock()]) {
        self.menuName = menuName
        self.menuSections = menuSections
    }

    var data: Restaurant.Menu {
        .init(menuName: menuName, menuSections: menuSections.map { $0.data})
    }
}

struct MenuSectionMock {
    let sectionName, description: String
    let menuItems: [MenuItemMock]

    init(sectionName: String = "Burgers",
         description: String = "",
         menuItems: [MenuItemMock] = [MenuItemMock()]) {
        self.sectionName = sectionName
        self.description = description
        self.menuItems = menuItems
    }

    var data: Restaurant.MenuSection {
        .init(sectionName: sectionName, description: description, menuItems: menuItems.map { $0.data })
    }
}

struct MenuItemMock {
    let name, description: String
    let pricing: [PricingMock]
    let price: Double

    init (name: String = "Teazers Triple Tiny Burger",
          description: String = "Served with cheddar cheese special sauce on three mini buns.",
          pricing: [PricingMock] = [PricingMock()],
          price: Double = 25) {
        self.name = name
        self.description = description
        self.pricing = pricing
        self.price = price
    }

    var data: Restaurant.MenuItem {
        .init(name: name,
              description: description,
              pricing: pricing.map { $0.data },
              price: price)
    }
}

struct PricingMock {
    let price: Double
    let currency: String
    let priceString: String

    init(price: Double = 25,
         currency: String = "USD",
         priceString: String = "$25.00") {
        self.price = price
        self.currency = currency
        self.priceString = priceString
    }

    var data: Restaurant.Pricing {
        .init(price: price, currency: currency, priceString: priceString)
    }
}
