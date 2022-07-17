//
//  TransactionOverviewView.swift
//  BunqPayment
//
//  Created by Michael Michael on 17.07.22.
//

import SwiftUI

struct TransactionOverviewView: View {
    
    @StateObject var viewModel: TransactionViewModel = TransactionViewModel()
    
    var body: some View {
        NavigationView {

            VStack(alignment: .leading, spacing: 10) {
                
                VStack {
                    Text("Green Tea")
                        .padding(.bottom, 4)
                    Text("$12")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .frame(
                    minWidth: 0,
                    idealWidth: .infinity,
                    maxWidth: .infinity,
                    alignment: .topLeading
                )
                .padding()
                .background(.white)
                .cornerRadius(20)
                
                Text("Pay with")
                    .padding(.top, 20)
                    .foregroundColor(.accentColor)
                HStack {
                    Text("Credit Card")
                }
                .frame(
                    minWidth: 0,
                    idealWidth: .infinity,
                    maxWidth: .infinity,
                    alignment: .topLeading
                )
                .padding()

                .background(.white)
                .cornerRadius(20)
                
                if let error = viewModel.error {
                    
                    Text(mapError(error: error))
                        .frame(
                            minWidth: 0,
                            idealWidth: .infinity,
                            maxWidth: .infinity,
                            alignment: .center
                        )
                        .padding()
                        .foregroundColor(.red)
                }
                
                Button(viewModel.isLoading ? "Loading..." : "Pay") {
                    viewModel.addTransactionDidTap()
                }
                .disabled(viewModel.isLoading)
                .frame(
                    minWidth: 0,
                    idealWidth: .infinity,
                    maxWidth: .infinity,
                    minHeight: 0,
                    idealHeight: 44,
                    maxHeight: 44,
                    alignment: .center
                )
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(20)
               
                
                NavigationLink(
                    destination: TransactionSuccessView(),
                    isActive: $viewModel.createTransactionSuccess
                ) {
                    EmptyView()
                }.hidden()
            }
            .frame(
                minWidth: 0,
                idealWidth: .infinity,
                maxWidth: .infinity,
                minHeight: 0,
                idealHeight: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding()
            .background(Color.gray.opacity(0.1))
            .navigationTitle("Overview")
            
        }
    }
    
    func mapError(error: DbError) -> String {
        switch error {
        case .unknown: return "Unknown error"
        case .invalidRealm: return "Invalid realm"
        case .errorRealm(let message): return message
        }
    }
}

struct TransactionOverviewView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionOverviewView()
    }
}
