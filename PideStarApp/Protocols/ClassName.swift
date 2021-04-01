//
//  ClassName.swift
//  tanmia
//
//  Created by jaafar barek on 5/19/20.
//  Copyright © 2020 mohamad barek. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}
