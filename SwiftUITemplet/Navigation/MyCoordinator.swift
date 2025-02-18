//
//  MyCoordinator.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/18.
//

import Foundation
import SwiftUI


//let homeRoute = HomeRoute();
let feedRoute = "feedRoute";
let mineRoute = "mineRoute";
let profileRoute = "profileRoute";

struct HomeRoute: Route {
    var title: String = "HomeView"
//     var destinationView: AnyView {
//         AnyView(HomeView())
//     }
}


public class MyCoordinator : Coordinator{
    
    let navigationContext: NavigationContext! = nil
    let navigationContextProfile: NavigationContext! = nil
    
    final let homeRoute = HomeRoute();

    
    public func naviagtion(to route: Route) {
//        switch route {
//        case .homeRoute:
//            navigationContext.setInitalView(view: HomeView(), onViewIsAppearing: nil, onViewDidDisappear: nil)
//            
//        case .feedRoute:
//            navigationContext.push(view: FeedView(), animated: true)
//            
//        case .profileRoute:
//            navigationContextProfile = MyNavigationController()
//            navigationContextProfile.setInitalView(view: ProfileView(),
//                                                        onViewIsAppearing: { self.showOverlay() },
//                                                        onViewDidDisappear: { self.hideOverlay() })
//            navigationContext.present(view: <#T##View#>, animated: <#T##Bool#>)
//            
//        case .mineRoute:
//            navigationContext.push(view: MineView(), animated: true)
//            
////        case .weblink(let url):
////            let safariVC = SFSafa
//            
//        default:
//            navigationContext.present(view: UnknowView(), animated: true)
//        }
        
    }
    
    func showOverlay(){
        debugPrint("showOverlay")
    }
    
    func hideOverlay(){
        debugPrint("hideOverlay")
    }
}
