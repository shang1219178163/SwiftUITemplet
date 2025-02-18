//
//  TestView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct TestView: View {
    @State private var path = NavigationPath() // 管理路径的状态

    @State private var text: String = ""

    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment: .leading, content: {
                Button("Router导航") {
                    let router = Router(navigator: SwiftUINavigator(path: $path));
                    router.to(AnyView(DetailView()))
                }
                
                Button( "SwiftUINavigator 导航") {
                    let navigator = SwiftUINavigator(path: $path)
                    navigator.push(AnyView(DetailView()))
                }
                
                SearchBarView(text: $text,
                              placeholder: "搜索"
                )
                Text("输入框:\($text.wrappedValue)")
                
                Image(
                    systemName: "globe"
                )
                .imageScale(
                    .large
                )
                .foregroundColor(
                    .accentColor
                )
                List(
                    0 ..< 3
                ) { item in
                    VStack(alignment: .leading,
                           content: {
                        HStack(content: {
                            Image(
                                "doctor"
                            )
                            .resizable()
                            .frame(
                                width: 48,
                                height: 48
                            )
                            
                            VStack(alignment: .leading,
                                   content:  {
                                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                                       content: {
                                    Text(
                                        "title"
                                    )
                                    .font(
                                        .title2
                                    )
                                    Spacer()
                                    Text(
                                        "02-02"
                                    )
                                    .font(
                                        .title3
                                    )
                                    
                                })
                                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                                       content: {
                                    Text(
                                        "subtitle"
                                    )
                                    .font(
                                        .title2
                                    )
                                    Spacer()
                                    Text(
                                        "备注"
                                    )
                                    .font(
                                        .title3
                                    )
                                    
                                })
                            })
                            
                        })
                        
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
        
    }
}

#Preview {
    TestView()
}
