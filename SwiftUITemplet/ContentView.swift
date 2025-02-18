//
//  ContentView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2023/8/19.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath() // 管理路径的状态

//    @Binding private var text: String;
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
                "Main View"
            )
           }
        
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
    }
}
