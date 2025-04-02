//
//  BaseTypeCodable.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/4/1.
//

public protocol BaseTypeCodable: Codable {
    static var defaultValue: Self { get }
}

extension Optional: BaseTypeCodable where Wrapped: BaseTypeCodable {
  public static var defaultValue: Optional<Wrapped> { .none }
}

extension Int: BaseTypeCodable {
  public static var defaultValue: Int { 0 }
}

extension String: BaseTypeCodable {
  public static var defaultValue: String { "" }
}

extension Double: BaseTypeCodable {
  public static var defaultValue: Double { 0.0 }
}

extension Bool: BaseTypeCodable {
  public static var defaultValue: Bool { false }
}


extension Dictionary: BaseTypeCodable where Value: BaseTypeCodable, Key: BaseTypeCodable {
  public static var defaultValue: Dictionary<Key, Value> { [:] }
}

extension Array: BaseTypeCodable where Element: BaseTypeCodable {
  public static var defaultValue: Array<Element> { [] }
}
