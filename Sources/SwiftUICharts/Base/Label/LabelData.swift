//
//  LabelData.swift
//  testeCharts
//
//  Created by Joao Gabriel Pereira on 23/08/20.
//  Copyright © 2020 Joao Gabriel. All rights reserved.
//

import Foundation

public class LabelData: ObservableObject {
    @Published public var title = String()

    public init(_ title: String) {
        self.title = title
    }

    public init() {
        self.title = String()
    }
}
