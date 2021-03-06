//
//  GameScene.swift
//  TheOne
//
//  Created by Howard on 12/4/14.
//  Copyright (c) 2014 Howard. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var route : RouteManager!
    
    override func didMoveToView(view: SKView) {
        let cellSize = 40
        let gap = 5
        let columnCount = Int(frame.width) / (cellSize + gap)
        let rowCount = Int(frame.height) / (cellSize + gap)
        route = RouteManager(column: columnCount, row: rowCount)
    
        for rowIndex in 0...(rowCount) {
            for columnIndex in 0...(columnCount) {
                let left = columnIndex * (cellSize + gap)
                let top = rowIndex * (cellSize + gap)
                let cell = RouteCell(color: UIColor.whiteColor(), size: CGSizeMake(CGFloat(cellSize), CGFloat(cellSize)))
                cell.anchorPoint = CGPointMake(0, 0)
                cell.position = CGPoint(x: left, y: top)
                cell.color = UIColor.whiteColor()
                cell.name = "\(rowIndex)_\(columnIndex)"
                cell.rowIndex = rowIndex
                cell.columnIndex = columnIndex
                addChild(cell)
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if(node is RouteCell) {
                let routeCell = node as RouteCell
                let currentCellType = routeCell.cellType.rawValue
                routeCell.cellType = CellType(rawValue: ((currentCellType + 1) % 5))!
                
                var start : PointInt?
                var destination : PointInt?
                
                if routeCell.cellType == .destination {
                    var rowIndex = 0
                    for row in route.matrix {
                        var columnIndex = 0
                        for column in row {
                            let currentCell = self.childNodeWithName("\(rowIndex)_\(columnIndex)")
                            let routeCell = currentCell as? RouteCell
                            
                            if routeCell != nil {
                                let isBlock = (routeCell?.cellType == CellType.block)
                                route.matrix[rowIndex][columnIndex] = isBlock
                                
                                if routeCell?.cellType == CellType.start {
                                    start = PointInt(x:columnIndex, y:rowIndex)
                                }
                                else if routeCell?.cellType == CellType.destination {
                                    destination = PointInt(x:columnIndex, y:rowIndex)
                                }
                            }
                            columnIndex++
                        }
                        
                        rowIndex++;
                    }

                    if start != nil && destination != nil {
                        
                        let startTime = NSDate()
                        let result = route.route(start!, destination: destination!)
                        let stopTime = startTime.timeIntervalSinceNow * -1000
                        
                        println(stopTime)
                        
                        if result != nil {
                            for cell in result! {
                                let nodeName = "\(cell.y)_\(cell.x)"
                                let wayStop = self.childNodeWithName(nodeName) as? RouteCell
                                if wayStop != nil {
                                    wayStop!.cellType = CellType.stop
                                }
                            }
                        }
                    }
                }
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    enum CellType : Int {
        case normal = 0, block, start, destination, stop
    }
    
    class RouteCell : SKSpriteNode {
        private var _cellType = CellType.normal
        
        var rowIndex : Int = 0
        var columnIndex : Int = 0
        var cellType : CellType {
            get {
                return _cellType
            }
            set (newCellType) {
                _cellType = newCellType
                switch _cellType {
                case .normal:
                    self.color = UIColor.whiteColor()
                case .block:
                    self.color = UIColor.redColor()
                case .start:
                    self.color = UIColor.blueColor()
                case .destination:
                    self.color = UIColor.yellowColor()
                case .stop:
                    self.color = UIColor.greenColor()
                default:
                    println("Unknown cell type.")
                }
            }
        }
    }
}
