//
//  ProductsViewController.swift
//  ProductList
//
//  Created by Satyabrata Rath on 23/03/24.
//

import UIKit
import Foundation

// MARK: - Products ViewController
class ProductsViewController: UIViewController {
    
    // MARK: - Products ViewController IBOutlet
    @IBOutlet weak var productTableView : UITableView!
    @IBOutlet weak var productActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Products ViewController Dependency Injection
    private var apiService: ApiProtocol = ApiHelper()
    
    lazy var viewModel : ProductsViewModel = {
        let  viewModel = ProductsViewModel(apiProtocol: self.apiService)
        return viewModel
    }()

    // MARK: - Products ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.isHidden = true
            self.productActivityIndicator.isHidden = false
            self.productActivityIndicator.color = .brown
            self.productActivityIndicator.startAnimating()
        }
        
        productTableView.register(UINib(nibName: Constants.ViewControllers.productTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.ViewControllers.productTableViewCell)
        configuration()
    }
}

// MARK: - Products ViewController Configuration
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

// MARK: - Products ViewController Tableview datasource and delegate
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
    
    // MARK: - Products ViewController Tableview segue
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
        let selectedProduct = viewModel.productList[sender.tag]
        
        let productid = selectedProduct.id
        let producttitle = selectedProduct.title
        let productprice = selectedProduct.price
        let productstock = selectedProduct.stock
        
        let addToCart = AddToCartModel(title: producttitle, id: productid, stock: productstock, price: productprice)
        DatabaseHelper.shareInstance.saveProductCart(productCart: addToCart)
        self.setRightNavigationItem(addToCartCount: DatabaseHelper())
    }
}

