Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from ipmailnode02.adl6.internode.on.net ([150.101.137.148]:52677
        "EHLO ipmailnode02.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750891AbdI1WHY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 18:07:24 -0400
Date: Fri, 29 Sep 2017 08:02:15 +1000
From: Dave Chinner <david@fromorbit.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
 taken exclusively
Message-ID: <20170928220215.GC15067@dastard>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Sep 28, 2017 at 08:39:33AM -0400, Mimi Zohar wrote:
> Don't attempt to take the i_rwsem, if it has already been taken
> exclusively.
> 
> Signed-off-by:  Mimi Zohar <zohar@linux.vnet.ibm.com>

That's bloody awful.

The locking in filesystem IO paths is already complex enough without
adding a new IO path semantic that says "caller has already locked
the i_rwsem in some order and some dependencies that we have no idea
about". Instead of having well defined locking in a small amount of
self contained code, we've now got to search through completely
unfamiliar code to analyse any sort of filesystem lockdep report or
deadlock to determine if that somethign else has screwed up the
filesystem IO path locking.

It also seems to have an undocumented semantic of not updating
access times on the inode, which effectively makes this invisible IO
and means we're assuming that timestamp updates will be done by
correctly callers outside the filesystem IO path. That's almost
certainly going to be a source of bugs in the future.

This seems like a recipe for future disasters to me....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
