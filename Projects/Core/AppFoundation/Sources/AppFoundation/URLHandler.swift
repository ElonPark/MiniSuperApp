//
//  URLHandler.swift
//
//
//  Created by Elon on 2022/07/21.
//

import Foundation

public protocol URLHandler: AnyObject {
  func handle(_ url: URL)
}
