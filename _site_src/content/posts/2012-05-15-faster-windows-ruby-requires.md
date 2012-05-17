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

## A Bit of History

**TODO** briefly summarize the following to properly set the stage for this
long standing issue.

1. [The Great Ruby Shootout](http://programmingzen.com/2010/07/19/the-great-ruby-shootout-july-2010/)
2. [Performance bug with require implementation](http://bugs.ruby-lang.org/issues/3924)
3. [Fenix rises](http://blog.mmediasys.com/2011/11/26/rubyconf-argentina-and-fenix/)

## Why is Ruby 1.9.3 startup time so slow on Windows?

Based upon our profiling and testing results, the use of the `FindFirstFile()`
API in `File.expand_path` is the root cause of Ruby on Windows startup slowness.

For every call Ruby application code call to `require`, the current MRI implementation
makes _many_ calls to `expand_path` as part of checking the `$LOAD_PATH` array. As
such, performance of `expand_path` dramatically impacts startup time. For Windows,
the current `expand_path` implementation is one of the primary bottlenecks causing
sluggish startup times.

While the `FindFirstFile()` API is quite powerful, it turns out that `FindFirstFile()`
can be very slow because of the number of file system operations it performs.
Consequently, `expand_path`'s current use `FindFirstFileW()` to expand short path
names into long path names is slower than it needs to be. It's worth noting that
the Ruby on Linux implementation doesn't need such an expensive operation.

We found that removing the `FindFirstFile()` call gives a big performance improvement.

<pre><code class='language-diff'>
<% h do %>
diff --git a/file.c b/file.c
index 11e9766..39aacc2 100644
--- a/file.c
+++ b/file.c
@@ -3196,7 +3196,8 @@ file_expand_path(VALUE fname, VALUE dname, int abs_mode, VALUE result)
    wstr = ALLOCV_N(WCHAR, v, len);
    MultiByteToWideChar(CP_UTF8, 0, RSTRING_PTR(tmp), -1, wstr, len);
    if (tmp != result) rb_str_resize(tmp, 0);
-   h = FindFirstFileW(wstr, &wfd);
+//	h = FindFirstFileW(wstr, &wfd);
+   h = INVALID_HANDLE_VALUE;
    ALLOCV_END(v);
    if (h != INVALID_HANDLE_VALUE) {
        size_t wlen;

/* vim: set sw=4 sts=4 et */
<% end %>
</code></pre>


### Rails 3.2.1 empty app startup

#### Plain ruby 2.0.0dev (2012-02-18 trunk 34670) [i386-mingw32]
<pre class="shell">
X:\empty>timer ruby script\rails r 'p $:.size, $".size'
59
744
real    6.708
system  4.227
user    2.433
</pre>


#### Patched ruby 2.0.0dev (2012-02-18 trunk 34670) [i386-mingw32]
<pre class="shell">
<% h do %>
X:\empty>timer ruby script\rails r 'p $:.size, $".size'
59
744
real    2.418
system  0.920
user    1.513
<% end %>
</pre>

It reduces 6.7s to 2.4s!

Instead of performance gain, short path is left as it is. Windows users can do
short path name expansion by `GetLongPathName` API using `dl` library if it's needed.

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
