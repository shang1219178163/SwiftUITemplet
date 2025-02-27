//
//  NSectionView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/27.
//

import SwiftUI

struct NSectionView<Content: View>: View {
    var title: String = ""
    
    var desc: String = ""
    
    @ViewBuilder var content: (() -> Content)

    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title).font(.title).foregroundColor(.black)
                if !desc.isEmpty {
                    Text(desc).font(.system(size: 14)).foregroundColor(.gray)
                }
                content()
                Divider().padding(.top, 8)
            }
       
        }.padding(.vertical, 10)
    }
}
