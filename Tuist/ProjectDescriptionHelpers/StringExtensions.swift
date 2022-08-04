//
//  StringExtensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Elon on 2022/08/05.
//

extension StringProtocol {
  var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
