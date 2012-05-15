---
title: Faster Ruby Requires
subtitle: up and running more quickly
author: Jon Maken
published: false
---

Wouldn't it be great if Rails and other Ruby applications woke up faster and
could do real work sooner? Wouldn't it be great if no changes were needed to
your application code?

Yura Sokolov a.k.a [@funny_falcon](http://twitter.com/funny_falcon), a TCS core
committer, has been working to solve just that challenge by sorting `$LOADED_FEATURES`
and caching `$LOAD_PATH`. While Yura's work is available in a number of different
formats (`rvm` patch, git patch branches, `tcs-ruby_1_9_3` release branch) this
post shows how to build a custom Ruby 1.9.3 enhanced with optimizations from our
`sorted-lf/ruby_1_9_3` and `cached-lp/ruby_1_9_3` patch branches.

## Building a Quicker Ruby 1.9.3

_in progress_

## Performance Results

_in progress_

## Next Steps

As you can see, the performance enhancements are noticeable and improve real-world
Ruby applications. They even pass the current MRI test suite! While this post showed
how you can benefit from these optimizations using the current Ruby 1.9.3, the patches
have also been submitted for review by ruby-core:

  * [http://bugs.ruby-lang.org/issues/5427](http://bugs.ruby-lang.org/issues/5427)
  * [http://bugs.ruby-lang.org/issues/5767](http://bugs.ruby-lang.org/issues/5767)

If you're jazzed about this post, take the next step. Build an enhanced Ruby and
use it to run _your_ application through _your_ testing and performance gauntlet.
If you find bugs, [let us know](http://groups.google.com/group/thecodeshop). If
you like what you see, tweet about it. Blog about it. Be vocal and let others know.

If you feel strongly that Yura's multi-platform `require` performance improvements
makes MRI a better implementation, tell the busy, over-worked ruby-core committers
by commenting on the above feature requests. Don't just give a meaningless `"+1"`
throw away comment. Provide testing and performance results that clearly show
the benefits to both the MRI implementation and Ruby users.

## Acknowledgements

_in progress_
