//
//  TestView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct TestView: View {

    @StateObject private var router = Router.shared

    @State private var text: String = ""
    @State private var imageUrls = Resource.image.urls

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(alignment: .leading, content: {
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
                                
//
//                Button("Button") {
//                    DDLog("Button")
//                    router.path.append(HashableAnyView(view: DetailView()))
//                }
                
                SearchBarView(text: $text,
                              placeholder: "搜索"
                )
                Text("输入框:\($text.wrappedValue)")
                
                Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                
                List(
                    0 ..< 3
                ) { item in
                    VStack(alignment: .leading,
                           content: {
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
                    })
                }
                Button {
                    DDLog("button")
                } label: {
                    return Text("Button")
                }
                
            })
            .padding()
            .navigationBar(title: "\(clsName)")
  //            .navigationDestination(for: AppPage<AnyView>.self) { page in
  //                page.makeView()
  //            }
        }
//        .onAppear(){
//            DDLog("onAppear - \(clsName)")
//        }
//        .onDisappear() {
//            DDLog("onDisappear - \(clsName)")
//        }
        
    }
}

#Preview {
    TestView()
}

