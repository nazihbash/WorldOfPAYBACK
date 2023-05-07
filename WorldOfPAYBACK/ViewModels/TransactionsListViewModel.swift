// 
//  TransactionsListViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Nazih Al Bach on 05.05.23.
//

import Foundation
import Combine

enum TransactionsListError: LocalizedError {
  case offline
  case serviceError

  var errorDescription: String? {
    switch self {
    case .offline:
      return "Device Offline".localized
    case .serviceError:
      return "Service Error".localized
    }
  }

  var errorMessage: String? {
    switch self {
    case .offline:
      return "Your device is not connected to the Internet.".localized
    case .serviceError:
      return "Something went wrong.".localized
    }
  }
}

class TransactionsListViewModel: ObservableObject {
  
  let service: TransactionsFetchable
  private var transactions: [TransactionViewModel] = [] {
    didSet {
      filteredTransactions = transactions
    }
  }
  @Published var filteredTransactions: [TransactionViewModel] = [] {
    didSet {
      let total = filteredTransactions.reduce(0) { $0 + $1.value }
      totalString = "Total".localized + ": \(total)"
    }
  }
  @Published var error: TransactionsListError?
  @Published var isLoading: Bool = false
  @Published var totalString: String?
  
  var categories = CategoryViewModel.categories
  private var cancellable: AnyCancellable?

  init(service: TransactionsFetchable) {
    self.service = service
  }
  
  func fetchTransactions() {
    error = nil
    isLoading = true
    cancellable = service.fetchTransactions().sink { completion in
      self.isLoading = false
      switch completion {
      case .finished:
        break
      case .failure(let error):
        self.handleError(error)
      }
    } receiveValue: { transactions in
      self.transactions = transactions
        .sorted(by: {
          $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate
        })
        .map(TransactionViewModel.init)
    }
  }
  
  func handleError(_ serviceError: ServiceError) {
    switch serviceError {
    case .notConnected:
      error = .offline
    default:
      error = .serviceError
    }
  }
  
  func filter(by categoryId: Int) {
    filteredTransactions = transactions.filter { $0.category == categoryId }
  }
}

struct TransactionViewModel: Identifiable {
  fileprivate let transaction: Transaction
  
  let id = UUID()
  
  var partnerDisplayName: String {
    transaction.partnerDisplayName
  }
  
  var category: Int {
    transaction.category
  }
  
  var description: String? {
    transaction.transactionDetail.description
  }
  
  var bookingDate: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: transaction.transactionDetail.bookingDate)
  }
  
  var valueString: String? {
    numberformatter.string(from: .init(value: transaction.transactionDetail.value.amount))
  }
  
  fileprivate var value: Int {
    transaction.transactionDetail.value.amount
  }
  
  private var numberformatter: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = transaction.transactionDetail.value.currency
    formatter.maximumFractionDigits = 2
    return formatter
  }
  
  static var `default` = TransactionViewModel(transaction: Transaction(
    partnerDisplayName: "Rewe",
    category: 1,
    transactionDetail: TransactionDetail(
      description: "Punkte sammeln",
      bookingDate: Date(),
      value: TransactionValue(
        amount: 10,
        currency: "USD"
      )
    )
  ))
}

struct CategoryViewModel: Identifiable {
  let id: Int
  
  var title: String {
    "Category \(id)"
  }
  
  fileprivate static let categories: [CategoryViewModel] = [
    .init(id: 1),
    .init(id: 2),
    .init(id: 3)
  ]
}
