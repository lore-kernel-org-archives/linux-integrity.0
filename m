Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34921 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdJHI6n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Oct 2017 04:58:43 -0400
Date: Sun, 8 Oct 2017 01:58:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] vfs: fix mounting a filesystem with i_version
Message-ID: <20171008085840.GA6825@infradead.org>
References: <1507436901.5841.4.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507436901.5841.4.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Oct 08, 2017 at 12:28:21AM -0400, Mimi Zohar wrote:
> The mount i_version flag is not enabled in the new sb_flags.  This patch
> adds the missing SB_I_VERSION flag.
> 
> Fixes: e462ec5 "VFS: Differentiate mount flags (MS_*) from internal
>        superblock flags"
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  fs/namespace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 3b601f115b6c..d18deb4c410b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2825,7 +2825,8 @@ long do_mount(const char *dev_name, const char __user *dir_name,
>  			    SB_MANDLOCK |
>  			    SB_DIRSYNC |
>  			    SB_SILENT |
> -			    SB_POSIXACL);
> +			    SB_POSIXACL |
> +			    SB_I_VERSION);

The problem is that the whole masking there is a piece of crap.

It assumes that MS_* and SB_* flags have the same numeric values,
which is bound to create a major problem rather sooner than later.

What we need is a separate __bitwise type for SB_*, translated them
here and treat them as a separate namespaces.
