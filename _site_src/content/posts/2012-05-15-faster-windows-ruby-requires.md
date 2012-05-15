---
title: Faster Ruby on Windows
subtitle: much faster than you remember
author: Luis Lavena, Hiroshi Shirosaki, Jon Maken
published: 2012-05-15 14:38:32 -04:00
---

Wouldn't it be great if Rails and other Ruby applications woke up and started
doing real work twice as fast as before? And you didn't have to change a single
line of your precious tested code.

A dream, you say?

Until now, yes, it was just a cruel mirage beckoning to the hearty band of
discouraged Ruby on Windows developers. Atlantis. Talked about in dark and
dusty corners of the blogosphere, but never seen.

But Nessie has surfaced, and it's time to see what all the fuss is about.

## Sample Code

<pre><code class='language-c'>
<% h do %>
/*
 * build with:
 *   gcc -Wall -Wstack-protector -fstack-protector -o buggy buggy.c
 *
 * see results with:
 *   tail -2 /var/log/messages
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[])
{
    char buffer[10];

    /* BAD - unbound string copy into the small stack buffer */
    strcpy(buffer, argv[1]);

    printf("\tcopied cmd line argument...\n");

    return 0;
}

/* vim: set sw=4 sts=4 et */
<% end %>
</code></pre>

## Building a Quicker Ruby 1.9.3

_in progress_

## Performance Results

_in progress_

## Next Steps

As you can see, the performance enhancements are noticeable and improve real-world
Ruby applications. They even pass the current MRI test suite! While this post showed
how you can benefit from these optimizations using the current Ruby 1.9.3, the patches
have also been submitted for review by ruby-core:

  * _TBD_
  * _TBD_

If you're jazzed about this post, take the next step. Build an enhanced Ruby and
use it to run _your_ application through _your_ testing and performance gauntlet.
If you find bugs, [let us know](http://groups.google.com/group/thecodeshop). If
you like what you see, tweet about it. Blog about it. Be vocal and let others know.

## Acknowledgements

_in progress_
