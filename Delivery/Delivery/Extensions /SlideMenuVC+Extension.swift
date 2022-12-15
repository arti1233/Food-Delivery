//
//  SlideMenuVC+Extension.swift
//  Delivery
//
//  Created by Artsiom Korenko on 15.12.22.
//

import Foundation
import UIKit
import SnapKit 

extension SlideMenuVC {
    private func animationSlideMenuOpen() {
        mainView.snp.remakeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(view.frame.width * 0.6)
        }
    
        UIView.animate(withDuration: 0.2) {
            self.blurView.alpha = 1
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.menuButton.snp.remakeConstraints {
                $0.trailing.leading.equalToSuperview()
                $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32)
            }
            UIView.animate(withDuration: 0.1) {
                self.view.layoutIfNeeded()
            } completion: { _ in
                self.menuButton.snp.remakeConstraints {
                    $0.trailing.leading.equalToSuperview().inset(16)
                    $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(32)
                }
                UIView.animate(withDuration: 0.05) {
                    self.view.layoutIfNeeded()
                } completion: { _ in
                    self.profileButton.snp.remakeConstraints {
                        $0.trailing.leading.equalToSuperview()
                        $0.top.equalTo(self.menuButton.snp.bottom).offset(32)
                    }
                    UIView.animate(withDuration: 0.1) {
                        self.view.layoutIfNeeded()
                    } completion: { _ in
                        self.profileButton.snp.remakeConstraints {
                            $0.trailing.leading.equalToSuperview().inset(16)
                            $0.top.equalTo(self.menuButton.snp.bottom).offset(32)
                        }
                        UIView.animate(withDuration: 0.05) {
                            self.view.layoutIfNeeded()
                        } completion: { _ in
                            self.basketButton.snp.remakeConstraints {
                                $0.trailing.leading.equalToSuperview()
                                $0.top.equalTo(self.profileButton.snp.bottom).offset(32)
                            }
                            UIView.animate(withDuration: 0.1) {
                                self.view.layoutIfNeeded()
                            } completion: { _ in
                                self.basketButton.snp.remakeConstraints {
                                    $0.trailing.leading.equalToSuperview().inset(16)
                                    $0.top.equalTo(self.profileButton.snp.bottom).offset(32)
                                }
                                UIView.animate(withDuration: 0.05) {
                                    self.view.layoutIfNeeded()
                                } completion: { _ in
                                    self.aboutButton.snp.remakeConstraints {
                                        $0.trailing.leading.equalToSuperview()
                                        $0.top.equalTo(self.basketButton.snp.bottom).offset(32)
                                    }
                                    UIView.animate(withDuration: 0.1) {
                                        self.view.layoutIfNeeded()
                                    } completion: { _ in
                                        self.aboutButton.snp.remakeConstraints {
                                            $0.trailing.leading.equalToSuperview().inset(16)
                                            $0.top.equalTo(self.basketButton.snp.bottom).offset(32)
                                        }
                                        UIView.animate(withDuration: 0.05) {
                                            self.view.layoutIfNeeded()
                                        } completion: { _ in
                                            self.reviewButton.snp.remakeConstraints {
                                                $0.trailing.leading.equalToSuperview()
                                                $0.top.equalTo(self.aboutButton.snp.bottom).offset(32)
                                            }
                                            UIView.animate(withDuration: 0.1) {
                                                self.view.layoutIfNeeded()
                                            } completion: { _ in
                                                self.reviewButton.snp.remakeConstraints {
                                                    $0.trailing.leading.equalToSuperview().inset(16)
                                                    $0.top.equalTo(self.aboutButton.snp.bottom).offset(32)
                                                }
                                                UIView.animate(withDuration: 0.05) {
                                                    self.view.layoutIfNeeded()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func animationSlideMenuClose() {
        mainView.snp.remakeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(view.frame.width * 0.6)
            $0.leading.equalToSuperview().inset(-view.frame.width)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.blurView.alpha = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.presenter.closeVC(viewController: self)
        }
    }
}
