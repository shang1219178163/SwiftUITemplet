import SwiftUI
import SDWebImageSwiftUI

struct ImageGalleryDemo: View {
    // 使用 Resource 中的 urls
    private let imageUrls = Resource.image.urls
    @State private var images: [Int: UIImage] = [:]  // 使用字典存储图片，键为索引
    @State private var selectedImageIndex = 0
    @State private var showImageViewer = false
    
    // 每行显示4个图片
    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    // 将字典转换为数组，保持顺序，对于未加载的图片使用占位图
    private var orderedImages: [UIImage] {
        return (0..<imageUrls.count).map { index in
            images[index] ?? UIImage(systemName: "photo")!
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(imageUrls.indices, id: \.self) { index in
                        WebImage(url: URL(string: imageUrls[index]))
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
                                showImageViewer = true
                                loadImages(startFrom: index)
                            }
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .fullScreenCover(isPresented: $showImageViewer) {
            WeChatImageViewer(
                images: orderedImages,
                selectedIndex: $selectedImageIndex,
                isPresented: $showImageViewer
            )
        }
        .navigationTitle("图片预览")
    }
    
    private func loadImages(startFrom: Int) {
        // 首先加载选中的图片
        loadImage(at: startFrom)
        
        // 然后加载其他图片
        for index in 0..<imageUrls.count where index != startFrom {
            loadImage(at: index)
        }
    }
    
    private func loadImage(at index: Int) {
        guard let url = URL(string: imageUrls[index]) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    images[index] = image
                }
            }
        }.resume()
    }
}

#Preview {
    NavigationView {
        ImageGalleryDemo()
    }
} 