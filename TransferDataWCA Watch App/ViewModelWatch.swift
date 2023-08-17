//
//  ViewModelWatch.swift
//  TransferDataWCA Watch App
//
//  Created by Denis Fedorets on 17.08.2023.
//

import Foundation
import WatchConnectivity

class ViewModelWatch: NSObject, WCSessionDelegate, ObservableObject {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.messageText = message["iPhone"] as? String ?? "Unknown"
        }
    }
    
    var session: WCSession
    
    @Published var messageText = "..."
    
    init(session: WCSession = .default) {
        
        self.session = session
        super.init()
        self.session.delegate = self
        self.session.activate()
        
    }
    
    func pingPhone() {
        if session.isReachable{
            let stringToSend = "data from watch:" + String(Date().timeIntervalSince1970).suffix(3)
            let data: [String: Any] = ["watch": stringToSend as Any] //Create your dictionary as per uses
            session.sendMessage(data, replyHandler: nil, errorHandler: nil)
        } else {
            print("unreachable!")
        }
    }
}
