.. _c:

C语言使用文档
########################



.. toctree::
   :maxdepth: 2

   cs/c_normal
   cs/c_command


The heap is easier to explain as it's just all the remaining memory in your computer, and you access it with the function malloc to get more. Each time you call malloc, the OS uses internal functions to register that piece of memory to you, and then returns a pointer to it. When you're done with it, you use free to return it to the OS so that it can be used by other programs. Failing to do this will cause your program to "leak" memory, but Valgrind will help you track these leaks down.

The stack is a special region of memory that stores temporary variables each function creates as locals to that function. How it works is each argument to a function is "pushed" onto the stack, and then used inside the function. It is really a stack data structure, so the last thing in is the first thing out. This also happens with all local variables like char action and int id in main. The advantage of using a stack for this is simply that, when the function exits, the C compiler "pops" these variables off the stack to clean up. This is simple and prevents memory leaks if the variable is on the stack.

The easiest way to keep this straight is with this mantra: If you didn't get it from malloc or a function that got it from malloc, then it's on the stack.


There's three primary problems with stacks and heaps to watch for:

If you get a block of memory from malloc, and have that pointer on the stack, then when the function exits, the pointer will get popped off and lost.
If you put too much data on the stack (like large structs and arrays) then you can cause a "stack overflow" and the program will abort. In this case, use the heap with malloc.
If you take a pointer to something on the stack, and then pass that or return it from your function, then the function receiving it will "segmentation fault" (segfault) because the actual data will get popped off and disappear. You'll be pointing at dead space.


`from:  <http://c.learncodethehardway.org/book/ex17.html>`_


