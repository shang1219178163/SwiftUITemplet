//
//  UnknowView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI
import UniformTypeIdentifiers

struct UnknowView: View {
       
    @StateObject private var router = Router.shared
    
    let items = Array(count: 12) { i in
        "选项_\(i)\("z" * i)"
    }
    
    @State private var isPickerAsset = false
    @State private var isPickerDocument = false
    
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 10, content: {
                    
                    Text("404")

                    Wrap() {
                        Button("多媒体选择") {
                            self.isPickerAsset = true;
                        }
                        Button("文档选择") {
                            self.isPickerDocument = true;
                        }
                    }

                })
            }
            .sheet(isPresented: $isPickerAsset, content: {
                AssetPicker(
                    onChanged: {image, url in
                    DDLog("image: \(image)")
                    DDLog("url: \(url)")
                }, 
                    filter: .any(of: [.images, .videos])
                )
            })
            .sheet(isPresented: $isPickerDocument, content: {
                DocumentPicker(callback: { urls in
                    DDLog("urls: \(urls)")

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
    UnknowView()
}
