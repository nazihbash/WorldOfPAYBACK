// 
//  TransactionsListView.swift
//  WorldOfPAYBACK
//
//  Created by Nazih Al Bach on 05.05.23.
//

import SwiftUI
import Reachability

struct TransactionsListView: View {
  
  @StateObject var transactionsListVM: TransactionsListViewModel
  
  var body: some View {
    NavigationView {
      if transactionsListVM.isLoading {
        ZStack(alignment: .center) {
            ActivityIndicator(
              isAnimating: .constant(true),
              style: .medium
            )
        }
      } else {
        VStack {
          list
            .navigationBarTitle("Transactions")
            .toolbar {
              ToolbarItemGroup(placement: .navigationBarTrailing) {
                Menu(content: {
                  ForEach(transactionsListVM.categories) { category in
                    Button(action: {
                      transactionsListVM.filter(by: category.id)
                    }, label: {
                      Text(category.title)
                    })
                  }
                }, label: {
                  Image(systemName:"line.horizontal.3.decrease.circle")
                })
                Button(action: {
                  transactionsListVM.fetchTransactions()
                }, label: {
                  Image(systemName: "arrow.clockwise.circle")
                })
              }
            }
          if let totalString = transactionsListVM.totalString {
            Spacer()
            Text(totalString)
              .font(.headline)
              .padding(.horizontal)
          }
        }
      }
    }
    .errorAlert($transactionsListVM.error)
    .onAppear {
      transactionsListVM.fetchTransactions()
    }
  }
  
  private var list: some View {
    List {
      ForEach(transactionsListVM.filteredTransactions) { transaction in
        NavigationLink(
          destination: TransactionDetailView(transaction: .init(
            partnerDisplayName: transaction.partnerDisplayName,
            description: transaction.description
          ))
        ) {
          TransactionRow(transactionViewModel: transaction)
        }
      }
    }
  }
}

struct TransactionsListView_Previews: PreviewProvider {
  static var previews: some View {
    TransactionsListView(
      transactionsListVM: TransactionsListViewModel(
      service: TransactionsService(decoder: JSONDecoder(), reachability: try! Reachability()))
    )
  }
}
