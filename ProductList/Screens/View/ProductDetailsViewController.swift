//
//  ProductDetailsViewController.swift
//  ProductList
//
//  Created by Satyabrata Rath on 23/03/24.
//

import Foundation
import UIKit

class ProductsDetailViewController: UIViewController {
       
    var productDetailsModel: ProductDetailsModel!
    
    @IBOutlet weak var productDetailTitleLbl: UILabel!
    @IBOutlet weak var productDetailDescriptionLbl: UILabel!
    @IBOutlet weak var productDetailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productDetailTitleLbl.text = productDetailsModel.title
        productDetailDescriptionLbl.text = productDetailsModel.description
        productDetailImageView?.getImageFromUrl(from: productDetailsModel.image)
    }
}
