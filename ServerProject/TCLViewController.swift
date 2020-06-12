//
// Created by Артём Нешко on 20/04/2019.
// Copyright © 2019 Артём Нешко. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Localize_Swift

class TCLViewController: UIViewController {
    
    // Если нужен большой заголовок для iOS 11+
    var prefersLargeTitles = true
    // Прячем навбар
    var prefersHiddenNavigationBar = false
    // Не показывать снова навбар при переходе на новый экран
    var doNotShowNavBarOnTransition = false
    //проверка цевата навбара для цевата текста на нем
    private var isLightAppearance = true
    
    private var ruBtn: UIButton?
    private var enBtn: UIButton?
    
    let db = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Pull to refresh
    private var pullToRefresher: UIRefreshControl!
    
    func configurePullToRefresher(collectionView: UICollectionView) {
        pullToRefresher = UIRefreshControl()
        pullToRefresher.tintColor = .white
        collectionView.alwaysBounceVertical = true
        pullToRefresher.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.refreshControl = pullToRefresher
    }
    
    @objc func refreshData() {
        assertionFailure("Override me!")
    }
    
    func stopRefresher() {
        pullToRefresher.endRefreshing()
    }
    
    // MARK: -
    // MARK: - Lifecycle
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeForLanguageChange()
        setupNavBarSeparator()
        extendedLayoutIncludesOpaqueBars = true
        automaticallyAdjustsScrollViewInsets = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if prefersHiddenNavigationBar {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        
//        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "techcongressLogoEng"))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if prefersHiddenNavigationBar && !doNotShowNavBarOnTransition {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
        doNotShowNavBarOnTransition = false
    }
    
    
    // MARK: -
    // MARK: - UI
    // MARK: -
    
    var tabBarInset: CGFloat {
        if #available(iOS 11.0, *) {
            return tabBarController?.tabBar.frame.size.height ?? 0.0
        }
        return .leastNormalMagnitude
    }
    
    func showNavBarSeparator(animated: Bool = false) {
        guard let navBarSeparatorView = view.viewWithTag(5000) else { return }
        
        if navBarSeparatorView.alpha == 0.0 {
            if animated {
                UIView.animate(withDuration: 0.2) {
                    navBarSeparatorView.alpha = 0.5
                }
            } else {
                navBarSeparatorView.alpha = 0.5
            }
        }
    }
    
    func hideNavBarSeparator(animated: Bool = false) {
        guard let navBarSeparatorView = view.viewWithTag(5000) else { return }
        
        if navBarSeparatorView.alpha == 0.5 {
            if animated {
                UIView.animate(withDuration: 0.2) {
                    navBarSeparatorView.alpha = 0.0
                }
            } else {
                navBarSeparatorView.alpha = 0.0
            }
        }
    }
    
    private func setupNavBarSeparator() {
        let topPosition = 44.0 + UIApplication.shared.statusBarFrame.size.height
        
        let navBarSeparatorView = UIView(frame: CGRect(x: 0, y: topPosition, width: UIScreen.main.bounds.width, height: 1.0))
        navBarSeparatorView.alpha = 0.0
        navBarSeparatorView.backgroundColor = .lightGray
        navBarSeparatorView.layer.zPosition = 5000
        navBarSeparatorView.tag = 5000
        view.addSubview(navBarSeparatorView)
    }
    
    // MARK: -
    // MARK: - Localization
    // MARK: -
    
    func addLanguageButtons(lightAppearance: Bool = true) {
        isLightAppearance = lightAppearance
        
        var buttons: [UIBarButtonItem] = []
        
        let lang = TCLLocalizedStrings.currentLanguage
        
        func addBtn(lang: TCLLocalizedStrings.AppLanguage) {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 28))
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 48, height: 28))
            btn.layer.cornerRadius = 5.0
            btn.setTitle(lang.name, for: .normal)
            btn.titleLabel?.font = TCLFonts.timesNewRomanBold.ofSize(14.0)
            let selector = lang == .ru ? #selector(selectRuLanguage) : #selector(selectEnLanguage)
            btn.addTarget(self, action: selector, for: .touchUpInside)
            if lang == .ru { ruBtn = btn } else { enBtn = btn }

            view.addSubview(btn)
            buttons.append(UIBarButtonItem(customView: view))
        }
        
        addBtn(lang: .en)
        addBtn(lang: .ru)
        
        lang == .ru ? ruLanguageSelected() : enLanguageSelected()
        
        navigationItem.rightBarButtonItems = buttons
    }
    
    @objc private func selectRuLanguage() {
        TCLLocalizedStrings.setLanguage(to: .ru)
    }
    
    @objc private func selectEnLanguage() {
        TCLLocalizedStrings.setLanguage(to: .en)
    }
    
    func ruLanguageSelected() {
        enBtn?.backgroundColor = .clear
        enBtn?.setTitleColor((isLightAppearance ? UIColor.lightBlack : .rouge), for: .normal)
        ruBtn?.backgroundColor = isLightAppearance ? .clear : .rouge
        ruBtn?.setTitleColor((isLightAppearance ? .rouge : .white), for: .normal)
    }
    
    func enLanguageSelected() {
        ruBtn?.backgroundColor = .clear
        ruBtn?.setTitleColor((isLightAppearance ? .lightBlack : .rouge), for: .normal)
        enBtn?.backgroundColor = isLightAppearance ? .clear : .rouge
        enBtn?.setTitleColor((isLightAppearance ? .rouge : .lightBlack), for: .normal)
    }
    
    
    private func subscribeForLanguageChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: Notification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    @objc private func languageChanged() {
        let currentLanguage = TCLLocalizedStrings.currentLanguage
        currentLanguage == .ru ? ruLanguageSelected() : enLanguageSelected()
    }
}
