//
//  RefreshableScrollView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import SwiftUI
import MJRefresh

// 定义一个封装 UIScrollView 的 SwiftUI 视图
struct RefreshableScrollView: UIViewRepresentable {
     @Binding var isRefreshing: Bool // 下拉刷新状态
     @Binding var isLoadingMore: Bool // 上拉加载更多状态
     var onRefresh: () -> Void // 下拉刷新回调
     var onLoad: () -> Void // 上拉加载更多回调

     func makeUIView(context: Context) -> UIScrollView {
         let scrollView = UIScrollView()
//         scrollView.backgroundColor = .red

         // 添加下拉刷新
         let header = MJRefreshNormalHeader()
         header.setRefreshingTarget(context.coordinator, refreshingAction: #selector(Coordinator.onRefresh))
         scrollView.mj_header = header

         // 添加上拉加载更多
         let footer = MJRefreshAutoNormalFooter()
         footer.setRefreshingTarget(context.coordinator, refreshingAction: #selector(Coordinator.onLoad))
         scrollView.mj_footer = footer

         return scrollView
     }

     func updateUIView(_ uiView: UIScrollView, context: Context) {
         // 更新下拉刷新状态
         if isRefreshing {
             uiView.mj_header?.beginRefreshing()
         } else {
             uiView.mj_header?.endRefreshing()
         }

         // 更新上拉加载更多状态
         if isLoadingMore {
             uiView.mj_footer?.beginRefreshing()
         } else {
             uiView.mj_footer?.endRefreshing()
         }
     }

     func makeCoordinator() -> Coordinator {
         Coordinator(self)
     }

     class Coordinator: NSObject {
         var parent: RefreshableScrollView

         init(_ parent: RefreshableScrollView) {
             self.parent = parent
         }

         // 下拉刷新回调
         @objc func onRefresh() {
             parent.onRefresh()
         }

         // 上拉加载更多回调
         @objc func onLoad() {
             parent.onLoad()
         }
     }
}


// 定义一个封装下拉刷新和上拉加载的 SwiftUI 组件
struct RefreshableScrollViewNew<Content: View>: View {
    var onRefresh: () -> Void        // 下拉刷新回调
    var onLoadMore: () -> Void             // 上拉加载回调
    var content: Content                   // 需要展示的内容
    
    @State private var isRefreshing = false  // 刷新状态
    @State private var isLoadingMore = false  // 加载状态

    init(onRefresh: @escaping () -> Void, onLoad: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.onRefresh = onRefresh
        self.onLoadMore = onLoad
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            VStack {
                content
                    .padding(.bottom, 50) // 防止上拉加载被遮挡
                
                // 刷新时的视图
                if isRefreshing || isLoadingMore {
                    ProgressView("加载中...")
                        .padding()
                }
            }
        }
        .background(
            RefreshableScrollView(
                isRefreshing: $isRefreshing,
                isLoadingMore: $isLoadingMore,
                onRefresh: onRefresh,
                onLoad: onLoadMore
            )
        )
    }
}

