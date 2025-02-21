//
//  TestView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct TestView: View {
//    @State private var path = NavigationPath()
    @StateObject private var navManager = NavManager.shared

    @State private var text: String = ""
    @State private var imageUrls = AppResource.image.urls

    var body: some View {
        NavigationStack(path: $navManager.path) {
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
                
                Button("Router导航") {
                    let router = Router(navigator: SwiftUINavigator(path: $navManager.path));
                    router.to(AnyView(DetailView()))
                }
                
                Button("SwiftUINavigator 导航") {
                    let navigator = SwiftUINavigator(path: $navManager.path)
                    navigator.push(AnyView(DetailView()))
                }
                
                Button("Button") {
                    DDLog("Button")
                    navManager.path.append(HashableAnyView(view: DetailView()))
                }
                
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
            .navigationDestination(for: HashableAnyView.self) { view in
               view.view
           }
            .navigationTitle(
                "\(clsName)"
            )
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

