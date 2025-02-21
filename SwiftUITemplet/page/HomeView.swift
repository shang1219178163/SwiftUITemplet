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
    

    /// 系统相关组件
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
    
    
    let data: [String] = ["Item 1", "Item 2", "Item 3", "Item 4"]
    
    let avatar: String = "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737078705/im/msg/rec/651722301611577344.jpg";

    var body: some View {
        NavigationStack(path: $navManager.path) {
            List {
                Section(header: Text("页面").font(.headline)) {
                    Group {
                        ForEach(systemItems, id: \.self) { e in
                            ListItemView(
                                avatar: avatar,
                                isTitleRightHide: true,
//                                isSubtitleHide: index % 2 == 0,
                                isSubtitleRightHide: true,
//                                isArrowHide: index % 2 == 0,
                                title: {
                                    Text("\(e.name)")
                                        .font(.title3)
                                },
                                titleRight: {
                                    Text("titleRight")
                                        .font(.body)
                                },
                                subtitle: {
                                    Text("")
                                        .font(.body)
                                },
                                subtitleRight: {
                                    Text("subtitleRight")
                                        .font(.body)
                                }
                                
                            ).onTapGesture {
                                DDLog("onTapGesture")
//                                navManager.path.append(HashableAnyView(view: e.view))
                                navManager.push(e.view)
                            }
                        }

                        ForEach(items, id: \.self) { e in
                            ListItemView(
                                avatar: avatar,
                                isTitleRightHide: true,
//                                isSubtitleHide: index % 2 == 0,
                                isSubtitleRightHide: true,
//                                isArrowHide: index % 2 == 0,
                                title: {
                                    Text("\(e.name)")
                                        .font(.title3)
                                },
                                titleRight: {
                                    Text("titleRight")
                                        .font(.body)
                                },
                                subtitle: {
                                    Text("")
                                        .font(.body)
                                },
                                subtitleRight: {
                                    Text("subtitleRight")
                                        .font(.body)
                                }
                            ).onTapGesture {
                                //                        navManager.path.append(HashableAnyView(view: e.view))
                                navManager.push(e.view)
                            }
                        }
                    }
                }
                
                
                Section(header: Text("自定义").font(.headline)) {
                    Group {
                        CustomOneCell(showArrow: false) {
                            Text("CustomOneCell")
                                .font(.headline)
                        } detail: {
                            Text("Subtitle")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                   
                Button("Button") {
                    DDLog("Button")
//                    navManager.path.append(HashableAnyView(view: TestView()))
                    navManager.push(TestView())
                }
            
            }
            .listStyle(GroupedListStyle())
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





