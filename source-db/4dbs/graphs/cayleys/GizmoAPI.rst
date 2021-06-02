GizmoAPI
########

数据源
======

.. literalinclude:: ./demo.nq

Graph object
================

唯一入口对象::

    Name: graph, Alias: g

graph.Emit(*)::

    $ g.Emit({name:"bob"}) // push {"name":"bob"} as a result
    
    $ var n = g.V().Count();
    $ g.Emit(n);

graph.M(), graph.Morphism()
---------------------------

Morphism creates a morphism path object. Unqueryable on it's own, defines one end of the path. Saving these to variables with

::

    var shorterPath = graph.Morphism().Out("foo").Out("bar")

graph.V(*), graph.Vertex
------------------------

格式::

    graph.V(*), graph.Vertex([nodeId],[nodeId]...)

graph.IRI(s)
------------
Uri creates an IRI values from a given string.



Path object
===========
::

    path.All()
    path.And(path), 
    
    path.Both([predicatePath], [tags])
    path.Difference(path), path.Except(path)



path.As(tags), path.Tag(tags)
-----------------------------
saves a list of nodes to a given tag.
tag::

    A string or list of strings to act as a result key. 
    The value for tag was the vertex the path was on at the time it reached "Tag" 

Example::

    // Start from all nodes, save them into start, follow any status links, and return the result.
    $> g.V().Tag("start").Out("<status>").All()
    {"id": "cool_person", "start": "<bob>"},
    {"id": "cool_person", "start": "<dani>"},
    {"id": "cool_person", "start": "<greg>"},
    {"id": "smart_person", "start": "<emily>"},
    {"id": "smart_person", "start": "<greg>"}


path.Out([predicatePath], [tags])
---------------------------------

predicatePath (Optional): One of::

    null or undefined: All predicates pointing out from this node
    a string: The predicate name to follow out from this node
    a list of strings: The predicates to follow out from this node
    a query path object: The target of which is a set of predicates to follow.

tags (Optional): One of::

    null or undefined: No tags
    a string: A single tag to add the predicate used to the output set.
    a list of strings: Multiple tags to use as keys to save the predicate used to the output set.

path.in([predicatePath], [tags])
--------------------------------

In is inverse of Out. Starting with the nodes in path on the object, follow the quads with predicates defined by predicatePath to their subjects.

predicatePath (Optional): One of::

    null or undefined: All predicates pointing into this node
    a string: The predicate name to follow into this node
    a list of strings: The predicates to follow into this node
    a query path object: The target of which is a set of predicates to follow.

tags (Optional): One of::

    null or undefined: No tags
    a string: A single tag to add the predicate used to the output set.
    a list of strings: Multiple tags to use as keys to save the predicate used to the output set.

Example::

    // Find the cool people, bob, dani and greg
    $> g.V("cool_person").in("<status>").all();
    {"id": "<bob>"},
    {"id": "<dani>"},
    {"id": "<greg>"}

    // Find who follows bob, in this case, alice, charlie, and dani
    $> g.V("<bob>").in("<follows>").all();
    {"id": "<alice>"},
    {"id": "<charlie>"},
    {"id": "<dani>"}

    // Find who follows the people emily follows, namely, bob and emily
    $> g.V("<emily>").out("<follows>").in("<follows>").all();
    {"id": "<bob>"},
    {"id": "<emily>"}

path.Count()
------------
Count returns a number of results and returns it as a value.

实例::

    // Save count as a variable
    var n = g.V().count();
    // Send it as a query result
    g.emit(n);



path.back([tag])
----------------
Back returns current path to a set of nodes on a given tag, preserving all constraints.

If still valid, a path will now consider their vertex to be the same one as the previously tagged one, with the added constraint that it was valid all the way here. Useful for traversing back in queries and taking another route for things that have matched so far.


g.V().Tag("start").out("<status>").back("start").in("<follows>").all()::

    Start from all nodes, save them into start, follow any status links,
    jump back to the starting node, and find who follows them. Return the result.
    Results are:
      {"id": "<alice>", "start": "<bob>"},
      {"id": "<charlie>", "start": "<bob>"},
      {"id": "<charlie>", "start": "<dani>"},
      {"id": "<dani>", "start": "<bob>"},
      {"id": "<dani>", "start": "<greg>"},
      {"id": "<dani>", "start": "<greg>"},
      {"id": "<fred>", "start": "<greg>"},
      {"id": "<fred>", "start": "<greg>"}

path.save(predicate, tag)
-------------------------
Save saves the object of all quads with predicate into tag, without traversal.

