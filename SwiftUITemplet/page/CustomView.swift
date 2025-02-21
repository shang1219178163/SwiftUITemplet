//
//  CustomView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import SwiftUI

/// 自定义页面
struct CustomView: View {
       //    @State private var path = NavigationPath()
    @StateObject private var navManager = NavManager.shared
    
    let items = Array(count: 12) { i in
        "选项_\(i)\("z" * i)"
    }
    
    @State private var imageNames = AppResource.image.imageNames
    @State private var imageUrls = AppResource.image.urls
    @State private var picture: UIImage?

    let columns = Array(repeating: GridItem(.flexible()), count: 4) // 每个元素的最小宽度

    
    var body: some View {
        NavigationStack(path: $navManager.path) {
            ScrollView(.vertical, showsIndicators: true) {
               
//                VStack {
//                      HStack {
//                          Spacer()
//                          NavigationLink("Get Picture", value: "Open Picker")
//                      }.navigationDestination(for: String.self, destination: { _ in
//                          ImagePicker(path: $path, picture: $picture)
//                      })
//                      Image(uiImage: picture ?? UIImage(named: "nopicture")!)
//                          .resizable()
//                          .scaledToFit()
//                          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
//                          .clipped()
//                      Spacer()
//                  }.padding()
   
           
                
//                NNetImageGrid
//                    .padding()
//                    .border(Color.black)
                
                // 使用封装的九宫格组件
                ImageGridView(images: imageUrls, onTap: { index in
                    DDLog("ImageGridView: \(index)")
                })
                    .border(Color.black)

                
                Text("RoundedCorner")
                    .font(.title)
                VStack(alignment: .leading, spacing: 10, content: {
                    HStack {
                      Text("SwiftUI")
                          .foregroundColor(.black).font(.title).padding(15)
                          .background(RoundedCorner(color: .green, tr: 30, bl: 30))
                      
                      Text("Lab")
                          .foregroundColor(.black).font(.title).padding(15)
                          .background(RoundedCorner(color: .blue, tl: 30, br: 30))
                      
                    }
                    .padding(20)
                    .border(Color.gray)
                    .shadow(radius: 3)
                    
                    Text("WrapTextView")
                        .font(.title)
                    WrapTextView(items: items, maxWidth: 300)
                        .padding()
                        .border(Color.blue)
                        .background(Color.green)
                })
            }
            .navigationDestination(for: HashableAnyView.self) { view in
                view.view
            }
            .navigationTitle(
                "\(clsName)"
            )
        }
    }
    
    
    var NNetImageGrid: some View {
        
//        LazyVGrid(columns: columns, spacing: 10) {
//            ForEach(imageNames, id: \.self) { e in
//                VStack {
//                    Image(e)
//                        .resizable()
//                        .scaledToFit()
//                }
//            }
//        }
        
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(imageUrls, id: \.self) { e in
                AsyncImage(url: URL(string: e)) { image in
                    image
                        .resizable()
//                        .scaledToFit()
                        .scaledToFill()
                        .cornerRadius(8)
                    
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
        }
    }
}

#Preview {
    CustomView()
}




