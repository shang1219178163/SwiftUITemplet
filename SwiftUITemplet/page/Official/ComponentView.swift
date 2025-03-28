//
//  ComponentView.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/19.
//

import SwiftUI

/// 基础组件
struct ComponentView: View {
       
    @StateObject private var router = Router.shared

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedDateNew: Date = Date()
    @State private var selectedTab = 0  // 用于控制当前选中的 Tab
    @State private var value: Double = 0.5
    @State private var stepperValue: Int = 0
    @State private var selectedFruit: String = "Apple"
    @State private var showAlert: Bool = false
    @State private var isSheetPresented: Bool = false
    @State private var isLarge: Bool = false
    @Namespace private var namespace
    
    
    var body: some View {
        NavigationStack(path: $router.path) {
            
            // ScrollView
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 20, content: {
           
                    // Text
                   Text("Hello, SwiftUI!")
                       .font(.title)
                       .foregroundColor(.blue)
                

                   // Image
                   Image(systemName: "star.fill")
                       .resizable()
                       .scaledToFit()
                       .frame(width: 50, height: 50)
                       .foregroundColor(.yellow)

                   // Button
                   Button(action: {
                       DDLog("Button tapped!")
                   }) {
                       Text("Tap Me")
                           .font(.headline)
                           .padding(10)
                           .background(.green)
                           .foregroundColor(.white)
                           .cornerRadius(8)
                   }

                   // Toggle
                   Toggle("Enable Feature", isOn: $isLarge)
                       .toggleStyle(SwitchToggleStyle(tint: .green))
                       .onTapGesture {
                           DDLog("Toggle \($isLarge.wrappedValue)")
                       }

                    LoginBoxView(username: $username, password: $password)
                    
                    
                   // DatePicker
                   DatePicker("Select Date", 
                              selection: $selectedDate,
                              displayedComponents: .date)
            
                
                    
                    // DatePicker
                    DatePicker("Select Time",
                               selection: $selectedDateNew,
                               displayedComponents: .hourAndMinute)
           
                    
                    HStack(content: {
                        Slider(value: $value, in: 0...1, step: 0.01)
                             .padding(.top, 10)
                        Text(String(format: "%.2f", $value.wrappedValue))
                    })
                

                   // Stepper
                   Stepper("Step count: \(stepperValue)", value: $stepperValue, in: 0...10)


                   // Picker
                   Picker("Select a fruit", selection: $selectedFruit) {
                       Text("Apple").tag("Apple")
                       Text("Banana").tag("Banana")
                       Text("Cherry").tag("Cherry")
                   }
                   .pickerStyle(SegmentedPickerStyle())

                    
                    Text("Select a fruit: \($selectedFruit.wrappedValue)")
                        .foregroundColor(.red)
                    
                   // List
                   let fruits = ["Apple", "Banana", "Cherry", "Date"]
                   List(fruits, id: \.self) { fruit in
                       Text(fruit)
                   }

                   // VStack
                   VStack {
                       Text("VStack")
                           .foregroundColor(.red)
                       Divider()
                       Text("Top")
                       Divider()
                       Text("Bottom")
                   }
                   .padding()
                   .overlay(                  // 通过 overlay 给视图添加边框
                       RoundedRectangle(cornerRadius: 8)
                           .stroke(Color.gray, lineWidth: 0.5) // 边框颜色和宽度
                   )
                    
                   // HStack
                   HStack {
                       Text("HStack")
                           .foregroundColor(.red)
                       Divider()
                       Text("Left")
                       Spacer()
                       Text("Right")
                   }
                   .padding()
                   .overlay(                  // 通过 overlay 给视图添加边框
                       RoundedRectangle(cornerRadius: 8)
                           .stroke(Color.gray, lineWidth: 0.5) // 边框颜色和宽度
                   )

                   // ZStack
                   ZStack {
                       Color.blue.opacity(0.5)
                           .edgesIgnoringSafeArea(.all)
                    
                       Text("ZStack")
                           .foregroundColor(.red)
                           .font(.title2)
                           .padding()
                   }

                   // Form
                   Form {
                       Section(header: Text("Personal Info")) {
                           TextField("Name", text: $username)
                           DatePicker("Birthday", selection: $selectedDate, displayedComponents: .date)
                       }
                       Button("Submit") {
                           print("Form submitted")
                       }
                   }.border(Color.black)

//                   // NavigationLink & NavigationView
//                   NavigationView {
//                       NavigationLink("Go to Details", destination: Text("Detail View"))
//                           .padding()
//                           .background(Color.blue)
//                           .foregroundColor(.white)
//                           .cornerRadius(10)
//                   }.border(Color.black)
//                        .padding(.top, 10)

         
                   // Alert
                   Button("Show Alert") {
                       showAlert = true
                   }
                   .alert(isPresented: $showAlert) {
                       Alert(title: Text("Important Message"), 
                             message: Text("This is an alert"),
                             dismissButton: .default(Text("OK")))
                   }

                   // Sheet
                   Button("Show Sheet") {
                       isSheetPresented.toggle()
                   }
                   .sheet(isPresented: $isSheetPresented) {
                       Text("This is a sheet")
                           .padding()
                   }

                   // MatchedGeometryEffect
                   VStack {
                       // Animation
                       Button("Animate - namespace") {
                           withAnimation {
                               isLarge.toggle()
                           }
                       }
                       
                       Text("Scaled Text")
                            .frame(maxWidth: .infinity)
                           .scaleEffect(isLarge ? 2 : 1)
                       
                       if isLarge {
                           Text("Large")
                               .matchedGeometryEffect(id: "text", in: namespace)
                               .font(.largeTitle)
                               .onAppear{
                                   DDLog("onAppear - Large")
                               }
                               .onDisappear {
                                   DDLog("onDisappear - Large")
                               }
                       } else {
                           Text("Small")
                               .matchedGeometryEffect(id: "text", in: namespace)
                               .font(.caption)
                               .onAppear{
                                   DDLog("onAppear - Small")
                               }
                               .onDisappear {
                                   DDLog("onDisappear - Small")
                               }
                       }

                       Button("Toggle Size") {
                           isLarge.toggle()
                       }
                   }       
                   .padding()
                    .overlay(                  // 通过 overlay 给视图添加边框
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 0.5) // 边框颜色和宽度
                    )
             
                    
                })
                .padding()
                
                
            }
            .navigationBarCustom(title: "\(clsName)")
  //            .navigationDestination(for: AppPage<AnyView>.self) { page in
  //                page.makeView()
  //            }
           }
    }
    
}

#Preview {
    ComponentView()
}
