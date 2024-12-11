//
//  CGRectContainsView.swift
//  SwiftUIWorkspace
//
//  Created by Siran Li on 12/11/24.
//

import SwiftUI

struct CGRectContainsView: View {
    var body: some View {
        let rect1 = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rect2 = CGRect(x: 10, y: 10, width: 50, height: 50)
        let rect3 = CGRect(x: 150, y: 150, width: 50, height: 50)
        
        if CGRectContainsRect(rect1, rect2) {
            print("Rect1 contains Rect2")
        } else {
            print("Rect1 does not contain Rect2")
        }
        
        print(rect1.contains(rect2)) // true
        print(rect1.contains(rect3)) // false
        
        return Rectangle()
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .overlay(
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 50, height: 50)
                    .position(x: 50, y: 50)
            )
            .overlay(
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 50, height: 50)
                    .position(x: 200, y: 200)
            )
    }
}

extension CGRect {
    func contains(_ rect: CGRect) -> Bool {
        return minX <= rect.minX &&
               minY <= rect.minY &&
               maxX >= rect.maxX &&
               maxY >= rect.maxY
    }
}

#Preview {
    CGRectContainsView()
}

/*
 let rect1 = CGRect(x: 0, y: 0, width: 100, height: 100)
 let rect2 = CGRect(x: 10, y: 10, width: 50, height: 50)
 let rect3 = CGRect(x: 150, y: 150, width: 50, height: 50)

 let containsRect2 = rect1.contains(rect2)
 let containsRect3 = rect1.contains(rect3)

 print("Rect1 contains Rect2: \(containsRect2)") // prints: true
 print("Rect1 contains Rect3: \(containsRect3)") // prints: false
 */
