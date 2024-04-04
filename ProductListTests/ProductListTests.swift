//
//  ProductListTests.swift
//  ProductListTests
//
//  Created by Satyabrata Rath on 04/04/24.
//

import XCTest

@testable import ProductList

final class ProductListTests: XCTestCase {
    
    var viewModel: ProductsViewModel!
    var sessionUnderTest: URLSession!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        sessionUnderTest = nil
    }

    func testJSONDecoding() {
        
        // Convert products.json to Data
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "products", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped) else {
            fatalError("Data is nil")
        }
        
        // Provie any Codable struct
        let resource = try! JSONDecoder().decode(Products.self, from: data)
        
        XCTAssertEqual(resource.products.first?.title, "iPhone 9")
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidCallToProductsGetsHTTPStatusCode200() {
        
        // given
        let url = URL(string: "https://dummyjson.com/products/")
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            
            promise.fulfill()
        }
        dataTask.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }


}
