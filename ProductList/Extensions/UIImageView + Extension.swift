//
//  UIImageView + Extension.swift
//  ProductList
//
//  Created by Satyabrata Rath on 27/03/24.
//

import Foundation
import UIKit

// MARK: - Extension for fetch image from API
extension UIImageView {
    func getImageFromUrl(from url: String) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
