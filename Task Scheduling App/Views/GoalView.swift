//
//  GoalView.swift
//  Task Scheduling App
//
//  Created by Brendan Chan on 2023-12-05.
//

import SwiftUI

struct GoalView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ColorSelectionView: View {
    @Binding var selectedColor: GoalColor

    var body: some View {
        HStack {
            ForEach(GoalColor.allCases, id: \.self) { color in
                color.color
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        selectedColor = color
                    }
            }
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
