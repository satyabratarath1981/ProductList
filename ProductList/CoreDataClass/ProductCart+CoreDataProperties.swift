//
//  ProductCart+CoreDataProperties.swift
//  ProductList
//
//  Created by Satyabrata Rath on 03/04/24.
//
//

import Foundation
import CoreData


extension ProductCart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductCart> {
        return NSFetchRequest<ProductCart>(entityName: "ProductCart")
    }

    @NSManaged public var productId: Int64
    @NSManaged public var productPrice: Int64
    @NSManaged public var productStock: Int64
    @NSManaged public var productTitle: String?

}

extension ProductCart : Identifiable {

}
