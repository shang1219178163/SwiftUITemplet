//
//  TabMessageView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/4.
//

import SwiftUI

struct TabMessageView: View {

    @StateObject private var router = Router.shared

    @State private var text: String = ""
    @State private var imageUrls = Resource.image.urls

    var body: some View {
            VStack(alignment: .leading, content: {
                SearchBarView(text: $text,
                              placeholder: "搜索"
                )
                Text("输入框:\($text.wrappedValue)")
                
                ListItemView(
                    avatar: imageUrls[0],
                    title: {
                        Text("title")
                            .font(.title2)
                    },
                    titleRight: {
                        Text("02-02")
                            .font(.title3)
                        
                    },
                    subtitle: {
                        Text("subtitle")
                            .font(.title2)
                    },
                    subtitleRight: {
                        Text("备注")
                            .font(.title3)
                        
                    }
                )
                
                List(
                    0 ..< 3
                ) { item in
                    ListItemView(
                        avatar: imageUrls[0],
                        title: {
                            Text("title")
                                .font(.title2)
                        },
                        titleRight: {
                            Text("02-02")
                                .font(.title3)
                        },
                        subtitle: {
                            Text("subtitle")
                                .font(.title2)
                        },
                        subtitleRight: {
                            Text("备注")
                                .font(.title3)
                            
                        }
                    )
                }
            })
//            .padding()
    }
}

#Preview {
    TabMessageView()
}
