//
//  RatingControl.swift
//  Food Tracker
//
//  Created by Lathike Basnayake on 10/09/16.
//  Copyright © 2016 Lathike Basnayake. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    //MARK: Properties
    
    let starCount = 5
    let spacing = 5
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var ratingButtons = [UIButton]()
    
    
    //MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        let emptyStarImage = UIImage(named: "emptyStar")
        let filledStarImage = UIImage(named: "filledStar")
        
        for _ in 0..<starCount{
            
            let button = UIButton()
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self,
                             action: #selector(RatingControl.ratingButtonTapped(_:)),
                             forControlEvents: .TouchDown)
            
            
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        return CGSize(width: width, height: buttonSize)
    }
    
    func updateButtonSelectionStates(){
        for(index, button) in ratingButtons.enumerate(){
            button.selected = index < rating
        }
    }
    
    //MARK: Button Action
    func ratingButtonTapped(button: UIButton){
        rating = ratingButtons.indexOf(button)! + 1
        updateButtonSelectionStates()
        
        print("tapped \(rating - 1)")
        
//        let indexOfTappedButton:Int = ratingButtons.indexOf(button)!
//        if indexOfTappedButton  > (rating - 1) {
//                // color all buttons before this
//            
//        }
//        
//        if button.backgroundColor == UIColor.redColor() {
//            button.backgroundColor = UIColor.yellowColor()
//            rating += 1
//        } else {
//            
//            if indexOfTappedButton == (rating - 1) {
//                button.backgroundColor = UIColor.redColor()
//                rating -= 1
//            }
//        }
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for(index, button) in ratingButtons.enumerate(){
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }

}
