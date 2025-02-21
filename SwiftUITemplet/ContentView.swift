//
//  ContentView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2023/8/19.
//

import SwiftUI

struct ContentView: View {
//       //    @State private var path = NavigationPath()
    @StateObject private var navManager = NavManager.shared

//    @Binding private var text: String;
//    @State private var text: String = ""

    var body: some View {
        TabbarView()
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
