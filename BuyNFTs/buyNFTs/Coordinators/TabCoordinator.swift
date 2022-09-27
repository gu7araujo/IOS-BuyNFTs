//
//  TabCoordinator.swift
//  buyNFTs
//
//  Created by Gustavo Araujo Santos on 26/09/22.
//

import UIKit

enum TabBarPage {
    case home
    case article

    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .article
        default:
            return nil
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .article:
            return 1
        }
    }

    func pageTitleValue() -> String {
        switch self {
        case .home:
            return "Home"
        case .article:
            return "Articles"
        }
    }

    func pageIcon() -> UITabBarItem.SystemItem {
        switch self {
        case .home:
            return .search
        case .article:
            return .bookmarks
        }
    }
}

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }

    func selectPage(_ page: TabBarPage)
    func setSelectedIndex(_ index: Int)
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, TabCoordinatorProtocol {

    // MARK: - Properties

    weak var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var type: CoordinatorType { .tab }

    // MARK: - Initialization

    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    deinit {
        print("TabCoordinator deinit")
    }

    // MARK: - Public methods

    func start() {
        let pages: [TabBarPage] = [.home, .article]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })

        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }

    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }

    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }

        tabBarController.selectedIndex = page.pageOrderNumber()
    }

    // MARK: - Private methods

    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.backgroundColor = .systemGray
        navigationController.viewControllers = [tabBarController]
    }

    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)

        navController.tabBarItem = UITabBarItem.init(tabBarSystemItem: page.pageIcon(), tag: page.pageOrderNumber())

        switch page {
        case .home:
            let homeCoordinator: HomeCoordinator = .init(navController)
            homeCoordinator.start()
        case .article:
            let articleCoordinator: ArticleCoordinator = .init(navController)
            articleCoordinator.start()
        }

        return navController
    }
}

// MARK: - UITabBarControllerDelegate
extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Some implementation
    }
}
