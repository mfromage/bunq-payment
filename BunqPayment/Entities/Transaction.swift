//
//  Transaction.swift
//  BunqPayment
//
//  Created by Michael Michael on 17.07.22.
//

import Foundation
import RealmSwift

class Transaction: Object {
    
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var createdAt = Date()
    
    @Persisted var totalInCent: Int
    
    @Persisted var paymentMethod: String
}
