//
//  ProductCartTableViewCell.swift
//  ProductList
//
//  Created by Satyabrata Rath on 23/03/24.
//

import UIKit

// MARK: - Product Cart TableViewCell
class ProductCartTableViewCell: UITableViewCell {

    // MARK: - Product Cart TableViewCell @IBOutlet
    @IBOutlet weak var productBackgroundView: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var stockButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Product Cart Configure Cell Content
    
    var productCart : ProductCart? {
        didSet {
            configureCellContent()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCellContent(){
        guard let productCart else { return }
        productTitleLabel.text = productCart.productTitle
        priceLabel.text = "$\(String(describing: productCart.productPrice))"
        stockLabel.text = Constants.ViewControllers.InStock
        stockButton.setTitle("\(String(describing: productCart.productStock))", for: .normal)
    }
}
