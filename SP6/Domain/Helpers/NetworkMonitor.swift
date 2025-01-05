//
//  NetworkMonitor.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    let monitor: NWPathMonitor
    var isConnected: Bool  = false
    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")

    init() {
        monitor = NWPathMonitor()
    }
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
