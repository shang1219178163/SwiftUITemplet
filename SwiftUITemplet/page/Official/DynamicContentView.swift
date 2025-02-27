//
//  DynamicContentView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import SwiftUI

struct DynamicContentView: View {
       //    @State private var path = NavigationPath()
    @StateObject private var navManager = NavManager.shared
    
    // 1. 列表数据源
    let items = ["Apple", "Banana", "Orange", "Grapes", "Mango"]
  
    // 2. 动态内容示例数据源
    @State private var dynamicItems = ["Red", "Blue", "Green", "Yellow", "Purple"]
  
    // 3. ForEach 示例数据源
    @State private var people = ["John", "Sarah", "Mike", "Alice", "David", "Alex"]
      

    var body: some View {
        NavigationStack(path: $navManager.path) {
//            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 10, content: {
//                     1. 使用 List 展示静态数据
                   VStack {
                       Text("List of Fruits")
                           .font(.title2)
                           .padding()
                       List(items, id: \.self) { item in
                           Text(item)
                       }
                       .frame(height: 200) // Set height for List view
                   }
                    
                    
            
                    List {
                        ForEach(dynamicItems, id: \.self) { e in
                            Text(e).id(e)
                        }
                        .onDelete(perform: { indexSet in
                            self.dynamicItems.remove(atOffsets: indexSet)
                        })
                        .onMove{ from,to in
                            if from.first! != to {
                                self.dynamicItems.move(fromOffsets: from, toOffset: to)
                            }
                        }
                    }

                   // 2. 使用 ForEach 展示动态数据
                   // 4. ForEach 示例: 动态内容展示
                   VStack {
                       Text("ForEach with Identifiable Content")
                           .font(.title2)
                           .padding()
                       List {
                           ForEach(dynamicItems, id: \.self) { e in
                               Text(e).id(e)
                           }
                           .onDelete(perform: deleteItem) // Deletion example
                           .onMove(perform: moveItem) // Move example
                       }
                       .frame(height: 300) // Set height for List view
                       .toolbar {
                           EditButton() // Add editing functionality (move items)
                       }
                   }
                    
                    
//                    
//                    // 3. 使用 LazyVStack 动态加载内容
                    Text("LazyVStack Example")
                        .padding()
                        .background(.purple)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                    ScrollView {
                        // 4. LazyVStack 示例：懒加载垂直排列
                        LazyVStack(spacing: 10) {
                            ForEach(0..<50, id: \.self) { i in
                                Text("Item \(i)")
//                                    .padding()
//                                    .background(Color.blue.opacity(0.3))
                                    .cornerRadius(8)
                                    .frame(width: .infinity, height: 45)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .frame(height: 300)
                    
            
                })
//            }
            .navigationDestination(for: HashableAnyView.self) { view in
               view.view
           }
            .navigationTitle(
                "\(clsName)"
            ).navigationBarTitleDisplayMode(.inline)
       }
    }
    
    
      // 删除项目
      private func deleteItem(at offsets: IndexSet) {
          dynamicItems.remove(atOffsets: offsets)
      }
      
      // 移动项目
      private func moveItem(from source: IndexSet, to destination: Int) {
          DDLog("moveItem:\(source) -> \(destination)")
          dynamicItems.move(fromOffsets: source, toOffset: destination)
      }
}

#Preview {
    DynamicContentView()
}



struct UserDetailModel: Identifiable, Hashable {
    let id = UUID()
    let desc: String
}
