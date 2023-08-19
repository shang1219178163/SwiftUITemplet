//
//  ContentView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2023/8/19.
//

import SwiftUI

struct ContentView: View {
//    @Binding var text: String
    
    var body: some View {
        VStack {
//            SearchBarView(text: $text,
//                          placeholder: "搜索"
//            )
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Button {
                print("button")
            } label: {
                return Text("Button")
            }

        }
        .padding()

    }
}

struct ContentView_Previews: PreviewProvider {
    @Binding var text: String

    static var previews: some View {
        ContentView()
    }
}
