//
//  HomeView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct HomeView: View {
    //    @State private var path = NavigationPath()
    @StateObject private var pathModel = AppNavManager.shared
    

    var items = [RouterMode(name: "UnknowView", view: UnknowView()),
                 RouterMode(name: "CustomView", view: CustomView()),
                 RouterMode(name: "TestView", view: TestView()),
    ]

    
    var body: some View {
        NavigationStack(path: $pathModel.path) {
            List {
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
                        pathModel.path.append(HashableAnyView(view: e.view))
                    }
                }
                
                Button("Button") {
                    DDLog("Button")
                    pathModel.path.append(HashableAnyView(view: TestView()))
                }
            }
            .padding()
            .navigationDestination(for: HashableAnyView.self) { view in
               view.view
           }
            .navigationTitle(
                "\(clsName)"
            )
           }
        .onAppear(){
               DDLog("onAppear - \(clsName)")
           }.onDisappear() {
               DDLog("onDisappear - \(clsName)")
           }
    }
}

#Preview {
    HomeView()
}





