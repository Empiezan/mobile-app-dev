//
//  PathView.swift
//  MichaelChang-Lab3
//
//  Created by labuser on 6/28/18.
//  Copyright © 2018 wustl. All rights reserved.
//

import Foundation
import UIKit

class PathView {
    
    let path = UIBezierPath()
    
    var points: [CGPoint] = []
    
    init (initPoint : CGPoint) {
        self.points.append(initPoint)
        path.move(to: initPoint)
        print("added initial point: (\(points[0].x), \(points[0].y))")
    }
    
//    func removeLastPoint() -> Bool {
//        if points.count > 0 {
//            print("removing last point")
//            points.removeLast()
//            return true
//        }
//        else {
//            print("no points left")
//            return false
//        }
//    }
    
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
        UIColor.black.setStroke()
        path.stroke()
    }
    
//    private func draw() {
//        let firstPoint = points[0]
//        let secondPoint = points[1]
//        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
//        path.move(to: firstPoint)
//        path.addLine(to: firstMidpoint)
//        for index in 1 ..< points.count-1 {
//            let currentPoint = points[index]
//            let nextPoint = points[index + 1]
//            let midPoint = midpoint(first: currentPoint, second: nextPoint)
//            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
//        }
//        guard let lastLocation = points.last else { return }
//        path.addLine(to: lastLocation)
//    }
    
}
