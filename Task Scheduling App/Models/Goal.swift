//
//  Goal.swift
//  Task Scheduling App
//
//  Created by Brendan Chan on 2023-12-03.
//

import SwiftUI

enum GoalColor: String, CaseIterable {
    case red, orange, yellow, green, blue, purple, pink, teal
    case brown, indigo, lime, olive, cyan, magenta, gray, black

    var color: Color {
        switch self {
        case .red:
            return .red
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .blue:
            return .blue
        case .purple:
            return .purple
        case .pink:
            return .pink
        case .teal:
            return .teal
        case .brown:
            return .brown
        case .indigo:
            return .indigo
        case .lime:
            return Color.green.opacity(0.7) // Adjust as needed
        case .olive:
            return Color.green.opacity(0.5) // Adjust as needed
        case .cyan:
            return .cyan
        case .magenta:
            return .pink.opacity(0.7) // Adjust as needed
        case .gray:
            return .gray
        case .black:
            return .black
        }
    }
}
