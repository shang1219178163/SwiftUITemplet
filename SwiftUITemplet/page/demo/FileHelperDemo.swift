//
//  FileHelperDemo.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/3/28.
//

import SwiftUI

struct FileHelperDemo: View {
    
     @StateObject private var router = Router.shared
     
    let fileName = "user.json";
    
    let jsonStr = """
    {
        "name": "Alice",
        "age": 25,
        "hobbies": ["Reading", "Hiking", "Swimming"],
        "address": {
            "city": "New York",
            "zipCode": "10001"
        },
        "tags": [
            {
                "name": "画家",
                "tagId": "1000"
            },
            {
                "name": "音乐家",
                "tagId": "1001"
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
                         
                         Button("savePlist") {
                             savePlist()
                         }.buttonStyle(BorderedButtonStyle())
                         
                         
                         Button("createFile") {
                             createFile()
                         }.buttonStyle(BorderedButtonStyle())
                         
                         Button("deleteFile") {
                             deleteFile()
                         }.buttonStyle(BorderedButtonStyle())
                         
                         Button("writeJSON") {
                             writeJSON()
                         }.buttonStyle(BorderedButtonStyle())
                         
                         Button("readJSON") {
                             readJSON()
                         }.buttonStyle(BorderedButtonStyle())
                         
                         Button("updateJSON") {
                             updateJSON()
                         }.buttonStyle(BorderedButtonStyle())
                         
                     }
                     Text("\(fileName): \(jsonContent)").lineLimit(1000)

                 })
             }
             .navigationBarCustom(title: "\(clsName)")
         }
     }

    func modelDecode() {
        guard let jsonData = jsonStr.data(using: .utf8) else {
            DDLog("失败: data(using: .utf8) ") // ✅ 解析成功: Alice, 25
            return;
        }
                
        // 解析 JSON
        guard let userModel = try? JSONDecoder().decode(UserModel.self, from: jsonData) else {
            DDLog("失败: decode") // ✅ 解析成功: Alice, 25
            return;
        }
        DDLog("userModel.toDictionary(): \(userModel.toDictionary() ?? [:])")

        guard let data = try? JSONEncoder().encode(userModel),
        let dataString = String(data: data, encoding: .utf8) else {
            DDLog("失败: JSONEncoder().encode(userModel)")
            return
        };
        DDLog("dataString: \(dataString)")

        
        if let userDict = userModel.toDictionary() {
            DDLog(userDict) // ✅ 输出: ["name": "Alice", "age": 25]
        }
        
        let userDict: [AnyHashable: Any] = ["name": "Alice", "age": 25, "motto": "一个独立的人"]
        guard let user = UserModel.fromDictionary(userDict) else {
            DDLog("UserModel.fromDictionary 失败")
            return
        }
        
        DDLog([userDict == user.toDictionary()])
        
    }
    
    /// 保存对象到默认 plist
    func savePlist() {
        let userDict = jsonStr.toDictionary() ?? [:];
//        let userDict: [AnyHashable: Any] = ["name": "Alice", "age": 25, "motto": "一个独立的人"]
        let mergedDict = userDict.merging([
            "hobbies": ["Reading", "Hiking", "Swimming"]
            ]) { (_, new) in new } // 选择新值
        guard let user = UserModel.fromDictionary(userDict) ,
            let userModel = UserModel.fromDictionary(mergedDict) else {
            DDLog("UserModel.fromDictionary 失败")
            return
        }
        
        UserDefaults().save(user, forKey: "user")
        UserDefaults().save(userModel, forKey: "userModel")

        DDLog("\(UserDefaults().plistPath ?? "未知")")
        
        let userNew = UserDefaults().load(UserModel.self, forKey:  "user")
        let userModelNew = UserDefaults().load(UserModel.self, forKey:  "userModel")
        DDLog([userNew?.toDictionary(), userModelNew?.toDictionary()])
    }
    
    func createFile() {
        FileHelper.createFile(fileName: "test.txt", content: "Hello, Swift FileManager!")
    }
    
    func deleteFile() {
        FileHelper.deleteFile(fileName: "test.txt")
    }
    
    func writeJSON() {
        let path = FileHelper.filePath(for: fileName);
        DDLog("\(path)")

        let user = UserModel(name: "Alice",
                             age: 25,
                             address: Address(city: "Xian",
                                              zipCode: "95678"),
                             tags: [
            TagDetail(name: "画家", tagId: "1000"),
            TagDetail(name: "音乐家", tagId: "1001"),
        ])
                      
        FileHelper.writeJSON(fileName: "user.json", data: user)
        
        readJSON()
    }
    
    func readJSON() {
        if let loadedUser = FileHelper.readJSON(fileName: "user.json", type: UserModel.self) {
//            print("读取到的用户: \(loadedUser.toDictionary()?.jsonString ?? "")")
            print("读取到的用户: \(loadedUser)")
            jsonContent = loadedUser.toDictionary()?.jsonString ?? "";
        }
    }
    
    func updateJSON() {
        FileHelper.updateJSON(fileName: "user.json") { (user: inout UserModel) in
            user.age += 1
        }
        readJSON()
    }
}


#Preview {
    FileHelperDemo()
}
