//
//  Resource.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/20.
//

import SwiftUI

/// app 资源
class AppResource {
 
    static let image = RImage.shared;

}

/// app 图片资源
class RImage{
     static let shared = RImage()
     private init() {}
    
    let imageNames: [String] = [
        "IMG_4120",
        "IMG_3736",
        "IMG_3892",
        "IMG_3893",
        "IMG_3896",
        "IMG_4183",
        "IMG_4207",
        "IMG_4327",
        "you_fate",
        "IMG_3494",
        "IMG_3495",
    ]
    
    
    /// 网图数组
    let urls: [String] = [
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737078692/im/msg/rec/651722246582308864.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737078705/im/msg/rec/651722301611577344.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337130/im/msg/rec/652806214488559616.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337130/im/msg/rec/652806216854147072.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337130/im/msg/rec/652806216086589440.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337130/im/msg/rec/652806217546207232.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337131/im/msg/rec/652806218489925632.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337131/im/msg/rec/652806219450421248.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337131/im/msg/rec/652806220805181440.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337132/im/msg/rec/652806222130581504.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737337132/im/msg/rec/652806224420671488.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737343844/im/msg/rec/652834375670566912.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737343889/im/msg/rec/652834566318460928.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/test/message/document/1737343924/im/msg/rec/652834709679771648.png",
      "https://cdn.pixabay.com/photo/2016/09/04/08/13/harbour-crane-1643476_1280.jpg",
      "https://cdn.pixabay.com/photo/2022/09/01/09/31/sunset-glow-7425170_1280.jpg",
      "https://cdn.pixabay.com/photo/2018/02/01/21/00/tree-3124103_1280.jpg",
      "https://pic.616pic.com/bg_w1180/00/04/08/G5Bftx5ZDI.jpg!/fw/1120",
      "https://pic.616pic.com/bg_w1180/00/07/20/2gfqq0N3qX.jpg!/fw/1120",
      "https://seopic.699pic.com/photo/50053/2696.jpg_wh1200.jpg",
      "https://www.10wallpaper.com/wallpaper/1366x768/1207/balls_3d-Abstract_design_wallpaper_1366x768.jpg",
      "https://www.10wallpaper.com/wallpaper/1366x768/1803/Colorful_fibre_optics_abstract_spotlight_1366x768.jpg",
      "https://www.10wallpaper.com/wallpaper/1366x768/1807/Blue_particle_tech_abstract_art_background_1366x768.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/beta/Health_APP/20231219/e0a448a8201c47ed8bd46cf1ec6fe1af.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/beta/Health_APP/20231219/56415da814454ddcb8ed83608f471619.jpg",
      "https://yl-prescription-share.oss-cn-beijing.aliyuncs.com/beta/Health_APP/20231219/3dc1b7f4e3b94a99bc5de47f3836ec96.jpg",
    ];
    
}
