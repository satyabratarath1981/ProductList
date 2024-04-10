//
//  DatabaseHelper.swift
//  ProductList
//
//  Created by Satyabrata Rath on 03/04/24.
//
//

import UIKit
import CoreData

class DatabaseHelper: NSObject {
    
    static let shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveProductCartInfoData(productCart: AddToCartModel){
        let localproductCart = NSEntityDescription.insertNewObject(forEntityName: "ProductCart", into: context) as! ProductCart
        localproductCart.productId = Int64(productCart.id)
        localproductCart.productStock = Int64(productCart.stock)
        localproductCart.productPrice = Int64(productCart.price)
        localproductCart.productTitle = productCart.title
        
        do{
            try context.save()
        }catch let err{
            print("Product save error: \(err.localizedDescription)")
        }
    }
    
    func getAllProductCartInfoData() -> [ProductCart]{
        var arrproductCart = [ProductCart]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductCart")
        do{
            arrproductCart = try context.fetch(fetchRequest) as! [ProductCart]
            
        }catch let err{
            print("Error in Product fetch: \(err.localizedDescription)")
        }
        return arrproductCart
    }
    
    
    
    
    
}