Arguments::

    predicate: A string for a predicate node.
    tag: A string for a tag key to store the object node.

Example::

    // Start from dani and bob and save who they follow into "target"
    g.V("<dani>", "<bob>").save("<follows>", "target").all();
    // Returns:
       {"id" : "<bob>", "target": "<fred>" },
       {"id" : "<dani>", "target": "<bob>" },
       {"id" : "<dani>", "target": "<greg>" }

path.tagArray(*)
----------------

TagArray is the same as ToArray, but instead of a list of top-level nodes, returns an Array of tag-to-string dictionaries, much as All would, except inside the JS environment.

实例::

    // bobTags contains an Array of followers of bob (alice, charlie, dani).
    var bobTags = g.V("<bob>").tag("name").in("<follows>").tagArray();
    // nameValue should be the string "<bob>"
    var nameValue = bobTags[0]["name"];


path.toArray(*)
---------------

ToArray executes a query and returns the results at the end of the query path as an JS array.

实例::

    // bobFollowers contains an Array of followers of bob (alice, charlie, dani).
    var bobFollowers = g.V("<bob>").in("<follows>").toArray();
    g.Emit(bobFollowers);

path.inPredicates()
-------------------

InPredicates gets the list of predicates that are pointing in to a node.

::

    // bob only has "<follows>" predicates pointing inward
    // returns "<follows>"
    g.V("<bob>").inPredicates().all();


path.outPredicates()
--------------------

* OutPredicates得到结点指向的谓语列表
* OutPredicates gets the list of predicates that are pointing out from a node.

实例::

    // bob has "<follows>" and "<status>" edges pointing outwards
    // returns "<follows>", "<status>"
    $ g.V("<bob>").outPredicates().all();
    {
      "result": [
        {"id": "<follows>"},
        {"id": "<status>"}
      ]
    }

path.intersect(path)
--------------------

Intersect filters all paths by the result of another query path.
This is essentially a join where, at the stage of each path, a node is shared. Example:

实例::

    var cFollows = g.V("<charlie>").out("<follows>");
    var dFollows = g.V("<dani>").out("<follows>");
    // People followed by both charlie (bob and dani) and dani (bob and greg) -- returns bob.
    cFollows.intersect(dFollows).all();
    // Equivalently, g.V("<charlie>").out("<follows>").And(g.V("<dani>").out("<follows>")).all()



Example
=======

g.V().All()::

    {
      "result": [
        {"id": "cool_person"},
        {"id": "<dani>"},
        {"id": "<smart_graph>"},
        {"id": "<charlie>"},
        {"id": "<bob>"},
        {"id": "<fred>"},
        {"id": "<greg>"},
        {"id": "<emily>"},
        {"id": "<predicates>"},
        {"id": "smart_person"},
        {"id": "<alice>"},
        {"id": "<follows>"},
        {"id": "<status>"},
        {"id": "<are>"}
      ]
    }

g.V("<bob>").All()::

    {
      "result": [
        {"id": "<bob>"}
      ]
    }

g.V("<bob>", "<dani>").All()::

    {
      "result": [
        {"id": "<bob>"},
        {"id": "<dani>"}
      ]
    }

g.V("<bob>", "<dani>").Tag("start").All()::

    {
      "result": [
        {"id": "<bob>","start": "<bob>"},
        {"id": "<dani>","start": "<dani>"}
      ]
    }


$> g.V("<charlie>").Out("<follows>").All()::

    // The working set of this is bob and dani
    {
      "result": [
        {"id": "<bob>"},
        {"id": "<dani>"}
      ]
    }

$> g.V("<alice>").Out("<follows>").Out("<follows>").All()::

    // The working set of this is fred, as alice follows bob and bob follows fred.
    {
      "result": [
        {
          "id": "<fred>"
        }
      ]
    }

$> g.V("<dani>").Out().All()::

    // Finds all things dani points at. Result is bob, greg and cool_person
    {
      "result": [
        {"id": "cool_person"},
        {"id": "<bob>"},
        {"id": "<greg>"}
      ]
    }

$> g.V("<dani>").Out(["<follows>", "<status>"]).All()::

    // Finds all things dani points at on the status linkage.
    // Result is bob, greg and cool_person
    结果与上面g.V("<dani>").Out().All()相同

$> g.V("<dani>").Out(g.V("<status>"), "pred").All()::

    // Finds all things dani points at on the status linkage, given from a separate query path.
    {
      "result": [
        {
          "id": "cool_person",
          "pred": "<status>"
        }
      ]
    }










