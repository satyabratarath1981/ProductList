//
//  ProductsViewController.swift
//  ProductList
//
//  Created by Satyabrata Rath on 23/03/24.
//

import UIKit
import Foundation

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var productTableView : UITableView!
    @IBOutlet weak var productActivityIndicator: UIActivityIndicatorView!
    
    private var viewModel = ProductsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isHidden = true
            self.productActivityIndicator.isHidden = false
            self.productActivityIndicator.startAnimating()
        }
        
        productTableView.register(UINib(nibName: Constants.ViewControllers.productTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.ViewControllers.productTableViewCell)
        configuration()
    }
}

extension ProductsViewController {
    
    func configuration(){
        viewModel.fetchProducts()
        observeEvent()
    }
    
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                print("start loading")
                break
            case .dataLoaded:
                DispatchQueue.main.async {
                    self?.productTableView.reloadData()
                }
                break
            case .stopLoading:
                print("stop loading")
                DispatchQueue.main.async {
                    self?.productActivityIndicator.stopAnimating()
                    self?.productActivityIndicator.isHidden = true
                    self?.navigationController?.navigationBar.isHidden = false
                }
                break
            case .error(let error):
                print("error --> \(String(describing: error))")
                break
            }
        }
    }
    
}

extension ProductsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = productTableView.dequeueReusableCell(withIdentifier: Constants.ViewControllers.productTableViewCell) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        let product = viewModel.productList[indexPath.row]
        cell.products = product
        
        cell.buyButton.addTarget(self, action: #selector(AddToCart(_:)), for: .touchUpInside)
        cell.buyButton.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.ViewControllers.productSegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.ViewControllers.productSegueIdentifier{
            if let productsDetailViewController = segue.destination as? ProductsDetailViewController {
                guard let indexPath = productTableView.indexPathForSelectedRow else { return }
                let product = viewModel.productList[indexPath.row]
                let productDetailsModel = ProductDetailsModel(title: product.title, description: product.description, image: product.images.first ?? "")
                productsDetailViewController.productDetailsModel = productDetailsModel
                
            }
        }
    }
    
    @objc func AddToCart(_ sender: UIButton) {
        let selectedCell = viewModel.productList[sender.tag]
        
        let productid = selectedCell.id
        let producttitle = selectedCell.title
        let productprice = selectedCell.price
        let productstock = selectedCell.stock
        
        let addToCart = AddToCartModel(title: producttitle, id: productid, stock: productstock, price: productprice)
        DatabaseHelper.shareInstance.saveProductCartInfoData(productCart: addToCart)
        let next = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllers.productCartViewController) as! ProductCartViewController
        self.present(next, animated: true, completion: nil)
    }
    
}

