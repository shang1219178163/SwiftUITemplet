//
//  NetImage.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/5.
//

import SwiftUI
import SDWebImageSwiftUI


struct NetImage: View {
    var url: String
    
    var radius: Double = 4
    
    var body: some View {
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
                // Success
                // Note: Data exist only when queried from disk cache or network. Use `.queryMemoryData` if you really need data
                print("图片加载成功")
            }
            .onFailure { error in
                print("图片加载失败: \(error)")
            }
            .onProgress { receivedSize, totalSize in
                let progress = Double(receivedSize) / Double(totalSize)
                print("加载进度: \(progress)")
            }
            .indicator(.activity)
            .cornerRadius(radius)
            .background(
               RoundedRectangle(cornerRadius: radius)
                   .stroke(Color.red, lineWidth: 0)
            )
    }
}

//#Preview {
//    NetImage()
//}
