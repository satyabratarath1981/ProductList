//
//  DatabaseHelper.swift
//  ProductList
//
//  Created by Satyabrata Rath on 03/04/24.
//
//

import UIKit
import CoreData

// MARK: - DatabaseHelper Class
class DatabaseHelper: NSObject {
    
    // MARK: - DatabaseHelper Singleton
    static let shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - DatabaseHelper Save Product Cart
    func saveProductCart(productCart: AddToCartModel){
        let localproductCart = NSEntityDescription.insertNewObject(forEntityName: Constants.CoreData.EntityName, into: context) as! ProductCart
        localproductCart.productId = Int64(productCart.id)
        localproductCart.productStock = Int64(productCart.stock)
        localproductCart.productPrice = Int64(productCart.price)
        localproductCart.productTitle = productCart.title
        
        do{
            try context.save()
        }catch let err{
            //print("Product save error: \(err.localizedDescription)")
        }
    }
    
    // MARK: - DatabaseHelper Fetch Product Cart
    func retriveProductCart() -> [ProductCart]{
        var arrProductCart = [ProductCart]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.CoreData.EntityName)
        
        do{
            arrProductCart = try context.fetch(fetchRequest) as! [ProductCart]
        }catch let err{
            //print("Error in Product fetch: \(err.localizedDescription)")
        }
        return arrProductCart
    }
    
    
    
    
    
}
