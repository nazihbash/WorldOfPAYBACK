// 
//  TransactionDetailViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Nazih Al Bach on 07.05.23.
//

import Foundation

struct TransactionDetailViewModel {
  let partnerDisplayName: String
  let description: String?
  
  static var `default` = TransactionDetailViewModel(
    partnerDisplayName: "Rewe",
    description: "Punkte sammeln"
  )
}
