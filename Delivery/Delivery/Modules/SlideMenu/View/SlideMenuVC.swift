import Foundation
import UIKit
import SnapKit

protocol SlideMenuVCProtocol: AnyObject {
    
}

class SlideMenuVC: UIViewController, SlideMenuVCProtocol {
    
    var presenter: SlideMenuPresenterProtocol!
    
    private lazy var blurView: UIVisualEffectView = {
        var blur = UIBlurEffect(style: UIBlurEffect.Style.light)
        var view = UIVisualEffectView(effect: blur)
        view.alpha = 0
        return view
    }()
    
    lazy private var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .basicBackgroundColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy private var menuButton: SlideMenuButton = {
        var button = SlideMenuButton(type: .system)
        button.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.setTitle("   Menu", for: .normal)
        button.setImage(UIImage(named: "menu"), for: .normal)
        return button
    }()
    
    lazy private var profileButton: SlideMenuButton = {
        var button = SlideMenuButton(type: .system)
        button.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.setTitle("   Profile", for: .normal)
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        return button
    }()
    
    lazy private var basketButton: SlideMenuButton = {
        var button = SlideMenuButton(type: .system)
        button.addTarget(self, action: #selector(basketButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.setTitle("   Basket", for: .normal)
        button.setImage(UIImage(named: "CustomBasket"), for: .normal)
        return button
    }()
    
    lazy private var aboutButton: SlideMenuButton = {
        var button = SlideMenuButton(type: .system)
        button.addTarget(self, action: #selector(aboutButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.setTitle(" About us", for: .normal)
        button.setImage(UIImage(systemName: "house"), for: .normal)
        return button
    }()
    
    lazy private var reviewButton: SlideMenuButton = {
        var button = SlideMenuButton(type: .system)
        button.addTarget(self, action: #selector(reviewButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        button.setTitle("  Write review", for: .normal)
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapForCloseVC = UITapGestureRecognizer(target: self, action: #selector(tapForClose))
        view.addGestureRecognizer(tapForCloseVC)
        addElements()
        updateViewConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationSlideMenuOpen()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        blurView.alpha = 0
        
        blurView.snp.makeConstraints {
            $0.trailing.leading.top.bottom.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(0)
        }
        
        menuButton.snp.makeConstraints {
            $0.trailing.equalTo(view.snp.trailing).offset(view.frame.width)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
        }
        
        profileButton.snp.makeConstraints {
            $0.trailing.equalTo(view.snp.trailing).offset(view.frame.width)
            $0.top.equalTo(menuButton.snp.bottom).offset(32)
        }
        
        basketButton.snp.makeConstraints {
            $0.trailing.equalTo(view.snp.trailing).offset(view.frame.width)
            $0.top.equalTo(profileButton.snp.bottom).offset(32)
        }
        
        aboutButton.snp.makeConstraints {
            $0.trailing.equalTo(view.snp.trailing).offset(view.frame.width)
            $0.top.equalTo(basketButton.snp.bottom).offset(32)
        }
        
        reviewButton.snp.makeConstraints {
            $0.trailing.equalTo(view.snp.trailing).offset(view.frame.width)
            $0.top.equalTo(aboutButton.snp.bottom).offset(32)
        }
    }
    
//MARK: -Button actions
    
    @objc private func tapForClose(_ sender: UITapGestureRecognizer) {
        presenter.closeVC(viewController: self)
    }
    
    @objc private func menuButtonPressed(sender: UIButton) {
        animationSlideMenuClose()
        presenter.goToMenuButtonTapped()
    }
    
    @objc private func profileButtonPressed(sender: UIButton) {
        animationSlideMenuClose()
        presenter.goToProfileButtonTapped()
    }
    
    @objc private func basketButtonPressed(sender: UIButton) {
        animationSlideMenuClose()
        presenter.goToBasketButtonTapped()
    }
    
    @objc private func aboutButtonPressed(sender: UIButton) {
        animationSlideMenuClose()
    }
    
    @objc private func reviewButtonPressed(sender: UIButton) {
        animationSlideMenuClose()
    }
    
    private func addElements() {
        view.addSubview(blurView)
        view.addSubview(mainView)
        mainView.addSubview(menuButton)
        mainView.addSubview(profileButton)
        mainView.addSubview(basketButton)
        mainView.addSubview(aboutButton)
        mainView.addSubview(reviewButton)
    }
}

//MARK:  -Extension for animation open and close VC

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
