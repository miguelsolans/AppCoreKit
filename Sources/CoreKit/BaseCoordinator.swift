//
//  BaseCoordinator.swift
//
//  Created by Miguel Solans on 21/05/2024.
//

import UIKit

/// Use this protocol to define methods a root delegate coordinator must comply to
public protocol CoordinatorDelegate: AnyObject { }

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
open class BaseCoordinator: NSObject {

    /// An array that holds reference to child coordinators
    ///
    /// Access is read-only outside of the class, but modifiable through_
    ///  - `addChildCoordinator()`,
    ///  - `removeChildCoordinator()`,
    ///  - `removeAllChildCoordinatorsWith()` and
    ///  - `removeAllChildCoordinators`
    private(set) var childCoordinators: [BaseCoordinator] = []
    
    /// The root view controller managed by this coordinator.
    ///
    /// This represents the primary view controller that defines the coordinator’s lifecycle
    /// within a navigation stack.
    ///
    /// It is typically:
    /// - Set in `start()` when the first screen of the flow is created
    /// - Pushed or presented by the coordinator
    ///
    /// This property is used to:
    /// - Detect when the coordinator’s flow has been removed from the navigation stack
    ///   (e.g., via back navigation or swipe-to-pop)
    /// - Determine when the coordinator should call `finish()`
    ///
    /// The reference should be weak to avoid retain cycles between the coordinator
    /// and its view controller.
    public var rootViewController: UIViewController?
    
    /// The parent coordinator in the hierarchy.
    ///
    /// This reference is set when a coordinator is added as a child of another coordinator.
    /// It is used to:
    /// - Notify the parent when this coordinator finishes
    /// - Allow the parent to remove this coordinator from its `childCoordinators`
    ///
    /// The reference is weak to avoid retain cycles.
    weak var parentCoordinator: BaseCoordinator?

    /// Override this method to define navigation and initial setup
    open func start() {
        preconditionFailure("This method needs to be overridden by concrete subclass.")
    }

    /// Override this method to clean-up a coordinator
    open func finish() {
        preconditionFailure("This method needs to be overridden by concrete subclass.")
    }
    
    public override init() {
        
    }

    /// Add a child coordinator to stack of coordinators
    /// - Parameter coordinator: child coordinator
    public func addChildCoordinator(_ coordinator: BaseCoordinator) {
        coordinator.parentCoordinator = self
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
