//
//  ProductsViewModel.swift
//  ProductList
//
//  Created by Satyabrata Rath on 23/03/24.
//

import Foundation

// MARK: - Products View Model
class ProductsViewModel {
    var productList : [ProductsDetails] = []
    
    // MARK: - Data binding closure
    var eventHandler : ((_ event: Event) -> Void)?
    
    // MARK: - Api Protocol
    var apiProtocol: ApiProtocol
    init(apiProtocol: ApiProtocol) {
        self.apiProtocol = apiProtocol

    }
    
    // MARK: - Fetch Products
    func fetchProducts(){
        ApiHelper.shared.fetchProductList { response in
            self.eventHandler?(.loading)
            switch response {
            case .failure(let error):
                self.eventHandler?(.error(error))
            case .success(let productsList):
                print(productsList.products)
                self.productList = productsList.products;
                self.eventHandler?(.dataLoaded)
            }
            self.eventHandler?(.stopLoading)
        }
    }
}

extension ProductsViewModel {
    
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
