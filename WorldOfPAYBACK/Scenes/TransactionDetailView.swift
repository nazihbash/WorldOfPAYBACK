//
//  TransactionDetailView.swift
//  WorldOfPAYBACK
//
//  Created by Nazih Al Bach on 07.05.23.
//

import SwiftUI

struct TransactionDetailView: View {
  let transaction: TransactionDetailViewModel
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 8) {
        Text(transaction.partnerDisplayName)
          .font(.title)
          .fontWeight(.bold)
        Text(transaction.description ?? "")
          .multilineTextAlignment(.leading)
        Spacer()
      }
      .padding()
      Spacer()
    }
    .navigationBarTitle(Text(transaction.partnerDisplayName), displayMode: .inline)
  }
}

struct TransactionDetailView_Previews: PreviewProvider {
  static var previews: some View {
    TransactionDetailView(
      transaction: TransactionDetailViewModel.default
    )
  }
}

