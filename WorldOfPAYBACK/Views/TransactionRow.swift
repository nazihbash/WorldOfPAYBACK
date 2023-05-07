// 
//  TransactionRow.swift
//  WorldOfPAYBACK
//
//  Created by Nazih Al Bach on 05.05.23.
//

import SwiftUI

struct TransactionRow: View {
  
  let transactionViewModel: TransactionViewModel
  
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        HStack {
          Text(transactionViewModel.partnerDisplayName)
            .font(.title)
            .fontWeight(.bold)
          
          Spacer()
          
          Text(transactionViewModel.bookingDate)
        }
        
        Text(transactionViewModel.description ?? "")
          .multilineTextAlignment(.leading)

        Text("Amount: ".localized
             + (transactionViewModel.valueString ?? "")
        )
        .font(.caption)

      }
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
      TransactionRow(
        transactionViewModel: TransactionViewModel.default
      )
      .previewLayout(.fixed(width: 375, height: 60))
      .padding()
    }
}
