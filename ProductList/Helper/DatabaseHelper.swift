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
    
    func saveProductCartInfoData(productCartDict: [String:Any]){
        let productCart = NSEntityDescription.insertNewObject(forEntityName: "ProductCart", into: context) as! ProductCart
        if (productCartDict["productid"] != nil || productCartDict["productstock"] != nil || (productCartDict["productprice"] != nil) || (productCartDict["producttitle"] != nil))
        {
            productCart.productId = Int64(productCartDict["productid"] as! Int)
            productCart.productStock = Int64(productCartDict["productstock"] as! Int)
            productCart.productPrice = Int64(productCartDict["productprice"] as! Int)
            productCart.productTitle = productCartDict["producttitle"] as? String
        }
        
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
