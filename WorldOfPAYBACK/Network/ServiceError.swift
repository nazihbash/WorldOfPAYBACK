// 
//  ServiceError.swift
//  WorldOfPAYBACK
//
//  Created by Nazih Al Bach on 05.05.23.
//

import Foundation

enum ServiceError: Error {
  case notConnected
  case invalidHost
  case invalidURL
  case fileNotFound
  case fileNotLoaded
  case randomServiceError
  case decoder(error: Error)
}
