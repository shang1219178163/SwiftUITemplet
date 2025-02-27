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
        RouterModel(name: "AnimatePageView", view: AnimatePageView()),
        RouterModel(name: "ComponentView", view: ComponentView()),
        RouterModel(name: "CustomeModifierView", view: CustomeModifierView()),
        RouterModel(name: "DynamicContentView", view: DynamicContentView()),
        RouterModel(name: "GeometryReaderView", view: GeometryReaderView()),
        RouterModel(name: "GestureView", view: GestureView()),
        RouterModel(name: "NavView", view: NavView()),
    ]
    
    var items = [
        RouterModel(name: "WrapDemo", view: WrapDemo()),
        RouterModel(name: "PagerViewDemo", view: PagerViewDemo()),
        RouterModel(name: "UnknowView", view: UnknowView()),
        RouterModel(name: "CustomView", view: CustomView()),
        RouterModel(name: "TestView", view: TestView()),
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
//                                        .font(.title3)
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
            .navigationBarTitleDisplayMode(.inline)
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





