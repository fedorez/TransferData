//
//  ContentView.swift
//  TransferDataWCA Watch App
//
//  Created by Denis Fedorets on 17.08.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = ViewModelWatch()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(model.messageText)
            Button("Transfer to iPhone", action: model.pingPhone)
        }
        .padding()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
