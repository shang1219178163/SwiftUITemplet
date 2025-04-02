import SwiftUI

struct DataTypeDemo: View {
    @State private var selectedTab = 0
    
    let tabItems: [(tag: Int, title: String, v: any View)] = [
        (tag: 0, title: "基础类型", v: BasicTypesView()),
        (tag: 1, title: "复杂类型", v: ComplexTypesView()),
        (tag: 2, title: "类型测试", v: TypeTestView()),
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // 顶部标签栏
            HStack(spacing: 0) {
                ForEach(0..<tabItems.count) { index in
                    Button(action: {
                        withAnimation {
                            selectedTab = index
                        }
                    }) {
                        Text(tabItems[$selectedTab.wrappedValue].title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                }
            }
            .background(Color.white)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.2)),
                alignment: .bottom
            )
            
            // 内容区域
            TabView(selection: $selectedTab) {
                tabItems[0].v
                    .tag(0)
                
                tabItems[1].v
                    .tag(1)
                
                tabItems[2].v
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .navigationTitle("数据类型")
    }
}

// 基础类型视图
struct BasicTypesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 整数类型
                TypeCard(title: "整数类型", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Int: \(Int.max)")
                        Text("Int8: \(Int8.max)")
                        Text("Int16: \(Int16.max)")
                        Text("Int32: \(Int32.max)")
                        Text("Int64: \(Int64.max)")
                        Text("UInt: \(UInt.max)")
                    }
                })
                
                // 浮点数类型
                TypeCard(title: "浮点数类型", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Float: \(Float.pi)")
                        Text("Double: \(Double.pi)")
                        Text("CGFloat: \(CGFloat.pi)")
                    }
                })
                
                // 布尔类型
                TypeCard(title: "布尔类型", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("true")
                        Text("false")
                    }
                })
                
                // 字符串类型
                TypeCard(title: "字符串类型", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("String: Hello World")
                        Text("Character: A")
                        Text("Substring: Hello")
                    }
                })
                
                // 可选类型
                TypeCard(title: "可选类型", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Optional<String>: Optional(\"Hello\")")
                        Text("Optional<Int>: Optional(42)")
                        Text("Optional<Double>: Optional(3.14)")
                    }
                })
            }
            .padding()
        }
    }
}

// 复杂类型视图
struct ComplexTypesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 数组
                TypeCard(title: "数组", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("[Int]: [1, 2, 3, 4, 5]")
                        Text("[String]: [\"A\", \"B\", \"C\"]")
                        Text("[Double]: [1.1, 2.2, 3.3]")
                    }
                })
                
                // 字典
                TypeCard(title: "字典", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("[String: Int]: [\"one\": 1, \"two\": 2]")
                        Text("[String: String]: [\"key\": \"value\"]")
                        Text("[Int: Any]: [1: \"one\", 2: 2.0]")
                    }
                })
                
                // 集合
                TypeCard(title: "集合", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Set<Int>: [1, 2, 3, 4, 5]")
                        Text("Set<String>: [\"A\", \"B\", \"C\"]")
                        Text("Set<Double>: [1.1, 2.2, 3.3]")
                    }
                })
                
                // 元组
                TypeCard(title: "元组", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("(Int, String): (1, \"one\")")
                        Text("(String, Double): (\"pi\", 3.14)")
                        Text("(Int, Int, String): (1, 2, \"three\")")
                    }
                })
                
                // 枚举
                TypeCard(title: "枚举", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("enum Direction {")
                        Text("    case north")
                        Text("    case south")
                        Text("    case east")
                        Text("    case west")
                        Text("}")
                    }
                })
                
                // 结构体
                TypeCard(title: "结构体", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("struct Point {")
                        Text("    var x: Double")
                        Text("    var y: Double")
                        Text("}")
                    }
                })
                
                // 类
                TypeCard(title: "类", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("class Person {")
                        Text("    var name: String")
                        Text("    var age: Int")
                        Text("}")
                    }
                })
            }
            .padding()
        }
    }
}


// 复杂类型视图
struct TypeTestView: View {
    typealias VoidCallback = () -> Void

//    lazy var items: [(name: String, action: () -> Void)] = [
//        (name: "测试", action: onArray)
//    ]
    
    func items() -> [(name: String, action: () -> Void)] {
        return [
            (name: "测试", action: onArray)
        ]
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                buildWrap(items: items(), alignment: .leading, itemBgColor: Color.blue);

                // 数组
                TypeCard(title: "数组", content: {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("[Int]: [1, 2, 3, 4, 5]")
                        Text("[String]: [\"A\", \"B\", \"C\"]")
                        Text("[Double]: [1.1, 2.2, 3.3]")
                    }
                }) 
            }
            .padding()
        }
    }
    
    private func buildWrap(
        items: [(name: String, action: () -> Void)],
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
                ForEach(0..<items.count) { i in
                    let e = items[i];
                    Text("选项_\(e.0)")
                        .padding(EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4))
                        .background(itemBgColor)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .onTapGesture { p in
                            e.1();
                        }
                }
            }.padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Divider()
        })
    }
    
    
    func onArray() -> Void {
        
    }
}

// 类型卡片视图
struct TypeCard<Content: View>: View {
    let title: String
    let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
            
            content()
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    NavigationView {
        DataTypeDemo()
    }
} 
