//
//  LeftDrawerView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/4/9.
//

import SwiftUI

struct LeftDrawerView: View {
    
    var width: Double!;
    
    init(width: Double!) {
        self.width = width
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text("Menu Item 1")
                Spacer()
            }.border(Color.blue)
            Text("Menu Item 2")
            Spacer()
        }
        .ignoresSafeArea()
        .padding()
        .frame(minWidth: width, maxHeight: .infinity)
        .background(Color.white)
        .shadow(radius: 5)
        .border(Color.blue)
    }
}
