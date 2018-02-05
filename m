Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36502 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeBEOY5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Feb 2018 09:24:57 -0500
Received: by mail-pg0-f68.google.com with SMTP id x25so6038667pge.3
        for <linux-integrity@vger.kernel.org>; Mon, 05 Feb 2018 06:24:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517838054.3736.49.camel@linux.vnet.ibm.com>
References: <1517838054.3736.49.camel@linux.vnet.ibm.com>
From: Alban Crequy <alban@kinvolk.io>
Date: Mon, 5 Feb 2018 15:24:56 +0100
Message-ID: <CADZs7q7oyC3LPmCFDTK9a7rdpXAAS=kT5HSURcN3t3oirvBpmg@mail.gmail.com>
Subject: Re: [RFC PATCH] ima: force the re-evaluation of files on untrusted
 file systems
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
        Dongsu Park <dongsu@kinvolk.io>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Feb 5, 2018 at 2:40 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On filesystems, such as fuse or remote filesystems, that we can not
> detect or rely on the filesystem to tell us when a file has changed,
> always re-measure, re-appraise, and/or re-audit the file.
>
> Signed-of-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
>
> ---
> Hi Miklos,
>
> Was something like this what you had in mind?
>
> Mimi
> ---
>  security/integrity/ima/ima_main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 6d78cb26784d..a428bd75232e 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -170,6 +170,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>                                int mask, enum ima_hooks func, int opened)
>  {
>         struct inode *inode = file_inode(file);
> +       struct dentry *dentry = file_dentry(file);
>         struct integrity_iint_cache *iint = NULL;
>         struct ima_template_desc *template_desc;
>         char *pathbuf = NULL;
> @@ -228,9 +229,16 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>                                  IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
>                                  IMA_ACTION_FLAGS);
>
> -       if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags))
> -               /* reset all flags if ima_inode_setxattr was called */
> +       /*
> +        * Re-measure, re-appraise, and/or re-audit a file, if the security
> +        * xattrs changed or if the file is on an untrusted file system
> +        * (eg. FUSE, remote filesystems).
> +        */
> +       if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
> +           (dentry->d_op && dentry->d_op->d_revalidate)) {

It seems dangerous to rely implicitly on "d_revalidate != NULL". vfat
has a d_revalidate for handling 8.3 filenames but it's not a network
filesystem.
