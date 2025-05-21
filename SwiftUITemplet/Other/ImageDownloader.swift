//
//  ImageDownloader.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/4/28.
//

import SwiftUICore


/// Image 下载器
actor ImageDownloader {

    private enum CacheEntry {
        case inProgress(Task<Image, Error>)
        case ready(Image)
    }

    private var cache: [URL: CacheEntry] = [:]

    func image(from url: URL) async throws -> Image? {
        if let cached = cache[url] {
            switch cached {
            case .ready(let image):
                return image
            case .inProgress(let handle):
                return try await handle.value
            }
        }

        let handle = await downloadImage(from: url)
        cache[url] = .inProgress(handle)

        do {
            let image = try await handle.value
            cache[url] = .ready(image)
            return image
        } catch {
            cache[url] = nil
            throw error
        }
    }
    
    func downloadImage(from url: URL) async -> Task<Image, Error> {
        return Task {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw URLError(.badServerResponse)
            }

            guard let uiImage = UIImage(data: data) else {
                throw URLError(.cannotDecodeContentData)
            }

            let image = Image(uiImage: uiImage)
            return image
        }
    }
}
