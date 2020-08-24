//
//  LabelBase+Extension.swift
//  testeCharts
//
//  Created by Joao Gabriel Pereira on 23/08/20.
//  Copyright © 2020 Joao Gabriel. All rights reserved.
//

import SwiftUI

extension View where Self: LabelBase {
    public func data(_ title: String) -> some View {
        labelData.title = title
        return self
            .environmentObject(labelData)
    }
}
