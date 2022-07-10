//
//  URLHandler.swift
//  MiniSuperApp
//
//  Created by Elon on 2022/07/10.
//

import Foundation

protocol URLHandler: AnyObject {
  func handle(_ url: URL)
}
