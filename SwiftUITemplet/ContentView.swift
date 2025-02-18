//
//  ContentView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2023/8/19.
//

import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath() // 管理路径的状态

    //    @Binding var text: String;

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button(
                    "Go to Details"
                ) {
//                    Router(navigator: SwiftUINavigator(path: $path)).to(DetailView())
                    
                    let navigator = SwiftUINavigator(path: $path)
                                   navigator.push(AnyView(DetailView()))
                    
                }
                
                //            SearchBarView(text: $text,
                //                          placeholder: "搜索"
                //            )
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
//                Button {
//                    print("button")
//                } label: {
//                    return Text("Button")
//                }
                
            }
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
    @Binding var text: String

    static var previews: some View {
        ContentView()
    }
}
