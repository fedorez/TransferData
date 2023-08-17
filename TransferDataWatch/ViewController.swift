//
//  ViewController.swift
//  TransferDataWatch
//
//  Created by Denis Fedorets on 17.08.2023.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {
    
    var session: WCSession?
    
    @IBOutlet weak var infoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureWatchKitSesstion()
    }
    
    func configureWatchKitSesstion() {
        if WCSession.isSupported() {
          session = WCSession.default
          session?.delegate = self
          session?.activate()
        }
    }
    
    @IBAction func tapSendDataToWatch(_ sender: Any) {
        
        if let validSession = self.session, validSession.isReachable {
            let stringToSend = "Data from iPhone:" + String(Date().timeIntervalSince1970).suffix(3)
            let data: [String: Any] = ["iPhone": stringToSend as Any] // Create your Dictionay as per uses
            validSession.sendMessage(data, replyHandler: nil, errorHandler: nil)
        }
    }
    


}

// WCSession delegate functions
extension ViewController: WCSessionDelegate {
  
  func sessionDidBecomeInactive(_ session: WCSession) {
  }
  
  func sessionDidDeactivate(_ session: WCSession) {
  }
  
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
  }
  
  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    print("received message: \(message)")
    DispatchQueue.main.async { //6
      if let value = message["watch"] as? String {
        self.infoLabel.text = value
      }
    }
  }
}


