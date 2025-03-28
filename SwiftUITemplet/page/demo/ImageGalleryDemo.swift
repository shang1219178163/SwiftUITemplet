import SwiftUI
import SDWebImageSwiftUI

struct ImageGalleryDemo: View {
    @StateObject private var router = Router.shared
    
    // 使用 Resource 中的 urls
    private let imageUrls = Resource.image.urls
    @State private var selectedImageIndex = 0
    
    // 每行显示4个图片
    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                content
            }
            .navigationBarCustom(title: "图片预览")
            .onAppear {
                router.isPresented = true
                DDLog("onAppear \(router.path == router.path)")
            }.onDisappear(perform: {
                DDLog("onDisappear \(router.path == router.path)")
            })
        }
    }
    
    private var content: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(imageUrls.indices, id: \.self) { index in
                        WebImage(url: URL(string: imageUrls[index]))
//                            .placeholder {
//                                Image(systemName: "photo")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .foregroundColor(.gray)
//                            }
                            .resizable()
                            .indicator(.activity)
                            .transition(.fade(duration: 0.5))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: (geometry.size.width - 40) / 4,
                                   height: (geometry.size.width - 40) / 4)
                            .clipped()
                            .cornerRadius(8)
                            .onTapGesture {
                                selectedImageIndex = index
                                router.toNamed(AppRouter.imageViewer, arguments: [
                                    "images": imageUrls,
                                    "selectedIndex": selectedImageIndex
                                ])
                            }
                    }
                }
                .padding(.horizontal, 8)
            }
        }
    }
}

#Preview {
    ImageGalleryDemo()
} 
