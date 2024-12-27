//
//  CryptoDetailsViewModelTests.swift
//  Cryptocurrency TrackingTests
//
//  Created by Ahmed Eldyahi on 27/12/2024.
//

import XCTest
import Combine
@testable import Cryptocurrency_Tracking


final class CryptoDetailsViewModelTests: XCTestCase {
    
    private var sut: CryptoDetailsViewModel!
    private var mockFetchDetailUseCase: MockFetchDetailUseCase!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        sut = nil
        mockFetchDetailUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchData_whenSuccess_shouldUpdateStateToSuccess() async {
        // Given
        mockFetchDetailUseCase = MockFetchDetailUseCase()
        mockFetchDetailUseCase.result = .success(tickSample)
        
        sut = CryptoDetailsViewModel(detailsUseCase: mockFetchDetailUseCase, cryptoID: "BTC_USDD")

        let exp = expectation(description: #function)

        sut.$state
            .sink { state in
                if case .success(let model) = state {
                    // When
                    XCTAssertEqual(model.symbol, "BTC_USDD")
                    XCTAssertEqual(model.markPrice, "99299")
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)

        await fulfillment(of: [exp], timeout: 1)
    }

    func test_fetchData_withErrorResponse_shouldUpdateStateToError() async {
        // Given
        let exp = expectation(description: #function)
        mockFetchDetailUseCase = MockFetchDetailUseCase()
        mockFetchDetailUseCase.result = .failure(.decodingFailed)
        sut = CryptoDetailsViewModel(detailsUseCase: mockFetchDetailUseCase, cryptoID: "BTC_USDD")

        
        // when
        sut.$state.sink { state in
            if state ==  .error(AppError.decodingFailed.errorDescription) {
                exp.fulfill()
            }
        }.store(in: &cancellables)
        
        await fulfillment(of: [exp],timeout: 1)
        // Then
        XCTAssertEqual(sut.state,  .error(AppError.decodingFailed.errorDescription))
    }
    
//    func test_fetchData_whenFailure_shouldUpdateStateToFailure() async {
//        // Given
//        let sampleError = AppError.networkError("Network failure")
//        mockFetchDetailUseCase = MockFetchDetailUseCase()
//        mockFetchDetailUseCase.result = .failure(sampleError)
//        
//        sut = CryptoDetailsViewModel(detailsUseCase: mockFetchDetailUseCase, cryptoID: "BTC")
//        
//        let exp = expectation(description: #function)
//        
//        sut.$state
//            .sink { state in
//                if case .failure(let error) = state {
//                    // When
//                    XCTAssertEqual(error.localizedDescription, "Network failure")
//                    exp.fulfill()
//                }
//            }
//            .store(in: &cancellables)
//        
//        await fulfillment(of: [exp], timeout: 1)
//    }

//    func test_initialState_shouldBeLoading() {
//        // Given
//        mockFetchDetailUseCase = MockFetchDetailUseCase()
//        mockFetchDetailUseCase.result = .success(tickSample)
//        sut = CryptoDetailsViewModel(detailsUseCase: mockFetchDetailUseCase, cryptoID: "BTC")
//        
//        // When & Then
//        XCTAssertEqual(sut.state, .loading)
//    }
}
