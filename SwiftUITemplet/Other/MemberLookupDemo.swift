//
//  MemberLookup.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2023/9/7.
//  Copyright © 2023 BN. All rights reserved.
//

import Foundation

import UIKit

class MemberLookupDemo: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        var model = TestModel(info: TestModel.Info(name: "helo"))
        model.name = "jackson";
        print(model.name)
        
        Setter(subject: UIView())
            .frame(CGRect(x: 0, y: 0, width: 100, height: 100))
            .backgroundColor(.white)
            .alpha(0.5)
            .subject;

    }
}



@dynamicMemberLookup
struct TestModel {
    
    struct Info {
        var name: String
    }
    
    var info: Info
    
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<Info, Value>) -> Value {
        get {
            return info[keyPath: keyPath]
        }
        set {
            info[keyPath: keyPath] = newValue
        }
    }
}


@dynamicMemberLookup
struct Wrapper<Content> {
    var content: Content
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<Content, Value>) -> Value {
        get {
            return content[keyPath: keyPath]
        }
        set {
            content[keyPath: keyPath] = newValue
        }
    }
}


@dynamicMemberLookup
struct Setter<Subject> {
    let subject: Subject
    
    subscript<Value>(dynamicMember keyPath: WritableKeyPath<Subject, Value>) -> ((Value) -> Setter<Subject>) {
        
        // 获取到真正的对象
        var subject = self.subject
        
        return { value in
            // 把 value 指派给 subject
            subject[keyPath: keyPath] = value
            // 回传的类型是 Setter 而不是 Subject
            // 因为使用Setter来链式，而不是 Subject 本身
            return Setter(subject: subject)
        }
    }
}



