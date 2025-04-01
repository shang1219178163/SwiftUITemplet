//
//  ButtonDemoPage.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/27.
//

import SwiftUI

struct ButtonDemoPage: View {
  
    @StateObject private var router = Router.shared
    @State var isToggle: Bool = false
    
    @State var slideValue = 0.0
    @State var stepValue = 5
    @State var stepperValue = 0
    
    @State var showPop: Bool = false
    @State var pickerIndex: Int = 0
    @State var dateSelection: Date = Date()
    @State var hourSelection: Date = Date()

    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView(.vertical, showsIndicators: true) {
                
                VStack(alignment: .leading, spacing: 10, content: {
                    NSectionView(title: "Button", desc: "", content: {
                        
                        Wrap(alignment: .leading) {
                            Button("Default") {}.buttonStyle(DefaultButtonStyle())
                            Button("Plain") {}.buttonStyle(PlainButtonStyle())
                            Button("Bordered") {}.buttonStyle(BorderedButtonStyle())
                            Button("Prominent") {}.buttonStyle(BorderedProminentButtonStyle())
                            
                            Button("CustomButtonStyle") {
                                DDLog("CustomButtonStyle")
                            }
                            .buttonStyle(CustomButtonStyle())
                        }
                        
                        Button(action: {
                            DDLog("普通按钮")
                        }, label: {
                            Text("普通按钮\n字体 20, \n白色, \n绿色背景色, \n圆角 8, \n红色边框线 2, \n抗锯齿, \n透明度 1.0")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        })
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .background(RoundedRectangle(cornerRadius: 8, style: .circular).fill(.green))
//                        .foregroundColor(.green)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.red, lineWidth: 2))
                        .cornerRadius(8, antialiased: true)
                        .opacity(1.0)
        
                        Button(action: {
                            DDLog("图标按钮: 渐进色背景")
                        }, label: {
                            HStack(content: {
                                Image(systemName: "trash")
                                    .font(.system(size: 20))
                                Text("带图标按钮")
                                    .font(.system(size: 20))
                            })
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(
                                gradient: Gradient(
                                    colors: [Color.green, Color.blue]),
                                startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            )
//                            .cornerRadius(40)
                        })
             

                        
                    })
                    NSectionView(title: "Toggle", desc: "", content: {
                        Toggle(isOn: $isToggle) {
                            Text("开关状态: \(self.isToggle ? "打开" : "关闭")")
                        }
                    })
                                        
                    NSectionView(title: "Stepper", desc: "步长为 5", content: {
                        Stepper(value: $stepperValue, step: stepValue, label: {
                            Text("步进值为 [\(self.stepperValue)]")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        })
                        
                        Stepper(label: {
                            Text("步进值为 [\(self.stepperValue)]")
                                .foregroundColor(.gray)
                                .font(.system(size: 14))
                        }, onIncrement: {
                            self.stepperValue += self.stepValue
                        }, onDecrement: {
                            self.stepperValue -= self.stepValue
                        }, onEditingChanged: { editing in
                            DDLog("Stepper onEditingChanged \(editing)")
                        })
                    })
                    
                    NSectionView(title: "Slider", desc: "", content: {
                        Slider(value: $slideValue, in: 0...100, label: {
                            Text("貌似没什么用")
                        }, minimumValueLabel: {
                            Text("0")
                        }, maximumValueLabel: {
                            Text("\(self.slideValue.toString(0))/100")
                        })
                    })
                    
                    NSectionView(title: "Picker", desc: "", content: {
                        Text("DefaultPickerStyle:")
                        Picker("请选择", selection: $pickerIndex, content: {
                            ForEach(0..<5) { idx in
                                Text("选项 \(idx)")
                            }
                        })
                        .pickerStyle(DefaultPickerStyle())
                        .frame(width: UIScreen.main.bounds.width-30, height: 40)
                        
                        Text("MenuPickerStyle:")
                        Picker("请选择", selection: $pickerIndex, content: {
                            ForEach(0..<5) { idx in
                                Text("选项 \(idx)")
                            }
                        })
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: UIScreen.main.bounds.width-30, height: 40)

                        Text("SegmentedPickerStyle:")
                        Picker("请选择", selection: $pickerIndex, content: {
                            ForEach(0..<5) { idx in
                                Text("选项 \(idx)")
                            }
                        })
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Text("WheelPickerStyle:")
                        Picker("请选择", selection: $pickerIndex, content: {
                            ForEach(0..<5) { idx in
                                Text("选项 \(idx)")
                            }
                        })
                        .pickerStyle(WheelPickerStyle()).frame(height: 200)
                        
                        Text("InlinePickerStyle:")
                        Picker("请选择", selection: $pickerIndex, content: {
                            ForEach(0..<5) { idx in
                                Text("选项 \(idx)")
                            }
                        }).pickerStyle(InlinePickerStyle()).frame(height: 200)
                        
                        Text("NavigationLinkPickerStyle:")
                        Picker("请选择", selection: $pickerIndex, content: {
                            ForEach(0..<5) { idx in
                                Text("选项 \(idx)")
                            }
                        })
                        .pickerStyle(NavigationLinkPickerStyle()).frame(height: 100)
                    })
                    
                    NSectionView(title: "DatePicker", desc: "", content: {
                        Text("日期选择: \(dateSelection.fmt().prefix(11))\(hourSelection.fmt().suffix(8))")

                        HStack {
                            DatePicker(selection: $dateSelection, displayedComponents: .date, label: {
                                Text("日期")
                            })
                            DatePicker(selection: $hourSelection, displayedComponents: .hourAndMinute, label: {
                                Text("时间")
                            })
                        }.frame(width: UIScreen.main.bounds.width-30, height: 40)
                    
                        DatePicker(
                            "日期选择",
                            selection: $dateSelection,
                            displayedComponents: .date
                        ).datePickerStyle(WheelDatePickerStyle())
                            .padding(.vertical, 20)
                        DatePicker(
                            "时间选择",
                            selection: $hourSelection,
                            displayedComponents: .hourAndMinute
                        ).datePickerStyle(WheelDatePickerStyle())
                            .padding(.vertical, 20)
                    })
                        
                
                }).padding(10)
            }
            .navigationBarCustom(title: "\(clsName)")
  //            .navigationDestination(for: AppPage<AnyView>.self) { page in
  //                page.makeView()
  //            }
        }
    }
}

#Preview {
    ButtonDemoPage()
}
