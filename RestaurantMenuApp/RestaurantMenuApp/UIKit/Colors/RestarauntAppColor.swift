//
//  RestarauntAppColor.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 11/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

extension RestaurantUIKit {

    struct Color {

        static var textContent: UIColor {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .light ? .nero : .white
            }
        }

        static var textDescription: UIColor {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .light ? .grey : .gainsboro
            }
        }

        static var lineIndicatorColor: UIColor {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .light ? .nero : .white
            }
        }

        static var menuTitleEnabled: UIColor {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .light ? .nero : .white
            }
        }

        static var menuTitleDisabled: UIColor {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .light ? .lightGray : .gainsboro
            }
        }

        static var divider: UIColor {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                UITraitCollection.userInterfaceStyle == .light ? .lightGray : .gainsboro
            }
        }
    }
}
