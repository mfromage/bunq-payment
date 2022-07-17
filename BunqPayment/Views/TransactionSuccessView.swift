//
//  TransactionSuccessView.swift
//  BunqPayment
//
//  Created by Michael Michael on 17.07.22.
//

import SwiftUI

struct TransactionSuccessView: View {
    var body: some View {
        

        VStack(alignment: .leading, spacing: 10) {
            
            Text("Payment Success")
                .font(.largeTitle)
            
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
    
    }
}

struct TransactionSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionSuccessView()
    }
}
