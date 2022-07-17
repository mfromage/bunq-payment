//
//  TransactionViewModel.swift
//  BunqPayment
//
//  Created by Michael Michael on 17.07.22.
//

import Foundation
import Combine

class TransactionViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    
    @Published var error: DbError?
    
    @Published var createTransactionSuccess: Bool = false
    
    @Published var transaction: Transaction?
    
    let localModel = TransactionLocalModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    func addTransactionDidTap(){
        
        isLoading = true
        
        localModel
            .addTransaction(totalInCents: 1300, paymentMethod: "CreditCard")
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                guard let self = self else { return }
                
                self.isLoading = false
                
                switch value{
                case .failure(let error):
                    print(error.localizedDescription)
                    self.error = error
                    //todo: add show error
                    break
                case .finished:
                    break
                }
            } receiveValue: { [weak self] item in
                guard let self = self, let item = item  else { return }
                
                self.transaction = item
                
                self.createTransactionSuccess = true
                
            }.store(in: &cancellables)

    }
}
