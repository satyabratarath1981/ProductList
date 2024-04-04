//
//  ProductTableViewCell.swift
//  ProductList
//
//  Created by Satyabrata Rath on 23/03/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productimgageView: UIImageView!
    @IBOutlet weak var buyButton: UIButton!
    
    var products : ProductsDetails? {
        didSet {
            configureCellContent()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellContent(){
        guard let products else { return }
        productTitleLabel.text = products.title
        productDescriptionLabel.text = products.description
        priceLabel.text = "$\(products.price)"
        ratingLabel.text = "Rating"
        ratingButton.setTitle("\(products.rating)", for: .normal)
        productimgageView?.getImageFromUrl(url: products.images.first ?? "")
    }
}
