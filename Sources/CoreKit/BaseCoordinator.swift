//
//  BaseCoordinator.swift
//
//  Created by Miguel Solans on 21/05/2024.
//

/// Use this protocol to define methods a root delegate coordinator must comply to
protocol CoordinatorDelegate: AnyObject { }

/// Base class for a Coordinator
///
/// Each scene should have its very own coordinator. Coordinator's should be created by extending the Coordinator base class
///
/// For a each coordinator, it needs to override both `start()` and `finish()`
/// Base coordinators should have the following responsibilities:
///
///     - Instantiate ViewModel's and ViewController's
///     - Instantiate and inject dependencies into ViewController's and ViewModel's
///     - Present or push ViewController's to the screen
///
public class BaseCoordinator {

    /// An array that holds reference to child coordinators
    ///
    /// Access is read-only outside of the class, but modifiable through_
    ///  - `addChildCoordinator()`,
    ///  - `removeChildCoordinator()`,
    ///  - `removeAllChildCoordinatorsWith()` and
    ///  - `removeAllChildCoordinators`
    private(set) var childCoordinators: [BaseCoordinator] = []

    /// Override this method to define navigation and initial setup
    public func start() {
        preconditionFailure("This method needs to be overridden by concrete subclass.")
    }

    /// Override this method to clean-up a coordinator
    public func finish() {
        preconditionFailure("This method needs to be overridden by concrete subclass.")
    }

    /// Add a child coordinator to stack of coordinators
    /// - Parameter coordinator: child coordinator
    public func addChildCoordinator(_ coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    /// Remove a child coordinator from the stack of coordinators
    /// - Parameter coordinator: child coordinator to be removed
    public func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }
    
    /// Remove all coordinators of a given type from the stack of coordinators
    /// - Parameter type: coordinator type
    public func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }

    /// Remove all coordinators from the stack of coordinators
    public func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }

}

extension BaseCoordinator: Equatable {
    
    public static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs === rhs
    }
    
}
