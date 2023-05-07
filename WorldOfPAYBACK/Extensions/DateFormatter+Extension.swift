// 
//  DateFormatter+Extension.swift
//  WorldOfPAYBACK
//
//  Created by Nazih Al Bach on 05.05.23.
//

import Foundation

extension DateFormatter {
  static let isoCustom: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return formatter
  }()
}
