//
//  FinishTestViewController.swift
//  Hangul
//
//  Created by Ted Bennett on 03/05/2020.
//  Copyright © 2020 Ted Bennett. All rights reserved.
//

import UIKit
@IBDesignable
class FinishTestViewController: UIViewController {
    
    var wrongLetters = [String:String]()
    
    var score = 0.0
    
    @IBAction func homeButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var percentageWheelView: UIView!
    @IBOutlet weak var percentageStringOutlet: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        percentageStringOutlet.text = "\(Int(score*100))%"
        percentageWheelView.layer.addSublayer(createTrackWheel())
        percentageWheelView.layer.addSublayer(createPercentageWheel())
        
        
    }

//    var containerViewController: ResultsTableViewController?
//    let containerSegueName = "Results Table Segue"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Results Table Segue" {
            if let tableViewController = segue.destination as? ResultsTableViewController {
                tableViewController.populateTable(with: wrongLetters)
            }
        }
    }
    
    
    
    
    private func createPercentageWheel() -> CAShapeLayer {
        
        let shapeLayer = CAShapeLayer()
        let finalAngle = (2 * CGFloat.pi * CGFloat(score)) - (CGFloat.pi / 2)
        let centerPoint = CGPoint(x: percentageWheelView.bounds.midX, y: percentageWheelView.bounds.midY)
        let circularPath = UIBezierPath(arcCenter: centerPoint, radius: 80, startAngle: -CGFloat.pi / 2, endAngle: finalAngle, clockwise: true)
        shapeLayer.path = circularPath.cgPath

        if score > 0.8 {
        shapeLayer.strokeColor = UIColor.systemGreen.cgColor
        } else if score > 0.5 {
        shapeLayer.strokeColor = UIColor.systemOrange.cgColor
        } else {
        shapeLayer.strokeColor = UIColor.systemRed.cgColor
        }
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1.2
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "percentageAnimation")
        return shapeLayer
    }
    
    private func createTrackWheel() -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let centerPoint = CGPoint(x: percentageWheelView.bounds.midX, y: percentageWheelView.bounds.midY)
        let circularPath = UIBezierPath(arcCenter: centerPoint, radius: 80, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.systemGray.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.opacity = 0.2
        return shapeLayer
    }
}
