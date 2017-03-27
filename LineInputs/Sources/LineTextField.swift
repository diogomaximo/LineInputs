//
//  LineTextField.swift
//  LineInputs
//
//  Created by Diogo Maximo on 15/03/17.
//  Copyright © 2017 Diogo Maximo. All rights reserved.
//

import UIKit
@IBDesignable
class LineTextField: UITextField,UITextFieldDelegate {
    @IBInspectable var lineNormal: UIColor = UIColor.gray{
        didSet {
            if self.text!.characters.count == 0{
                self.lineView.backgroundColor = lineNormal
            }
        }
    }
    
    @IBInspectable var placeHolder: UIColor = UIColor.black{
        didSet {
            self.placeHolderLabel.textColor = lineSelected
        }
    }
    
    @IBInspectable var lineSelected: UIColor = UIColor.blue{
        didSet {
            if self.text!.characters.count > 0{
                self.lineView.backgroundColor = lineSelected
            }
        }
    }
    @IBInspectable var lineHeight: CGFloat = 1.0{
        didSet {
            let inputFrame =   CGRect(x: 0, y: bounds.height - lineHeight, width: bounds.width, height: lineHeight)
            lineView.frame = inputFrame
        }
    }

    
    var inputFont: UIFont = UIFont.boldSystemFont(ofSize: 14)
    var placeHolderFont: UIFont = UIFont.boldSystemFont(ofSize: 14)
    var placeHolderFloatFont: UIFont = UIFont.boldSystemFont(ofSize: 10)
    
    //Size of line
    var didCreatedLineInput:Bool = false;
    var lineView:UIView = UIView()
    var spaceToLine:Double = 2.0
    var spaceToPlaceholder:Double = 22
    var placeHolderLabel:UILabel  = UILabel()
    let animationOffSet:CGFloat = 23
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initComponent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initComponent()
    }
    
    func initComponent(){
        self.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if (!didCreatedLineInput) {
            createLineInput()
            createPlaceholder()
            initFloatLabel()
            didCreatedLineInput = true;
        }
        updateLayout()
    }
    
    func createLineInput(){
        let inputFrame =   CGRect(x: 0, y: bounds.height - lineHeight, width: bounds.width, height: lineHeight)
        lineView = UIView(frame: inputFrame)
        self.addSubview(lineView)
        lineView.backgroundColor = lineNormal
    }
    
    func createPlaceholder(){
        placeHolderLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        placeHolderLabel.text = self.placeholder
        placeHolderLabel.font = self.placeHolderFont
        self.placeholder = ""
        addSubview(placeHolderLabel)
    }
    
    func updateLayout(){
        self.borderStyle = .none
        placeHolderLabel.textColor = placeHolder
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showFloatLabel()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)  {
        hideFloatLabel()
    }
    
    func initFloatLabel(){
        self.lineView.backgroundColor = self.lineNormal
        if (self.text!.characters.count > 0) {
            self.placeHolderLabel.frame = CGRect(x: self.placeHolderLabel.frame.origin.x, y: self.placeHolderLabel.frame.origin.y-self.animationOffSet, width: self.placeHolderLabel.frame.size.width, height: self.placeHolderLabel.frame.size.height)
            self.placeHolderLabel.font = self.placeHolderFloatFont
            self.lineView.backgroundColor = self.lineSelected
        }
    }
    
    func showFloatLabel(){
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.lineView.backgroundColor = self.lineSelected
            if ( self.text?.characters.count == 0 ) {
                self.placeHolderLabel.frame = CGRect(x: self.placeHolderLabel.frame.origin.x, y: self.placeHolderLabel.frame.origin.y-self.animationOffSet, width: self.placeHolderLabel.frame.size.width, height: self.placeHolderLabel.frame.size.height)
                self.placeHolderLabel.font = self.placeHolderFloatFont
            }
        });
    }
    
    func hideFloatLabel(){
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.lineView.backgroundColor = self.lineNormal
            if ( self.text?.characters.count == 0 ) {
                self.placeHolderLabel.frame = CGRect(x: self.placeHolderLabel.frame.origin.x, y: self.placeHolderLabel.frame.origin.y+self.animationOffSet, width: self.placeHolderLabel.frame.size.width, height: self.placeHolderLabel.frame.size.height)
                self.placeHolderLabel.font = self.placeHolderFont
            }
        });
    }
    
    
    
    
}
