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
    var productTitle : String?
    var productDescription : String?
    var productDetailImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.register(UINib(nibName: Constants.ViewControllers.productTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.ViewControllers.productTableViewCell)
        configuration()
    }
}

extension ProductsViewController {
    
    func configuration(){
        initViewController()
        observeEvent()
    }
    
    func initViewController(){
        viewModel.fetchProducts()
    }
    
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard self != nil else { return }
            
            switch event {
            case .loading:
                print("start loading")
                DispatchQueue.main.async {
                    self?.productActivityIndicator.isHidden = false
                    self?.productActivityIndicator.startAnimating()
                }
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
        let product = viewModel.productList[indexPath.row]
        productTitle = product.title
        productDescription = product.description
        productDetailImage = product.images.last
        self.performSegue(withIdentifier: Constants.ViewControllers.productSegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.ViewControllers.productSegueIdentifier{
            if let productsDetailViewController = segue.destination as? ProductsDetailViewController {
                productsDetailViewController.productDetailTitle = productTitle
                productsDetailViewController.productDetailDescription = productDescription
                productsDetailViewController.productDetailImage = productDetailImage
            }
        }
    }
    
    @objc func AddToCart(_ sender: UIButton) {
        let selectedCell = viewModel.productList[sender.tag]
        
        let productid = selectedCell.id
        let producttitle = selectedCell.title
        let productprice = selectedCell.price
        let productstock = selectedCell.stock
        
        let productCartDict = [
            "productid"    : productid,
            "producttitle"    : producttitle,
            "productprice"   : productprice,
            "productstock" : productstock
        ] as [String : Any]
        
        DatabaseHelper.shareInstance.saveProductCartInfoData(productCartDict: productCartDict)
        let next = self.storyboard?.instantiateViewController(withIdentifier: Constants.ViewControllers.productCartViewController) as! ProductCartViewController
        self.present(next, animated: true, completion: nil)
    }
    
}

