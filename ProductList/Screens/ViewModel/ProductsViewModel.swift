//
//  ProductsViewModel.swift
//  ProductList
//
//  Created by Satyabrata Rath on 23/03/24.
//

import Foundation

class ProductsViewModel {
    
    var productList : [ProductsDetails] = []
    
    var eventHandler : ((_ event: Event) -> Void)? //Data binding closure
    
    func fetchProducts(){
        ApiHelper.shared.fetchList { response in
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
