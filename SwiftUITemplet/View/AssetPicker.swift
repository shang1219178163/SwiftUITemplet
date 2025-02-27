//
//  AssetPicker.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/26.
//

import Foundation
import SwiftUI
import PhotosUI

/// 媒体选择
struct AssetPicker: UIViewControllerRepresentable {
    // 选择完成后的回调
    var onChanged: ((UIImage?, URL?) -> Void)
    
    // 配置选择器的类型（图片、视频或两者）
    var filter: PHPickerFilter = .images
    
    var limit: Int = 9
    
    init(onChanged: @escaping (UIImage?, URL?) -> Void, filter: PHPickerFilter = .images, limit: Int = 9) {
        self.onChanged = onChanged
        self.filter = filter
        self.limit = limit
    }


    // 创建UIViewController（PHPickerViewController）
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = filter
        config.selectionLimit = limit  // 选择限制，设置为1表示每次只能选择一个文件
        config.preferredAssetRepresentationMode = .current

//        // 根据`mediaTypes`设置过滤器
//        switch mediaTypes {
//        case .image:
//            config.filter = .images
//        case .video:
//            config.filter = .videos
//        case .both:
//            config.filter = .any(of: [.images, .videos])
//        }
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    // 更新UIViewController（不需要更新）
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    // 构建一个Coordinator对象来处理事件
    func makeCoordinator() -> Coordinator {
        return Coordinator(onChanged: onChanged)
    }
    
    // Coordinator处理选择结果
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var onChanged: ((UIImage?, URL?) -> Void)

        init(onChanged: @escaping (UIImage?, URL?) -> Void) {
            self.onChanged = onChanged
        }
        
        // 处理用户选择的媒体（图片或视频）
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let result = results.first else {
                picker.dismiss(animated: true)
                return
            }
            
            
            let canLoadUIImage = result.itemProvider.canLoadObject(ofClass: UIImage.self);
            let canLoadMovie = result.itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier)
            let canLoadURL = result.itemProvider.canLoadObject(ofClass: URL.self);
            
                   
            // 获取图片
            if canLoadUIImage {
                result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    DispatchQueue.main.async {
                        self.onChanged(image as? UIImage, nil)
                    }
                }
            }
            // 获取视频
            else if canLoadMovie {
                result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { (url, error) in
                    
                    if let error = error {
                      print(error)
                      return
                    }
                    // 系统会将视频文件存放到 tmp 文件夹下
                    // 我们必须在这个回调结束前，将视频拷贝出去，一旦回调结束，系统就会把视频删掉
                    // 所以一定要确定拷贝结束后，再切换到主线程做 UI 操作
                    // 另外不用担心视频过大而导致拷贝的时间很久，系统将创建一个 APFS 的克隆项，因此拷贝的速度会非常快
                      guard let url = url else { return }
                    let now = Date();
                    let nowStr = "\(now)"
                    let fileName = "\(nowStr.prefix(19))_\(Int(now.timeIntervalSince1970)).\(url.pathExtension)"
                      let newUrl = URL(fileURLWithPath: NSTemporaryDirectory() + fileName)
                      try? FileManager.default.copyItem(at: url, to: newUrl)
                    
                      DispatchQueue.main.async {
                         self.onChanged(nil, url)
                      }
                }
                                
            } else {
              print("canLoadUIImage: \(canLoadUIImage)")
              print("canLoadMovie: \(canLoadMovie)")
              print("canLoadURL: \(canLoadURL)")
              result.logTypes()
            }
            picker.dismiss(animated: true)
        }
    }
}
