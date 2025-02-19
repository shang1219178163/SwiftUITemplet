//
//  FeedView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct FeedView: View {
    @State private var path = NavigationPath() // 管理路径的状态

    @State private var data: [String] = []
    @State private var isLoading = false
    
    @State private var pageIndex = 1
    @State private var pageSize = 10

    
    @State private var isRefreshing = false  // 刷新状态
    @State private var isLoadingMore = false  // 加载状态
    
    var body: some View {
        NavigationStack(path: $path) {
            RefreshableScrollViewNew(
                onRefresh: onRefresh,
                onLoad: onLoad
            ) {
                ForEach(data, id: \.self) { item in
                    Text(item)
                        .frame(maxWidth: .infinity)
                }
            }
//            VStack(content: {
//                RefreshableScrollViewNew(
//                    onRefresh: onRefresh,
//                    onLoad: onLoad
//                    ) {
//                      List(data, id: \.self) { item in
//                          Text(item)
//                      }
//                        ForEach(data, id: \.self) { item in
//                            Text(item)
//                        }
//                    }
//            })
//            VStack(alignment: .leading, content: {
//                VStack {
//                  RefreshableScrollView(
//                    isRefreshing: $isRefreshing,
//                    isLoadingMore: $isLoadingMore,
//                      onRefresh: {
//                          // 这里处理下拉刷新的逻辑
//                          onRefresh()
//                      },
//                      onLoad: {
//                          // 这里处理上拉加载的逻辑
//                          onLoad()
//                      }
//                  )
//                  .frame(height: 400) // 这里设置刷新视图的高度
//
//                  List(data, id: \.self) { item in
//                      Text(item)
//                  }
//                }
//              .onAppear {
//                  // 初始加载数据
//                  onRefresh()
//              }
//                
//            })
//            .padding()
            .navigationDestination(for: HashableAnyView.self) { view in
               view.view
           }
            .navigationTitle(
                "\(clsName)"
            ).onAppear(perform: {
//                DDLog("clsName data: \(String(describing: type(of: self.data)))")
                onRefresh()
            })
        }
    }
    
    // 下拉刷新时的逻辑
    private func onRefresh() {
        if isLoading { return }
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // 模拟刷新数据
            self.data = Array(0...pageSize).map({ i in
                "选项\(i)"
            })
            self.isLoading = false
        }
    }

    // 上拉加载时的逻辑
    private func onLoad() {
        if isLoading { return }
        
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // 模拟加载更多数据
            let list = Array(self.data.count...(self.data.count + pageSize)).map({ i in
                "选项\(i)"
            })
            self.data.append(contentsOf: list)
            self.isLoading = false
        }
    }
}

#Preview {
    FeedView()
}
