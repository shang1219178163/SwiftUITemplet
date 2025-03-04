import SwiftUI

// 路由
class AppRouter {
    static let home = "/"
    static let settings = "/settings"
    static let profile = "/profile"
    static let detail = "/detail"
    static let imageViewer = "/imageViewer"
    static let discovery = "/discovery"
    static let discoveryDetail = "/discovery/detail"
    static let collection = "/collection"
    static let notification = "/notification"
    static let editProfile = "/profile/edit"
    
    // 系统相关组件
    static let animatePage = "/animate"
    static let component = "/component"
    static let customeModifier = "/customeModifier"
    static let dynamicContent = "/dynamicContent"
    static let geometryReader = "/geometryReader"
    static let gesture = "/gesture"
    static let nav = "/nav"
    
    // 自定义组件
    static let wrap = "/wrap"
    static let pager = "/pager"
    static let unknow = "/unknow"
    static let custom = "/custom"
    static let test = "/test"
}


class AppPage<T: View>: Hashable {
    let id = UUID()
    let route: String
    let title: String
    let viewBuilder: ([String: Any]) -> T
    var arguments: [String: Any]
    
    init(route: String, title: String, view: @escaping ([String: Any]) -> T, arguments: [String: Any] = [:]) {
        self.route = route
        self.title = title
        self.viewBuilder = view
        self.arguments = arguments
    }
    
    func makeView() -> AnyView {
        AnyView(viewBuilder(arguments))
    }
    
    static func == (lhs: AppPage<T>, rhs: AppPage<T>) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// 路由注册表
class RouteRegistry {
    static let shared = RouteRegistry()
    private var routes: [String: ([String: Any]) -> AppPage<AnyView>] = [:]
    
    private init() {
        registerPages()
    }
    
    func register<T: View>(route: String, builder: @escaping ([String: Any]) -> AppPage<T>) {
        routes[route] = { args in
            let page = builder(args)
            return AppPage(
                route: page.route,
                title: page.title,
                view: { args in AnyView(page.viewBuilder(args)) },
                arguments: args
            )
        }
    }
    
    func page(for route: String, arguments: [String: Any] = [:]) -> AppPage<AnyView>? {
        return routes[route]?(arguments)
    }
    
    private func registerPages() {
        // 定义所有页面
        let pages: [(String, ([String: Any]) -> AnyView, ([String: Any]) -> String)] = [
            (AppRouter.home, { _ in AnyView(HomeView()) }, { _ in "首页" }),
            (AppRouter.settings, { _ in AnyView(SettingsView()) }, { _ in "设置" }),
            (AppRouter.profile, { _ in AnyView(ProfileView()) }, { _ in "个人中心" }),
            (AppRouter.detail, { args in AnyView(DetailView()) }, { args in args["title"] as? String ?? "详情" }),
            (AppRouter.imageViewer, { args in
                let images = args["images"] as? [UIImage] ?? []
                let selectedIndex = args["selectedIndex"] as? Int ?? 0
                let isPresented = args["isPresented"] as? Bool ?? true
                return AnyView(WeChatImageViewer(
                    images: images,
                    selectedIndex: .constant(selectedIndex),
                    isPresented: .constant(isPresented)
                ))
            }, { args in
                let selectedIndex = args["selectedIndex"] as? Int ?? 0
                let images = args["images"] as? [UIImage] ?? []
                return "\(selectedIndex + 1)/\(images.count)"
            }),
            (AppRouter.discovery, { _ in AnyView(Text("发现页面")) }, { _ in "发现" }),
            (AppRouter.discoveryDetail, { args in 
                AnyView(Text(args["title"] as? String ?? "发现详情"))
            }, { args in args["title"] as? String ?? "发现详情" }),
            (AppRouter.collection, { _ in AnyView(Text("我的收藏")) }, { _ in "我的收藏" }),
            (AppRouter.notification, { _ in AnyView(Text("消息通知")) }, { _ in "消息通知" }),
            (AppRouter.editProfile, { _ in AnyView(Text("编辑个人资料")) }, { _ in "编辑个人资料" }),
            
            // 系统相关组件
            (AppRouter.animatePage, { _ in AnyView(AnimatePageView()) }, { _ in "动画页面" }),
            (AppRouter.component, { _ in AnyView(ComponentView()) }, { _ in "组件" }),
            (AppRouter.customeModifier, { _ in AnyView(CustomeModifierView()) }, { _ in "自定义修饰符" }),
            (AppRouter.dynamicContent, { _ in AnyView(DynamicContentView()) }, { _ in "动态内容" }),
            (AppRouter.geometryReader, { _ in AnyView(GeometryReaderView()) }, { _ in "几何阅读器" }),
            (AppRouter.gesture, { _ in AnyView(GestureView()) }, { _ in "手势" }),
            (AppRouter.nav, { _ in AnyView(NavView()) }, { _ in "导航" }),
            
            // 自定义组件
            (AppRouter.wrap, { _ in AnyView(WrapDemo()) }, { _ in "Wrap示例" }),
            (AppRouter.pager, { _ in AnyView(PagerViewDemo()) }, { _ in "分页视图" }),
            (AppRouter.unknow, { _ in AnyView(UnknowView()) }, { _ in "未知页面" }),
            (AppRouter.custom, { _ in AnyView(CustomView()) }, { _ in "自定义视图" }),
            (AppRouter.test, { _ in AnyView(TestView()) }, { _ in "测试页面" })
        ]
        
        // 注册所有页面
        for (route, viewBuilder, titleBuilder) in pages {
            register(route: route) { args in
                AppPage(
                    route: route,
                    title: titleBuilder(args),
                    view: { _ in viewBuilder(args) }
                )
            }
        }
    }
}

// 路由中间件协议
protocol RouterMiddleware {
    func redirect<T: View>(_ page: AppPage<T>) -> AppPage<T>?
}

// 路由管理器
class Router: ObservableObject {
    @Published var homePath = NavigationPath()
    @Published var discoveryPath = NavigationPath()
    @Published var profilePath = NavigationPath()
    @Published var isPresented: Bool = false
    @Published var selectedTab: Int = 0
    
