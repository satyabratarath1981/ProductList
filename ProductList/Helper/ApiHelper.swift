//
//  APIHelper.swift
//  ProductList
//
//  Created by Satyabrata Rath on 23/03/24.
//

import Foundation

typealias handler = (Result<Products, DataError>) -> Void

class ApiHelper {
    static let shared = ApiHelper()
    private init() {}
    
    func fetchList( completionHandler : @escaping handler){
        guard let url = URL(string: Constants.API.productURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completionHandler(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            do{
                let productsModel = try JSONDecoder().decode(Products.self, from: data)
                completionHandler(.success(productsModel))

            }catch{
                completionHandler(.failure(.invalidDecoding))
            }
        }.resume()
    }
}

enum DataError : Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case invalidDecoding
    case error(Error)
}

