//
//  WrapDemo.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/27.
//

import SwiftUI

struct WrapDemo: View {
    @StateObject private var router = Router.shared

    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 10, content: {
                    buildWrap(alignment: .leading, itemBgColor: Color.blue);
                    
                    buildWrap(alignment: .center, itemBgColor: Color.green);

                    buildWrap(alignment: .trailing, itemBgColor: Color.red);
   
                })
            }
            .navigationBarCustom(title: "\(clsName)")
  //            .navigationDestination(for: AppPage<AnyView>.self) { page in
  //                page.makeView()
  //            }
        }
    }
    
    
    private func buildWrap(
        alignment: HorizontalAlignment = .leading,
        itemBgColor: Color = .blue
    ) -> some View {
        var enumString = ""
        switch alignment {
        case HorizontalAlignment.center:
            enumString = "HorizontalAlignment.center"
        case HorizontalAlignment.trailing:
            enumString = "HorizontalAlignment.trailing"
        default:
            enumString = "HorizontalAlignment.leading"
        }
        
        return VStack(alignment: alignment, spacing: 10, content: {
            Text("\(enumString)").font(.subheadline)
            Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: alignment
            ) {
                ForEach(0..<10) { i in
                    Text("选项_\(i)\("z" * i)")
                        .padding(EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4))
                        .background(itemBgColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .onTapGesture { p in
                            DDLog("onTapGesture: \(i)")
                        }
                }
            }.padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Divider()
        })
    }
    
}

#Preview {
    WrapDemo()
}
