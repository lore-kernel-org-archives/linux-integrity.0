Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:51532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933469AbeAOQ10 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jan 2018 11:27:26 -0500
Date: Mon, 15 Jan 2018 08:27:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dongsu Park <dongsu@kinvolk.io>,
        Alban Crequy <alban@kinvolk.io>,
        Christoph Hellwig <hch@infradead.org>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH] ima: define new policy condition based on the filesystem
 name
Message-ID: <20180115162726.GB15686@infradead.org>
References: <1516033236.6607.6.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516033236.6607.6.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Jan 15, 2018 at 11:20:36AM -0500, Mimi Zohar wrote:
> Some filesystems do not export the filesystem's magic number, as it is
> considered internal, private data.  In other cases, the policy rule
> needs to identify a specifically mounted filesystem (eg. rootfs).

No, it doesn't.  Policies based on a file system type are complete and
utterly bogus.   rootfs should not be treated any different from other
file systems.
