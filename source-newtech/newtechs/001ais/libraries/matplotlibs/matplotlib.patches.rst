matplotlib.patches
##################

* api文档: https://matplotlib.org/stable/api/patches_api.html

Classes::

    Arc(xy, width, height[, angle, theta1, theta2]) 
        An elliptical arc, i.e.
    Arrow(x, y, dx, dy[, width])  
        An arrow patch.
    ArrowStyle(stylename, **kw) 
        ArrowStyle is a container class which defines several arrowstyle classes, 
        which is used to create an arrow path along a given path.
    BoxStyle(stylename, **kw) 
        BoxStyle is a container class which defines several boxstyle classes, 
        which are used for FancyBboxPatch.
    Circle(xy[, radius])  
        A circle patch.
    CirclePolygon(xy[, radius, resolution]) 
        A polygon-approximation of a circle patch.
    ConnectionPatch(xyA, xyB, coordsA[, ...]) 
        A patch that connects two points (possibly in different axes).
    ConnectionStyle(stylename, **kw) 
        ConnectionStyle is a container class which defines several connectionstyle classes, 
        which is used to create a path between two points.
    Ellipse(xy, width, height[, angle]) 
        A scale-free ellipse.
    FancyArrow(x, y, dx, dy[, width, ...])  
        Like Arrow, but lets you set head width and head height independently.
    FancyArrowPatch([posA, posB, path, ...])  
        A fancy arrow patch.
    FancyBboxPatch(xy, width, height[, ...])  
        A fancy box around a rectangle with lower left at xy = (x, y) with specified width and height.
    Patch([edgecolor, facecolor, color, ...]) 
        A patch is a 2D artist with a face color and an edge color.
    PathPatch(path, **kwargs) 
        A general polycurve path patch.
    Polygon(xy[, closed]) 
        A general polygon patch.
    Rectangle(xy, width, height[, angle]) 
        A rectangle defined via an anchor point xy and its width and height.
    RegularPolygon(xy, numVertices[, radius, ...])  
        A regular polygon patch.
    Shadow(patch, ox, oy[, props])  
        Create a shadow of the given patch.
    Wedge(center, r, theta1, theta2[, width]) 
        Wedge shaped patch.

Functions::

    bbox_artist(artist, renderer[, props, fill])  
        A debug function to draw a rectangle around the bounding box 
        returned by an artist's Artist.get_window_extent to test whether 
        the artist is returning the correct bbox.
    draw_bbox(bbox, renderer[, color, trans]) 
        A debug function to draw a rectangle around the bounding box 
        returned by an artist's Artist.get_window_extent to test 
        whether the artist is returning the correct bbox.










