//
//  LayoutProxy.swift
//  Cartography
//
//  Created by Robert Böhnke on 17/06/14.
//  Copyright (c) 2014 Robert Böhnke. All rights reserved.
//

import Foundation
#if os(iOS) || os(tvOS)
    import UIKit
#else
    import AppKit
#endif

public struct LayoutProxy {
    /// The width of the view.
    public var width: Dimension {
        return Dimension(context, view, .Width)
    }

    /// The height of the view.
    public var height: Dimension {
        return Dimension(context, view, .Height)
    }

    /// The size of the view. This property affects both `width` and `height`.
    public var size: Size {
        return Size(context, [
            Dimension(context, view, .Width),
            Dimension(context, view, .Height)
        ])
    }
    
    func edge(attribute: NSLayoutAttribute) -> Edge {
        return Edge(context, view, attribute)
    }

    /// The top edge of the view.
    public var top: Edge {
        return edge(.Top)
    }

    /// The right edge of the view.
    public var right: Edge {
        return edge(.Right)
    }

    /// The bottom edge of the view.
    public var bottom: Edge {
        return edge(.Bottom)
    }

    /// The left edge of the view.
    public var left: Edge {
        return edge(.Left)
    }

    /// All edges of the view. This property affects `top`, `bottom`, `leading`
    /// and `trailing`.
    public var edges: Edges {
        return Edges(context, [
            edge(.Top),
            edge(.Leading),
            edge(.Bottom),
            edge(.Trailing)
        ])
    }
    
    /// Edges of the view which affects specified laytout attributes.
    public func edges(attributes: NSLayoutAttribute...) -> Edges {
        let edges: [Property] = attributes.map(edge)
        assert(!edges.isEmpty)
        return Edges(context, edges)
    }

    /// The leading edge of the view.
    public var leading: Edge {
        return edge(.Leading)
    }

    /// The trailing edge of the view.
    public var trailing: Edge {
        return edge(.Trailing)
    }

    /// The horizontal center of the view.
    public var centerX: Edge {
        return edge(.CenterX)
    }

    /// The vertical center of the view.
    public var centerY: Edge {
        return edge(.CenterY)
    }

    /// The center point of the view. This property affects `centerX` and
    /// `centerY`.
    public var center: Point {
        return Point(context, [
            edge(.CenterX),
            edge(.CenterY)
        ])
    }

    /// The baseline of the view.
    @available(OSX, deprecated=10.11, renamed="lastBaseline")
    @available(iOS, deprecated=8.0, renamed="lastBaseline")
    public var baseline: Edge {
        return edge(.LastBaseline)
    }

    /// The first baseline of the view.
    @available(OSX, introduced=10.11)
    public var firstBaseline: Edge {
        return edge(.FirstBaseline)
    }

    /// The last baseline of the view.
    @available(OSX, introduced=10.11)
    public var lastBaseline: Edge {
        return edge(.LastBaseline)
    }
    
    #if os(iOS) || os(tvOS)
    /// All edges of the view with their respective margins. This property
    /// affects `topMargin`, `bottomMargin`, `leadingMargin` and
    /// `trailingMargin`.
    public var edgesWithinMargins: Edges {
        return Edges(context, [
            edge(.TopMargin),
            edge(.LeadingMargin),
            edge(.BottomMargin),
            edge(.TrailingMargin)
        ])
    }

    /// The left margin of the view. iOS & tvOS exclusive.
    public var leftMargin: Edge {
        return edge(.LeftMargin)
    }

    /// The right margin of the view. iOS & tvOS exclusive.
    public var rightMargin: Edge {
        return edge(.RightMargin)
    }

    /// The top margin of the view. iOS & tvOS exclusive.
    public var topMargin: Edge {
        return edge(.TopMargin)
    }

    /// The bottom margin of the view. iOS & tvOS exclusive.
    public var bottomMargin: Edge {
        return edge(.BottomMargin)
    }

    /// The leading margin of the view. iOS & tvOS exclusive.
    public var leadingMargin: Edge {
        return edge(.LeadingMargin)
    }

    /// The trailing margin of the view. iOS & tvOS exclusive.
    public var trailingMargin: Edge {
        return edge(.TrailingMargin)
    }

    /// The horizontal center within the margins of the view. iOS & tvOS exclusive.
    public var centerXWithinMargins: Edge {
        return edge(.CenterXWithinMargins)
    }

    /// The vertical center within the margins of the view. iOS & tvOS exclusive.
    public var centerYWithinMargins: Edge {
        return edge(.CenterYWithinMargins)
    }

    /// The center point within the margins of the view. This property affects
    /// `centerXWithinMargins` and `centerYWithinMargins`. iOS & tvOS exclusive.
    public var centerWithinMargins: Point {
        return Point(context, [
            edge(.CenterXWithinMargins),
            edge(.CenterYWithinMargins)
        ])
    }
    #endif

    internal let context: Context

    internal let view: View

    /// The superview of the view, if it exists.
    public var superview: LayoutProxy? {
        if let superview = view.superview {
            return LayoutProxy(context, superview)
        } else {
            return nil
        }
    }

    init(_ context: Context, _ view: View) {
        self.context = context
        self.view = view
    }
}
