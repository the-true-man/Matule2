//
//  NetworkMonitor.swift
//  SP6
//
//  Created by Евгений Михайлов on 05.01.2025.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    @Published var isConnected: Bool = true
    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")

    private init() {
        startMonitoring()
    }
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
        }
        monitor.start(queue: queue)
    }
}
