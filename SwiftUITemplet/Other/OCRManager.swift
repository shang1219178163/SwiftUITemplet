//
//  OCRManager.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/11.
//

import Foundation

import Vision
import UIKit

func performOCR(on image: UIImage) {
    guard let cgImage = image.cgImage else { return }
    
    // 创建文本识别请求
    let request = VNRecognizeTextRequest { (request, error) in
        if let error = error {
            print("OCR错误: \(error.localizedDescription)")
            return
        }
        
        // 获取识别到的文本
        for observation in request.results as! [VNRecognizedTextObservation] {
            let topCandidate = observation.topCandidates(1).first
            print("识别的文本: \(topCandidate?.string ?? "没有识别到文本")")
        }
    }
    
    request.recognitionLevel = .accurate // 精确模式
    request.usesLanguageCorrection = true // 使用语言纠正
    
    // 创建请求处理器
    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    
    do {
        // 执行OCR请求
        try handler.perform([request])
    } catch {
        print("OCR处理失败: \(error.localizedDescription)")
    }
}
