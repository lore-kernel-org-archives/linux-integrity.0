Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:52167 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753564AbdJHWZZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Oct 2017 18:25:25 -0400
Date: Mon, 9 Oct 2017 09:24:53 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] vfs: fix mounting a filesystem with i_version
In-Reply-To: <1507436901.5841.4.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1710090924410.3670@namei.org>
References: <1507436901.5841.4.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

cc: Al Viro.


On Sun, 8 Oct 2017, Mimi Zohar wrote:

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
>  
>  	if (flags & MS_REMOUNT)
>  		retval = do_remount(&path, flags, sb_flags, mnt_flags,
> 

-- 
James Morris
<jmorris@namei.org>
