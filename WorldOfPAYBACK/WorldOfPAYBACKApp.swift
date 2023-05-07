//
//  WorldOfPAYBACKApp.swift
//  WorldOfPAYBACK
//
//  Created by Nazih Al Bach on 04.05.23.
//

import SwiftUI
import Reachability

@main
struct WorldOfPAYBACKApp: App {
    
  var body: some Scene {
      WindowGroup {
        TransactionsListView(
          transactionsListVM: TransactionsListViewModel(
            service: TransactionsService(decoder: JSONDecoder(), reachability: try! Reachability())
          )
        )
      }
  }
}

