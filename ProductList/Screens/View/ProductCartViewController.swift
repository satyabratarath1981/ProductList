//
//  ProductCartViewController.swift
//  ProductList
//
//  Created by Satyabrata Rath on 23/03/24.
//

import UIKit
import Foundation

// MARK: - Product Cart ViewController
class ProductCartViewController: UIViewController {
    
    // MARK: - Product Cart Tableview
    @IBOutlet weak var productCartTableView : UITableView!
    var arrProductCartInfo = [ProductCart]()
    
    // MARK: - Product Cart LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrProductCartInfo = DatabaseHelper.shareInstance.retriveProductCart()
        productCartTableView.reloadData()
        productCartTableView.register(UINib(nibName: Constants.ViewControllers.productCartTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.ViewControllers.productCartTableViewCell)
    }
}

// MARK: - Product Cart TableView Datasource and delegate
extension ProductCartViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrProductCartInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productCartTableView.dequeueReusableCell(withIdentifier: Constants.ViewControllers.productCartTableViewCell) as? ProductCartTableViewCell else {
            return UITableViewCell()
        }
        
        let cart = arrProductCartInfo[indexPath.row]
        cell.productCart = cart
        return cell
    }
}

