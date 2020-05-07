//
//  PresentationController.swift
//  practice_closure
//
//  Created by 塩見陵介 on 2020/05/08.
//  Copyright © 2020 つまようじ職人. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    
    var overLay: UIView!
    
    // 表示トランジション前に呼ばれる
    override func presentationTransitionWillBegin() {
        
        let containerView = self.containerView
        
        self.overLay = UIView(frame: containerView!.bounds)
        self.overLay.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(overlayDidTouch(_:)))]
        self.overLay.backgroundColor = UIColor.black
        self.overLay.alpha = 0.0
        containerView!.insertSubview(self.overLay, at: 0)
        // トランジション実行
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [unowned self] context in
        self.overLay.alpha = 0.5 }, completion: nil)
    }
    
    // 非表示トランジション前に呼ばれる
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            [unowned self] context in
            self.overLay.alpha = 0.0
        }, completion: nil)
    }
    
    // 非表示トランザクション後に行われる
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.overLay.removeFromSuperview()
        }
    }
    

    // 子のコンテナのサイズを返す
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height)
    }
    
     
    // レイアウト開始前に呼ばれる
    override func containerViewWillLayoutSubviews() {
        overLay.frame = containerView!.bounds
        self.presentedView!.frame = self.frameOfPresentedViewInContainerView
    }

    // オーバーレイの View をタッチしたときに呼ばれる
    @objc func overlayDidTouch(_ sender: Any) {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }

}
