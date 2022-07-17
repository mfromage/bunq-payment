//
//  BunqPaymentTests.swift
//  BunqPaymentTests
//
//  Created by Michael Michael on 17.07.22.
//

import XCTest
import Combine

@testable import BunqPayment

class BunqPaymentTests: XCTestCase {

    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let viewModel = TransactionViewModel()
        
        let expectation = self.expectation(description: "Expect success creating transaction without error")
        
        viewModel.addTransactionDidTap()
        
        viewModel.$isLoading
            .receive(on: RunLoop.main)
            .combineLatest(viewModel.$createTransactionSuccess, viewModel.$error, viewModel.$transaction)
            .sink { isLoading, createTransactionSuccess, error, transaction in
                
                guard !isLoading else { return }
                
                if createTransactionSuccess {
                    
                    XCTAssertTrue(error == nil)
                    XCTAssertNotEqual(transaction, nil)
                    expectation.fulfill()
                    
                } else {
                    
                    XCTAssertTrue(error != nil)
                    XCTAssertEqual(transaction, nil)
                    expectation.fulfill()
                }
                
            }.store(in: &cancellables)
        
        waitForExpectations(timeout: 20)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
