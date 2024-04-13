//
//  ViewControllerExtension.swift
//  ProductsList
//
//  Created by Satyabrata Rath on 03/04/24.
//

import UIKit

// MARK: - Extension for add cart to bar button item
extension UIViewController {
     func setRightNavigationItem(addToCartCount: DatabaseHelper) {
         var cartCount = 0
         let products = addToCartCount.retriveProductCart().count
         cartCount = products
         let item = UIBarButtonItem(icon: UIImage(), badge: "\(cartCount)", target: self, action: #selector(didTapCart))
         self.navigationItem.rightBarButtonItems = [item]
    }
    
    @objc func didTapCart(sender: AnyObject) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllers.productCartViewController) as! ProductCartViewController
        self.navigationController?.pushViewController(next, animated: true)
    }
}
