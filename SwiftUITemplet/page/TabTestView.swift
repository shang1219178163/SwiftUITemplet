//
//  TabTestView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI
import SDWebImageSwiftUI

struct TabTestView: View {

    @StateObject private var router = Router.shared

    @State private var text: String = ""
    @State private var imageUrls = Resource.image.urls
    
    
    var url: String {
        return "https://nokiatech.github.io/heif/content/images/ski_jump_1440x960.heic"
    }

    var body: some View {
        VStack(alignment: .leading, content: {
            
            NetImage(url: url)
            
            WebImage(url: URL(string: url)) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
    //                Rectangle().foregroundColor(.gray)
                    Image("img_placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                }
                .onSuccess { image, data, cacheType in
                    print("图片加载成功")
                }
                .onFailure { error in
                    print("图片加载失败: \(error)")
                }
                .onProgress { receivedSize, totalSize in
                    let progress = Double(receivedSize) / Double(totalSize)
                    print("加载进度: \(progress)")
                }
                .resizable()
                .scaledToFit()
//                    .frame(width: 200, height: 200)
                .cornerRadius(18)
                .background(
                   RoundedRectangle(cornerRadius: 18)
                       .stroke(Color.red, lineWidth: 2)
                )

   
        })
        .padding()
    }
}

#Preview {
    TabTestView()
}

