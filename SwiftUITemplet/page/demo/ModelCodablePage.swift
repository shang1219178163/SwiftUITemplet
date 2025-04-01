//
//  ModelCodablePage.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2025/4/1.
//  Copyright © 2025 BN. All rights reserved.
//

import SwiftUI

struct ModelCodablePage: View {
    
     @StateObject private var router = Router.shared
     
    
    let jsonStr = """
    {
        "username": "yuhanle",
        "age": 18,
        "weight": 65.4,
        "sex": 1,
        "location": "Toronto, Canada",
        "three_day_forecast": [
            {
                "conditions": "Partly cloudy",
                "day": "Monday",
                "temperature": 20
            },
            {
                "conditions": "Showers",
                "day": "Tuesday",
                "temperature": 22
            },
            {
                "conditions": "Sunny",
                "day": "Wednesday",
                "temperature": 28
            }
        ]
    }
    """


    @State private var jsonContent = "";
     
     var body: some View {
         NavigationStack(path: $router.path) {
             ScrollView(.vertical, showsIndicators: true) {
                 VStack(alignment: .leading, spacing: 10, content: {
                                          
                     Wrap() {
                         Button("modelDecode") {
                             modelDecode()
                         }.buttonStyle(BorderedButtonStyle())
                         
//                         Button("savePlist") {
//                             savePlist()
//                         }.buttonStyle(BorderedButtonStyle())
//                         
//                         
//                         Button("createFile") {
//                             createFile()
//                         }.buttonStyle(BorderedButtonStyle())
//                         
//                         Button("deleteFile") {
//                             deleteFile()
//                         }.buttonStyle(BorderedButtonStyle())
//                         
//                         Button("writeJSON") {
//                             writeJSON()
//                         }.buttonStyle(BorderedButtonStyle())
//                         
//                         Button("readJSON") {
//                             readJSON()
//                         }.buttonStyle(BorderedButtonStyle())
//                         
//                         Button("updateJSON") {
//                             updateJSON()
//                         }.buttonStyle(BorderedButtonStyle())
//                         
                     }
          

                 })
             }
             .navigationBarCustom(title: "\(clsName)")
         }
     }

    func modelDecode() {
        guard let model = NSmartCodableModel.deserialize(from: jsonStr) else {
            DDLog("失败: decode")
            return
        }
        
        DDLog("toDictionary(): \(model.toDictionary() ?? [:])")
        
    }
    
}


#Preview {
    ModelCodablePage()
}
