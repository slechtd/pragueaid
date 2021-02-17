//
//  NetworkMonitor.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 15.02.2021.
//  Copyright © 2021 Daniel Šlechta. All rights reserved.
//

import Foundation
import Network


//Used to assertain user's internet connection
 class NetworkMonitor {
     static let shared = NetworkMonitor()
     
     private let queue = DispatchQueue.global()
     private let monitor = NWPathMonitor()
     
     public private(set) var isCoonnected: Bool = false
     
     
     func startMonitoring(){
         monitor.start(queue: queue)
         monitor.pathUpdateHandler = { [weak self] path in
             self?.isCoonnected = path.status == .satisfied
         }
     }
     
     
     func stopMonitoring(){
         monitor.cancel()
     }
 }
