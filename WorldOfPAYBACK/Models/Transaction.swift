// 
//  Transaction.swift
//  WorldOfPAYBACK
//
//  Created by Nazih Al Bach on 05.05.23.
//

import Foundation

struct TransactionItems: Decodable {
  let items: [Transaction]
}

struct Transaction: Decodable {
  let partnerDisplayName: String
  let category: Int
  let transactionDetail: TransactionDetail
}

struct TransactionDetail: Decodable {
  let description: String?
  let bookingDate: Date
  let value: TransactionValue
}

struct TransactionValue: Decodable {
  let amount: Int
  let currency: String
}
