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
            Button("Transfer to iPhone", action: { })
                .modifier(PressActions(onPress: {
                    // Do something on press...
                    model.pingPhone()
                }, onRelease: {
                    // Do something on release...
                    model.pingPhone()
                }))
        }
        .padding()
    }
    
    
}

struct PressActions: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
