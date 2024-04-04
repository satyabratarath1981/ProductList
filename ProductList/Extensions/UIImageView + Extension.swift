//
//  UIImageView + Extension.swift
//  ProductList
//
//  Created by Satyabrata Rath on 27/03/24.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func getImageFromUrl(url : String) {
        guard let url = URL(string: url) else { return }
        let resource = KF.ImageResource(downloadURL: url)
        kf.setImage(with: resource)
        kf.indicatorType = .activity
    }
}
