//
//  PickerViewPage.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/28.
//

import SwiftUI

struct PickerViewPage: View {
        
     @StateObject private var router = Router.shared
     
  
     @State private var isPickerAsset = false
     @State private var isPickerDocument = false
    
     @State private var items: [URL] = [];
     
     
     var body: some View {
         NavigationStack(path: $router.path) {
             ScrollView(.vertical, showsIndicators: true) {
                 VStack(alignment: .leading, spacing: 10, content: {
                                          
                     Wrap() {
                         Button("多媒体选择") {
                             self.isPickerAsset = true;
                         }.buttonStyle(BorderedButtonStyle())
                         
                         Button("文档选择") {
                             self.isPickerDocument = true;
                         }.buttonStyle(BorderedButtonStyle())
                     }

                     
                     ForEach(items, id: \.self) { e in
                         Text("\(e)")
                     }

                 })
             }
             .sheet(isPresented: $isPickerAsset, content: {
                 AssetPicker(
                     onChanged: {image, url in
                     DDLog("image: \(image)")
                     DDLog("url: \(url)")
                         
//                     guard let self = self else { return }
                     guard let url = url else { return }
                     items.removeAll()
                     items.append(url)
                 },
                     filter: .any(of: [.images, .videos])
                 )
             })
             .sheet(isPresented: $isPickerDocument, content: {
                 DocumentPicker(callback: { urls in
                     DDLog("urls: \(urls)")
                     
                     guard let urls = urls else { return }
                     items.removeAll()
                     items.append(contentsOf: urls)
                 }).ignoresSafeArea()
             })
             .navigationBarCustom(title: "\(clsName)")
    //            .navigationDestination(for: AppPage<AnyView>.self) { page in
    //                page.makeView()
    //            }
         }
     }
}

#Preview {
    PickerViewPage()
}
