//
//  PathView.swift
//  MichaelChang-Lab3
//
//  Created by labuser on 6/28/18.
//  Copyright © 2018 wustl. All rights reserved.
//
// Credits
// 1. How to smooth ends of Bezier paths (https://stackoverflow.com/questions/25809347/how-to-smooth-the-joint-of-lines-in-bezier-path)

import Foundation
import UIKit

class PathView {
    
    private let path = UIBezierPath()
    
    private var points: [CGPoint] = []
    
    private var color : UIColor
    
    init (initPoint: CGPoint, lineWidth: CGFloat, color: UIColor) {
        self.color = color
        self.points.append(initPoint)
        path.move(to: initPoint)
        print("added initial point: (\(points[0].x), \(points[0].y))")
        self.path.lineWidth = lineWidth
        self.path.lineCapStyle = .round
        self.path.lineJoinStyle = .round
    }
    
    func setColor(newColor : UIColor) {
        color = newColor
    }
    
    func addPoint(point : CGPoint) {
        points.append(point)
        if points.count >= 2 {
            let index = points.count - 1
            let currentPoint = points[index - 1]
            let nextPoint = points[index]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
            path.addLine(to: nextPoint)
        }
    }
    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        let midX = (first.x + second.x) / 2
        let midY = (first.y + second.y) / 2
        return CGPoint(x: midX, y: midY)
    }

    func draw() {
        color.setStroke()
        path.stroke()
    }    
}
