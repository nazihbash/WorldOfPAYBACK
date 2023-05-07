// 
//  TransactionsService.swift
//  WorldOfPAYBACK
//
//  Created by Nazih Al Bach on 05.05.23.
//

import Foundation
import Combine
import Reachability

protocol TransactionsFetchable {
  func fetchTransactions() -> AnyPublisher<[Transaction], ServiceError>
}

struct TransactionsService: TransactionsFetchable {
  
  let decoder: JSONDecoder
  let reachability: Reachability

  func fetchTransactions() -> AnyPublisher<[Transaction], ServiceError> {
    guard reachability.connection != .unavailable else {
      return Fail(error: .notConnected).eraseToAnyPublisher()
    }
//    guard let host = Bundle.main.object(forInfoDictionaryKey: "API_HOST") as? String else {
//      return Fail(error: .invalidHost).eraseToAnyPublisher()
//    }
//    var components = URLComponents()
//
//    components.scheme = "https"
//    components.host = host
//    components.path = "transactions"
//
//    guard let url = components.url else {
//      return Fail(error: .invalidURL).eraseToAnyPublisher()
//    }
    
    //Use Mock local json instead
    
    decoder.dateDecodingStrategy = .formatted(.isoCustom)
    return Bundle.main.url(forResource: "PBTransactions", withExtension: "json")
      .publisher
      .tryMap { url in
        let random = Int.random(in: 1...15)
        if random == 1 {
          throw ServiceError.randomServiceError
        }
        guard let data = try? Data(contentsOf: url) else {
          throw ServiceError.fileNotLoaded
        }
        return data
      }
      .decode(type: TransactionItems.self, decoder: decoder)
      .mapError { .decoder(error: $0) }
      .map { $0.items }
      .delay(for: 2, scheduler: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
