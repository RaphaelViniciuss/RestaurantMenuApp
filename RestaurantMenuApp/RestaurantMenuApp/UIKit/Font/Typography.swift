//
//  Typography.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 11/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

struct Typography {
    let size: CGFloat
    let style: UIFont.TextStyle
}

enum FontFamily: String, CaseIterable {
    case montserrat = "Montserrat"
    case playfairDisplay = "PlayfairDisplay"
}

enum FontWeight: String, CaseIterable {
    case regular = "Regular"
}
