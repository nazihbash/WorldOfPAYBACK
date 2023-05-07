// 
//  View+Extension.swift
//  WorldOfPAYBACK
//
//  Created by Nazih Al Bach on 06.05.23.
//

import SwiftUI

struct ErrorAlert: ViewModifier {
    
  @Binding var error: TransactionsListError?
  var isShowingError: Binding<Bool> {
    Binding {
      error != nil
    } set: { _ in
      error = nil
    }
  }
    
  func body(content: Content) -> some View {
    content
      .alert(isPresented: isShowingError, error: error) { _ in
      } message: { error in
        if let message = error.errorMessage {
          Text(message)
        }
      }
  }
}

extension View {
  func errorAlert(_ error: Binding<TransactionsListError?>) -> some View {
    self.modifier(ErrorAlert(error: error))
  }
}
