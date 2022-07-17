//
//  TransactionError.swift
//  BunqPayment
//
//  Created by Michael Michael on 17.07.22.
//

import Foundation

enum DbError: Error {
    case invalidRealm, errorRealm(message: String), unknown
}
