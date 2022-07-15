//
//  ChartView.swift
//  Drinto
//
//  Created by HiroakiSaito on 2022/07/14.
//

import Foundation
import UIKit

struct ParameterInfo {
    var value1: Int
    var value2: Int
    var value3: Int
    var value4: Int
    var value5: Int
    var value6: Int
    var pointValue: [Int]
    init (value1: Int, value2: Int, value3: Int, value4: Int, value5: Int, value6: Int) {
        self.value1 = value1
        self.value2 = value2
        self.value3 = value3
        self.value4 = value4
        self.value5 = value5
        self.value6 = value6
        pointValue = [value1, value2, value3, value4, value5, value6]
    }
}

class ChartView: UIView {
    private var valueInfo: ParameterInfo = ParameterInfo(
        value1: 0,
        value2: 0,
        value3: 0,
        value4: 0,
        value5: 0,
        value6: 0
    )

    func configure(valueInfo: ParameterInfo) {
        self.valueInfo = valueInfo
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let center: CGPoint = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let topCount: Int = 6
        let radFromPoint = pointToRad(point: topCount)
        let fixBodar = [1, 2, 3, 4, 5]
        fixBodar.forEach {
            fixPolygon(size: $0)
        }
        drawPolygon()

        func fixPolygon(size: Int) {
            context?.setStrokeColor(UIColor.black.cgColor)

            var points: [CGPoint] = []

            for topCountNum in 0 ..< topCount {
                let point: CGPoint = CGPoint(
                    x: xPoint(topCount: topCountNum,
                                    value: size,
                              rad: radFromPoint,
                              center: center
                                   ),
                    y: yPoint(topCount: topCountNum,
                                    value: size,
                              rad: radFromPoint,
                              center: center
                                   )
                )
                points.append(point)
            }

            let path = UIBezierPath()
            path.lineWidth = 1
            path.move(to: points[0])
            for topCountNum in 1 ..< topCount {
                path.addLine(to: points[topCountNum])
            }
            path.close()
            path.stroke()
        }

        func drawPolygon() {
            context?.setStrokeColor(UIColor.blue.cgColor)
            context?.setFillColor(UIColor.blue.cgColor)
            context?.setAlpha(0.8)

            var points: [CGPoint] = []

            for topCountNum in 0 ..< topCount {
                let point: CGPoint = CGPoint(
                    x: xPoint(
                        topCount: topCountNum,
                        value: valueInfo.pointValue[topCountNum],
                        rad: radFromPoint,
                        center: center),
                    y: yPoint(
                        topCount: topCountNum,
                        value: valueInfo.pointValue[topCountNum],
                        rad: radFromPoint,
                        center: center
                    )
                )
                points.append(point)
            }

            let path = UIBezierPath()
            path.lineWidth = 1
            path.move(to: points[0])
            for topCountNum in 1 ..< topCount {
                path.addLine(to: points[topCountNum])
            }
            path.close()
            path.fill()
        }
    }

    func pointToRad(point: Int) -> CGFloat {
        let rad: CGFloat = CGFloat(toRadian(degree: 360 / Float(point)))
        return rad
    }

    func toRadian(degree: Float) -> Float {
        degree / 180 * .pi
    }

    func xPoint(topCount: Int, value: Int, rad: CGFloat, center: CGPoint) -> CGFloat {
        center.x + CGFloat(value) * (min(center.x, center.y) / 5) * cos((rad * CGFloat(topCount - 1)) - .pi / 2)
    }
    func yPoint(topCount: Int, value: Int, rad: CGFloat, center: CGPoint) -> CGFloat {
        center.y + CGFloat(value) * (min(center.x, center.y) / 5) * sin((rad * CGFloat(topCount - 1)) - .pi / 2)
    }
}
