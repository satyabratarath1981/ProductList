//
//  ProductDetailsViewController.swift
//  ProductList
//
//  Created by Satyabrata Rath on 23/03/24.
//

import Foundation
import UIKit

class ProductsDetailViewController: UIViewController {
    
    var productDetailTitle: String?
    var productDetailDescription: String?
    var productDetailImage: String?
    
    @IBOutlet weak var productDetailTitleLbl: UILabel!
    @IBOutlet weak var productDetailDescriptionLbl: UILabel!
    @IBOutlet weak var productDetailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDetailTitleLbl.text = productDetailTitle
        productDetailDescriptionLbl.text = productDetailDescription
        productDetailImageView?.getImageFromUrl(url: productDetailImage ?? "")
    }
}
