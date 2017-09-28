Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:54358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753116AbdI1NyS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Sep 2017 09:54:18 -0400
Date: Thu, 28 Sep 2017 06:54:16 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC PATCH 1/3] fs: define new read_iter rwf flag
Message-ID: <20170928135416.GA30859@bombadil.infradead.org>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1506602373-4799-2-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506602373-4799-2-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Sep 28, 2017 at 08:39:31AM -0400, Mimi Zohar wrote:
> Writing extended attributes requires exclusively taking the i_rwsem
> lock.  To synchronize the file hash calculation and writing the file
> hash as security.ima xattr, IMA-appraisal takes the i_rwsem lock
> exclusively before calculating the file hash.  (Once the file hash
> is calculated, the result is cached.  Taking the lock exclusively
> prevents calculating the file hash multiple times.)
> 
> Some filesystems have recently replaced their filesystem dependent
> lock with the global i_rwsem to read a file.  As a result, when IMA
> attempts to calculate the file hash, reading the file attempts to
> take the i_rwsem again.
> 
> To resolve this problem, this patch defines a new read_iter flag
> named "rwf" to indicate that the i_rwsem has already been taken
> exclusively.  Subsequent patches will set or test the "rwf" flag.

I don't like adding a bool parameter everywhere.  Why not add a flag
to the kiocb ki_flags?

#define IOCB_RWSEM_HELD		(1 << 8)
