//
//  TransactionLocalModel.swift
//  BunqPayment
//
//  Created by Michael Michael on 17.07.22.
//

import Foundation
import Combine
import RealmSwift

class TransactionLocalModel {
    
    private var realm: Realm?
    
    init() {
        setupRealm()
    }
    
    private func setupRealm() {
        
        do {
            
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            realm = try Realm()

        } catch {
            
            print("Error openning Realm: \(error.localizedDescription)")
        }
    }
    
    func getTransactions() -> AnyPublisher<[Transaction], DbError> {
        
        guard let realm = realm else {
            return Fail(error: .invalidRealm).eraseToAnyPublisher()
        }
        
        let result = realm.objects(Transaction.self)
        
        return Just(Array(result))
            .mapError { error in
                return .errorRealm(message: error.localizedDescription)
            }.eraseToAnyPublisher()
    }
    
    func getTransactions(with id: ObjectId) -> AnyPublisher<Transaction?, DbError> {
        
        guard let realm = realm else {
            return Fail(error: .invalidRealm).eraseToAnyPublisher()
        }
        
        let result = realm.object(ofType: Transaction.self, forPrimaryKey: id)
        
        return Just(result)
            .mapError { error in
                return .errorRealm(message: error.localizedDescription)
            }.eraseToAnyPublisher()
    }
    
    func addTransaction(totalInCents: Int, paymentMethod: String) -> AnyPublisher<Transaction?, DbError> {
        
        guard let realm = realm else {
            return Fail(error: .invalidRealm).eraseToAnyPublisher()
        }
        
        let tenPercent = Int.random(in: 1...10)
        
        guard tenPercent % 10 != 0 else {
            return Fail(error: .unknown)
                .delay(for: 3, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        }
        
        let item = Transaction(value:
                                [
                                    "totalInCents": totalInCents,
                                    "paymentMethod": paymentMethod
                                ])
        
        do {
            try realm.write({
                realm.add(item)
            })
            return getTransactions(with: item.id)
                .delay(for: 3, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: .errorRealm(message: error.localizedDescription)).eraseToAnyPublisher()
        }
        
        
    }
}
