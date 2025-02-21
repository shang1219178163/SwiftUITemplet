//
//  HomeView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct HomeView: View {
    //    @State private var path = NavigationPath()
    @StateObject private var navManager = NavManager.shared
    

    var systemItems = [
        RouterMode(name: "AnimatePageView", view: AnimatePageView()),
        RouterMode(name: "ComponentView", view: ComponentView()),
        RouterMode(name: "CustomeModifierView", view: CustomeModifierView()),
        RouterMode(name: "DynamicContentView", view: DynamicContentView()),
        RouterMode(name: "GeometryReaderView", view: GeometryReaderView()),
        RouterMode(name: "GestureView", view: GestureView()),
        RouterMode(name: "NavView", view: NavView()),
    ]
    
    var items = [
        RouterMode(name: "UnknowView", view: UnknowView()),
        RouterMode(name: "CustomView", view: CustomView()),
        RouterMode(name: "TestView", view: TestView()),
    ]

    
    var body: some View {
        NavigationStack(path: $navManager.path) {
            List {
                Section(header: Text("系统组件").font(.headline)) {
                    Group {
                        ForEach(systemItems, id: \.self) { e in
                            ListItemView(
                                avatar: AppResource.image.urls[0],
                                title: {
                                    Text("\(e.name)")
                                        .font(.title2)
                                },
                                titleRight: {
                                    Text("")
                                        .font(.title3)
                                },
                                subtitle: {
                                    Text("")
                                        .font(.title2)
                                },
                                subtitleRight: {
                                    Text("")
                                        .font(.title3)
                                }
                            ).onTapGesture {
                                //                        navManager.path.append(HashableAnyView(view: e.view))
                                navManager.push(e.view)
                            }
                        }
                    }
                }
                
                // 第二组
                Section(header: Text("页面").font(.headline)) {
                    Group {
                        ForEach(items, id: \.self) { e in
                            ListItemView(
                                avatar: AppResource.image.urls[0],
                                title: {
                                    Text("\(e.name)")
                                        .font(.title2)
                                },
                                titleRight: {
                                    Text("")
                                        .font(.title3)
                                },
                                subtitle: {
                                    Text("")
                                        .font(.title2)
                                },
                                subtitleRight: {
                                    Text("")
                                        .font(.title3)
                                }
                            ).onTapGesture {
                                //                        navManager.path.append(HashableAnyView(view: e.view))
                                navManager.push(e.view)
                            }
                        }
                    }
                }
                   
                Button("Button") {
                    DDLog("Button")
                    //                    navManager.path.append(HashableAnyView(view: TestView()))
                    navManager.push(TestView())
                }
            
            }
            .navigationDestination(for: HashableAnyView.self) { view in
               view.view
           }
            .navigationTitle(
                "\(clsName)"
            )
           }
//        .onAppear(){
//           DDLog("onAppear - \(clsName)")
//        }
//        .onDisappear() {
//           DDLog("onDisappear - \(clsName)")
//        }
    }
}

#Preview {
    HomeView()
}





