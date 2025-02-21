//
//  ProfileView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct ProfileView: View {
       //    @State private var path = NavigationPath()
    @StateObject private var navManager = NavManager.shared

    var body: some View {
        NavigationStack(path: $navManager.path) {
            VStack(alignment: .leading, content: {
       
        
                Button {
                    DDLog("button")
                } label: {
                    return Text("Button")
                }
                
            })
            .padding()
            .navigationDestination(for: HashableAnyView.self) { view in
               view.view
           }
            .navigationTitle(
                "\(clsName)"
            )
           }
    }
}

#Preview {
    ProfileView()
}
