//
//  Align.swift
//  Cartography
//
//  Created by Robert Böhnke on 17/02/15.
//  Copyright (c) 2015 Robert Böhnke. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

private func makeAlign(attribute: NSLayoutAttribute, first: LayoutProxy, rest: [LayoutProxy]) -> [NSLayoutConstraint] {
    return rest.reduce([]) { acc, current in
        current.view.car_translatesAutoresizingMaskIntoConstraints = false
        
        var result = acc
        result.append(first.edge(attribute) == current.edge(attribute))
        return result
    }
}

private func makeAlign(context: Context, attribute: NSLayoutAttribute, first: View, rest: [View]) {
    let first = LayoutProxy(context, first)
    let rest = rest.map{ LayoutProxy(context, $0) }
    
    makeAlign(attribute, first: first, rest: rest)
}

/// Aligns multiple views by the specified attribute.
///
/// All views passed to this function will have
/// their `translatesAutoresizingMaskIntoConstraints` properties set to `false`.
///
/// - returns: An array of `NSLayoutConstraint` instances.
///
public func align(attribute: NSLayoutAttribute, _ first: LayoutProxy, _ rest: LayoutProxy...) -> [NSLayoutConstraint] {
    return makeAlign(attribute, first: first, rest: rest)
}

/// Aligns multiple views by the specified attributes.
///
/// All views passed to this function will have
/// their `translatesAutoresizingMaskIntoConstraints` properties set to `false`.
///
/// - returns: An array of `NSLayoutConstraint` instances.
///
public func align(attributes: [NSLayoutAttribute], _ first: LayoutProxy, _ rest: LayoutProxy...) -> [NSLayoutConstraint] {
    return attributes.reduce([]) { acc, attribute in
        return acc + makeAlign(attribute, first: first, rest: rest)
    }
}

/// Aligns multiple views by the specified attribute.
///
/// All views passed to this function will have
/// their `translatesAutoresizingMaskIntoConstraints` properties set to `false`.
///
/// - returns: An array of `NSLayoutConstraint` instances.
///
public func align(attribute: NSLayoutAttribute, _ first: View, _ rest: View...) -> ConstraintGroup {
    let context = Context()
    makeAlign(context, attribute: attribute, first: first, rest: rest)
    return ConstraintGroup(context.constraints)
}

/// Aligns multiple views by the specified attributes.
///
/// All views passed to this function will have
/// their `translatesAutoresizingMaskIntoConstraints` properties set to `false`.
///
/// - returns: An array of `NSLayoutConstraint` instances.
///
public func align(attributes: [NSLayoutAttribute], _ first: View, _ rest: View...) -> ConstraintGroup {
    let context = Context()
    attributes.forEach{ makeAlign(context, attribute: $0, first: first, rest: rest) }
    return ConstraintGroup(context.constraints)
}