//
//  AppDIContainer.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

final class AppDIContainer {

    private let appConfig = AppConfig()

    // MARK: - Network
    lazy var service: DataTransferService = {
        let config = DataNetworkConfig(baseURL: URL(string: appConfig.apiBaseURL) ?? URL(fileURLWithPath: ""),
                                       headers: ["X-API-KEY": appConfig.apiKey])
        let networkService = NetworkService(config: config)
        return .init(with: networkService)
    }()
}
