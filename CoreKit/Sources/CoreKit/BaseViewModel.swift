//
//  BaseViewModel.swift
//  
//
//  Created by Miguel Solans on 21/05/2024.
//

import Foundation

/// Use this protocol to define methods a coordinator delegate must comply to
protocol ViewModelCoordinatorDelegate: AnyObject { }

/// Use this protocol to define methods a view delegate must comply to
protocol ViewModelDelegate: AnyObject { }

/// Base class for a ViewModel
class BaseViewModel<CoordinatorDelegateType: ViewModelCoordinatorDelegate, ViewDelegateType: ViewModelDelegate> {
    
    /// Set delegate with coordinator class
    weak var coordinatorDelegate: CoordinatorDelegateType?
    
    /// Set delegate with view class
    weak var viewDelegate: ViewDelegateType?
    
    /// Initializer for a ViewModel base class
    /// - Parameters:
    ///   - coordinatorDelegate: coordinator delegate class
    ///   - viewDelegate: view delegate class
    init(coordinatorDelegate: CoordinatorDelegateType?, viewDelegate: ViewDelegateType?) {
        self.coordinatorDelegate = coordinatorDelegate
        self.viewDelegate = viewDelegate
    }
    
}
