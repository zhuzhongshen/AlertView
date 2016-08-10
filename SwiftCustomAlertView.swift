//
//  SwiftCustomAlertView.swift
//  HiMove
//
//  Created by nihao on 16/8/2.
//  Copyright © 2016年 爱淘记. All rights reserved.
//

import UIKit

@objc protocol SwiftCustomAlertViewDelegate : NSObjectProtocol{
    
    optional func  selectOkButtonalertView()
    
    optional func  selecttCancelButtonAlertView()
    
}

class SwiftCustomAlertView: UIView {

    private let defaultWidth        = 280.0  //默认Alert宽度
    private let defaultHeight       = 146.0  //默认Alert高度
    private let defaultCornerRadius = 5.0    //默认Alert 圆角度数
    
    private var viewY:Double!
    private var viewWidth: Double!
    private var viewHeight: Double!
    
    private var cancelButtonTitle: String?
    private var oKButtonTitle: String?
    
    private var cancelButton: UIButton?
    private var oKButton: UIButton?
    
    private var title: String?
    private var message: String?
    
    private var titleLabel: UILabel!
    private var messageLabel: UILabel!
    
    var cornerRadius: Double!
    
    weak var delegate: SwiftCustomAlertViewDelegate? // delegate
    
    
    
    //初始化
    init(title: String?, message: String?, delegate: SwiftCustomAlertViewDelegate?) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: defaultWidth, height: defaultHeight))
        
        setup(title, message: message,delegate: delegate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //设置相关数据
    private func setup(title: String?, message: String?,delegate: SwiftCustomAlertViewDelegate?) {
        
        self.title = title
        self.message = message
        self.delegate = delegate
        self.setUpDefaultValue()
        self.setUpElements()
    }
    
    //默认参数
    private func setUpDefaultValue() {
        
        clipsToBounds = true
        cancelButtonTitle = "取消"
        oKButtonTitle = "确定"
        viewWidth = defaultWidth
        viewHeight = defaultHeight
        cornerRadius = defaultCornerRadius
        layer.cornerRadius = CGFloat(cornerRadius)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    //设置相关ui
    private func setUpElements() {
        titleLabel = UILabel(frame: CGRectZero)
        messageLabel = UILabel(frame: CGRectZero)
        
        if title != nil {
            titleLabel.text = title
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            titleLabel.textColor = UIColor.blackColor()
            titleLabel.font = UIFont.boldSystemFontOfSize(17)
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.backgroundColor = UIColor.clearColor()
            addSubview(titleLabel)
        }
        if message != nil {
            messageLabel.text = message
            messageLabel.numberOfLines = 0
            messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            messageLabel.textColor = UIColor.blackColor()
            messageLabel.font = UIFont.systemFontOfSize(13)
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.backgroundColor = UIColor.clearColor()
            addSubview(messageLabel)
        }
        
        
        if let cancelTitle = cancelButtonTitle {
            
            cancelButton = UIButton(type: UIButtonType.Custom)
            
            cancelButton!.setTitle(cancelTitle, forState: UIControlState.Normal)
            
            cancelButton!.backgroundColor = UIColor.blueColor()
            
            cancelButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            cancelButton!.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
            
            cancelButton?.tag = 9
            
            addSubview(cancelButton!)
        }
        
        if let okTitle = oKButtonTitle {
            
            oKButton = UIButton(type: UIButtonType.Custom)
            
            oKButton!.setTitle(okTitle, forState: UIControlState.Normal)
            
            oKButton!.backgroundColor = UIColor.yellowColor()
            
            oKButton!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            oKButton!.titleLabel?.font = UIFont.boldSystemFontOfSize(17)
            
            oKButton?.tag = 10
            
            addSubview(oKButton!)
        }
        
        
    }
    
    private func layoutFrameshowing() {
        
        cancelButton!.addTarget(self, action: #selector(SwiftCustomAlertView.cancelButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        cancelButton!.frame = CGRect(x: viewWidth/2, y: viewHeight-40, width: viewWidth/2, height: 40)
        
        oKButton!.addTarget(self, action: #selector(SwiftCustomAlertView.okButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        oKButton!.frame = CGRect(x:0, y: viewHeight-40, width: viewWidth/2, height: 40)
        
        if title != nil {
            
            titleLabel.frame = CGRect(x: 10, y: 5, width: viewWidth - 20, height: 20)
            
        }
        if message != nil {
            messageLabel.frame = CGRect(x: 10, y: 0, width: viewWidth - 20, height: 0)
            labelHeightToFit(messageLabel)
        }
        
        if message != nil {
            
            messageLabel.center = CGPoint(x: viewWidth/2, y: 5 + Double(titleLabel.frame.size.height) + 20 + Double(messageLabel.frame.size.height)/2)
        }
        
        
    }
    private func labelHeightToFit(label: UILabel) {
        
        let maxWidth = label.frame.size.width - 20
        let maxHeight : CGFloat = 500
        let rect = label.attributedText?.boundingRectWithSize(CGSizeMake(maxWidth, maxHeight),
                                                              options: .UsesLineFragmentOrigin, context: nil)
        var frame = label.frame
        frame.size.height = rect!.size.height
        label.frame = frame
    }
    
    
    func cancelButtonClicked(button: UIButton) {
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.center = CGPoint(x: -self.viewWidth , y:self.viewY + self.viewHeight/2)
            
        }) { (Bool) -> Void in
            
            self.removeFromSuperview()
        }
        
        if delegate?.respondsToSelector(#selector(SwiftCustomAlertViewDelegate.selecttCancelButtonAlertView)) == true {
            
            print("cancelDelegate")
            
            delegate?.selecttCancelButtonAlertView!()
        }
        
        
    }
    func okButtonClicked(button: UIButton) {
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.center = CGPoint(x:Double(UIScreen .mainScreen().bounds.size.width)+self.viewWidth , y:self.viewY + self.viewHeight/2)
            
        }) { (Bool) -> Void in
            
            self.removeFromSuperview()
        }
        
        if delegate?.respondsToSelector(#selector(SwiftCustomAlertViewDelegate.selectOkButtonalertView)) == true {
            
            delegate?.selectOkButtonalertView!()
        }
        
    }
    
    func show() {
        
        if let window: UIWindow = UIApplication.sharedApplication().keyWindow {
            show(window)
        }
    }
    
    func show(view: UIView) {
        
        layoutFrameshowing()
        
        self.viewY = (Double(view.frame.size.height) - viewHeight)/2
     
        self.frame = CGRect(x: (Double(view.frame.size.width) - viewWidth)/2, y: viewY, width: viewWidth, height: viewHeight)
        
        view.addSubview(self)
        
        view.bringSubviewToFront(self)
        
        self.alpha = 0.3
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseOut, animations: {
            
            self.alpha = 1;
            self.transform =  CGAffineTransformMakeScale(0.8, 0.8)
            }, completion: { finished in
                
                UIView.animateWithDuration(0.2, animations: {() -> Void in
                    
                    self.transform = CGAffineTransformMakeScale(1.2, 1.2)
                    
                }) { (Bool) -> Void in
                    
                    UIView.animateWithDuration(0.1, animations: { () -> Void in
                        
                        self.transform = CGAffineTransformMakeScale(1, 1)
                    })
                }
        })
        
        
    }

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
