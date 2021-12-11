//
//  TextStyle.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 11/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

enum TextStyle {
    case title2
    case headline
    case body
    case subheadline
}

extension TextStyle {
    private var typography: Typography {
        switch self {
        case .title2:   return .init(size: 22, style: .title2)
        case .headline: return .init(size: 24, style: .title2)
        case .body:     return .init(size: 16, style: .body)
        case .subheadline: return .init(size: 16, style: .subheadline)
        }
    }
}

extension TextStyle {
    func font(family: String, weight: String) -> UIFont {
        let fontName = "\(family)-\(weight)"
        guard let font = UIFont(name: fontName, size: typography.size) else {
            return .preferredFont(forTextStyle: typography.style)
        }
        return UIFontMetrics(forTextStyle: typography.style).scaledFont(for: font)
    }
}
