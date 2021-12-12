//
//  FetchRestaurantUseCaseTests.swift
//  RestaurantMenuAppTests
//
//  Created by Raphael Vinicius on 11/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import XCTest
@testable import RestaurantMenuApp

class FetchRestaurantUseCaseTests: XCTestCase {

    let repositoryMock = DataRestaurantsRepositoryMock()
    lazy var useCase: FetchRestaurantUseCase = FetchRestaurantUseCase(restaurantRepository: repositoryMock)

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExecuteOnFalse() {
        repositoryMock.isSuccess = false
        repositoryMock.error = DataTransferError.noResponse

        useCase.execute(id: "") { result in
            switch result {
            case .success(_):
                XCTFail("Should returns an Error")
            case .failure(let e):
                guard let error = e as? DataTransferError else {
                    XCTFail("Error should be a DataTransferError")
                    return
                }
                XCTAssertEqual(error, DataTransferError.noResponse)
            }
        }
    }

    func testExecuteOnSuccess() {
        repositoryMock.isSuccess = true
        let mock = RestaurantMock().data
        repositoryMock.response = mock

        useCase.execute(id: "") { result in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, mock)
            case .failure(let e):
                XCTFail("Shouldn't receive error \(e.localizedDescription)")
            }
        }
    }
}
