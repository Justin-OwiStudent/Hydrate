//
//  HydrateWidgetBundle.swift
//  HydrateWidget
//
//  Created by Justin Koster on 2023/09/03.
//

import WidgetKit
import SwiftUI

@main
struct HydrateWidgetBundle: WidgetBundle {
    var body: some Widget {
        HydrateWidget()
        HydrateWidgetLiveActivity()
    }
}
