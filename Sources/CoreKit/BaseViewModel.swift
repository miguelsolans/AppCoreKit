//
//  BaseViewModel.swift
//  
//
//  Created by Miguel Solans on 21/05/2024.
//

import Foundation

/// Use this protocol to define methods a coordinator delegate must comply to
public protocol ViewModelCoordinatorDelegate: AnyObject { }

/// Use this protocol to define methods a view delegate must comply to
public protocol ViewModelDelegate: AnyObject { }

/// Base class for a ViewModel
public class BaseViewModel<CoordinatorDelegateType: ViewModelCoordinatorDelegate, ViewDelegateType: ViewModelDelegate> {
    
    /// Set delegate with coordinator class
    public weak var coordinatorDelegate: CoordinatorDelegateType?
    
    /// Set delegate with view class
    public weak var viewDelegate: ViewDelegateType?
    
    /// Initializer for a ViewModel base class
    /// - Parameters:
    ///   - coordinatorDelegate: coordinator delegate class
    ///   - viewDelegate: view delegate class
    public init(coordinatorDelegate: CoordinatorDelegateType?, viewDelegate: ViewDelegateType?) {
        self.coordinatorDelegate = coordinatorDelegate
        self.viewDelegate = viewDelegate
    }
    
}
