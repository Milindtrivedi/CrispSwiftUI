//
//  NetworkManager.swift
//  InternZee
//
//  Created by Milind Trivedi on 02/09/22.
//

import Foundation
import Network


class NetworkManager: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published var isConnected: Bool = false 
    
    var imageName: String {
        return isConnected ? "wifi" : "wifi.slash"
    }
    
    var connectionDescription : String {
        return isConnected ? "You are connected" : "No Internet Connection"
    }
    
    init(){
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self.isConnected = true
                } else {
                    self.isConnected = false
                }
            }
        }
        monitor.start(queue: queue)
    }
}
