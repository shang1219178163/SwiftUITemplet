//
//  UnknowView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import SwiftUI

struct UnknowView: View {
       //    @State private var path = NavigationPath()
    @StateObject private var navManager = NavManager.shared
    
    
    @State private var imageNames = AppResource.image.imageNames
    @State private var imageUrls = AppResource.image.urls

    
    var body: some View {
        NavigationStack(path: $navManager.path) {
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("404")

                    Text("Image \(imageNames.count)")
                    ForEach(imageNames, id: \.self) { e in
                        HStack {
                            Image(e)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                            
                            Text("\(e)")
                        }
                    }
                    
                    Text("AsyncImage \(imageUrls.count)")
                    ForEach(imageUrls, id: \.self) { e in
                        HStack {
                            AsyncImage(url: URL(string: e)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)
                                    .padding()
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 60, height: 60)
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .padding()
                            }
                            Text("\(e.split(separator: "/").last ?? "-")")

                        }
                    }
                })
            }
            .navigationDestination(for: HashableAnyView.self) { view in
                view.view
            }
            .navigationTitle(
                "\(clsName)"
            )
        }
    }
}

#Preview {
    UnknowView()
}
