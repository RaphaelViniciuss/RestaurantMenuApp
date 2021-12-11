//
//  RestaurantUIKit.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 11/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

final public class RestaurantUIKit {
    static func font(family: FontFamily, weight: FontWeight, typography: TextStyle) -> UIFont {
        return typography.font(family: family.rawValue, weight: weight.rawValue)
    }
}