    private var middlewares: [RouterMiddleware] = []
    @Published var homeHistory: [AppPage<AnyView>] = []
    @Published var discoveryHistory: [AppPage<AnyView>] = []
    @Published var profileHistory: [AppPage<AnyView>] = []
    
    var path: NavigationPath {
        get {
            switch selectedTab {
            case 0:
                return homePath
            case 1:
                return discoveryPath
            case 2:
                return profilePath
            default:
                return NavigationPath()
            }
        }
        set {
            switch selectedTab {
            case 0:
                homePath = newValue
            case 1:
                discoveryPath = newValue
            case 2:
                profilePath = newValue
            default:
                break
            }
        }
    }
    
    var historys: [AppPage<AnyView>] {
        get {
            switch selectedTab {
            case 0:
                return homeHistory
            case 1:
                return discoveryHistory
            case 2:
                return profileHistory
            default:
                return []
            }
        }
        set {
            switch selectedTab {
            case 0:
                homeHistory = newValue
            case 1:
                discoveryHistory = newValue
            case 2:
                profileHistory = newValue
            default:
                break
            }
        }
    }
    
    
    var routes: [String] {
        return historys.map({ e in
            return e.route
        });
    }
    
    var routeNames: [String] {
        return historys.map({ e in
            return String("\(e.route)".split(separator: ".").last ?? "");
        });
    }

    
    static let shared = Router()
    private init() {}
    
    // 添加中间件
    func addMiddleware(_ middleware: RouterMiddleware) {
        middlewares.append(middleware)
    }
    
    // 通过路由导航
    func toNamed(_ route: String, arguments: [String: Any] = [:]) {
        guard let page = RouteRegistry.shared.page(for: route, arguments: arguments) else {
            print("⚠️ Route not found: \(route)")
            return
        }
        
        // 执行中间件
        var finalPage = page
        for middleware in middlewares {
            if let redirected = middleware.redirect(page) {
                finalPage = redirected
                break
            }
        }
        
        withAnimation {
            isPresented = false
            self.historys.append(finalPage)
            self.path.append(finalPage)        
            log(prefix: "push >>> ")
   
            withAnimation {
                self.isPresented = true
            }
        }
    }
    
    // 返回上一页
    func back(count: Int = 1) {
        withAnimation {
            isPresented = false
            if self.historys.count >= count {
                self.historys.removeLast(count)
                self.path.removeLast(count)
            }
            
            DDLog("back path: \(path.count), \(path == homePath), \(["homeHistory": homeHistory.count,])")
            log(prefix: "pop >>> ")
            
            withAnimation {
                self.isPresented = true
            }
        }
    }
    
    // pop 方法作为 back 的别名
    func pop() {
        back()
    }
    
    // 返回到根页面
    func backToRoot() {
        back(count: self.path.count)
    }
    
    // 获取当前页面
    var currentPage: AppPage<AnyView>? {
        return historys.last
    }
    
    // 获取当前参数
    var currentArgs: [String: Any]? {
        currentPage?.arguments
    }
    
    func log(prefix: String = ""){
        DDLog("\(prefix) path: \(path.count), \(path == path), \(path == homePath), \(["homeHistory": homeHistory.count, "discoveryHistory": discoveryHistory.count, "profileHistory": profileHistory.count,]) routes: \(routeNames)")

    }
}

// 视图修饰器，用于添加导航标题和返回按钮
struct NavigationBarModifier: ViewModifier {
    let title: String
    let hideBack: Bool
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var router = Router.shared
    
    init(title: String, hideBack: Bool = false) {
        self.title = title
        self.hideBack = hideBack
    }
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
//            .toolbarColorScheme(.dark, for: .navigationBar)
//            .toolbarBackground(.black, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(for: AppPage<AnyView>.self) { page in
                page.makeView()
            }
            .toolbar {
                if !hideBack {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            router.back()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
    }
}

// 自定义转场效果
struct ScaleTransition: ViewModifier {
    let isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPresented ? 1 : 0.95)
            .opacity(isPresented ? 1 : 0)
            .animation(.spring(response: 0.35, dampingFraction: 1), value: isPresented)
    }
}

extension View {
    func navigationBar(title: String, hideBack: Bool = false) -> some View {
        modifier(NavigationBarModifier(title: title, hideBack: hideBack))
    }
    
    func scaleTransition(isPresented: Bool) -> some View {
        modifier(ScaleTransition(isPresented: isPresented))
    }
} 
