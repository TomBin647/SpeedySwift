//
//  AppBubbleTabBar.swift
//  App1125
//
//  Created by 2020 on 2020/11/25.
//

import UIKit
/// 默认两个tab，一个凸起
public class AppBubbleTabBar: UITabBar {
    
    public var onSelect: ((Int) -> ())?
    public var bgImageName:String!
    public var centerBtnImageName:String!
    public var centerBtnTag = 0

    private var centerBtn:UIButton?
    private var bgImageView = UIImageView()
    private var buttonImage:UIImage?{
        didSet{
            centerBtn?.image = buttonImage
        }
    }
    
    public init(frame: CGRect,bgImageName: String, centerBtnImageName:String) {
        super.init(frame: frame)
        self.bgImageName = bgImageName
        self.centerBtnImageName = centerBtnImageName
        buildUI()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        buildUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildUI() {
        // 去掉系统tabBar的顶部细线
        barStyle = .black
        backgroundImage = UIImage()
        shadowImage = UIImage()
        // 背景
        bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: App.w, height: App.safeBottomHeight + 49))
        bgImageView.image = UIImage(named: bgImageName)
        bgImageView.backgroundColor = .clear
        addSubview(bgImageView)
        // 中间按钮
        let button_w: CGFloat = App.w/3
        let centerBtnHeight: CGFloat = 59.0
        let centerBtnOffSetY: CGFloat = 28
        let button = UIButton(frame: CGRect(x: button_w, y: -centerBtnOffSetY, width: button_w, height: centerBtnHeight))
        centerBtn = button
        buttonImage = UIImage(named: centerBtnImageName)
        button.tag = 1
        button.addTarget(self, action: #selector(tabBarButtonClicked(sender:)), for: .touchUpInside)
        self.addSubview(button)
        
    }
    
    @objc private func tabBarButtonClicked(sender: UIButton) {
        if let handler = self.onSelect {
            handler(sender.tag)
        }
    }
    //处理超出区域点击无效的问题
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !isHidden{
            //转换坐标
            if let tempPoint = centerBtn?.convert(point, from: self){
                //判断点击的点是否在按钮区域内
                if centerBtn?.bounds.contains(tempPoint) ?? false{
                    // 返回按钮
                    return centerBtn
                }
            }
        }
        return super.hitTest(point, with: event)
    }
}
