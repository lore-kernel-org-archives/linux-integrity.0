Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754704AbdKMTg5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Nov 2017 14:36:57 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vADJYEAq050321
        for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2017 14:36:57 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2e7ffdenth-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2017 14:36:56 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 13 Nov 2017 19:36:54 -0000
Subject: Re: [RFC PATCH v2] fw_lockdown: new micro LSM module to prevent
 loading unsigned firmware
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kyle McMartin <kyle@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date: Mon, 13 Nov 2017 14:36:47 -0500
In-Reply-To: <20171113190505.GC22894@wotan.suse.de>
References: <1510573414.3404.109.camel@linux.vnet.ibm.com>
         <20171113190505.GC22894@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510601807.3711.16.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-11-13 at 20:05 +0100, Luis R. Rodriguez wrote:
> On Mon, Nov 13, 2017 at 06:43:34AM -0500, Mimi Zohar wrote:

> > + * fw_lockdown_read_file - prevent loading of unsigned firmware
> > + * @file: pointer to firmware
> > + * @read_id: caller identifier
> > + *
> > + * Prevent loading of unsigned firmware in lockdown mode.
> > + */
> > +static int fw_lockdown_read_file(struct file *file, enum kernel_read_file_id id)
> > +{
> > +	if (id == READING_FIRMWARE) {
> > +		if (!is_ima_appraise_enabled() &&
> > +		    kernel_is_locked_down("Loading of unsigned firmware"))
> > +			return -EACCES;
> > +	}
> 
> How about just if (id != READING_FIRMWARE) return 0 right away so that
> the real code of focus is not always indented.

Sure

> This could let the code
> grow nicely.
> 
> What I meant above is later we may extend this with:
> 
> if hash_available()
> 	if !valid_hash()
> 		return -EACCES
> else if default_fw_key_available()
> 	if !fw_signed_default_key()
> 		return -EACCES;
> 
> That could be the way we support a default system policy for firmware
> signing, and it would not require any modifications to any firmware
> API callers.
> 
> Notice though that if we later want to extend support for custom requirements
> the semantics behind kernel_read_file() would not suffice to LSMify them, as
> such I'd think we'd need another call which lets the security requirements
> be passed.
> 
> Its unclear if IMA may want to ignore that criteria, as it does the checks in
> userspace.

Huh, I kind of lost you here.  What does "it" refer to in the above
sentence?  IMA is in the kernel.  So, who does what checks in
userspace?

>  If it *can* make use of it, it could do the check-in kernel, of
> course.

> > +	return 0;
> > +}
> > +
> > +static struct security_hook_list fw_lockdown_hooks[] = {
> > +	LSM_HOOK_INIT(kernel_read_file, fw_lockdown_read_file)
> > +};
> > +
> > +static int __init init_fw_lockdown(void)
> > +{
> > +	security_add_hooks(fw_lockdown_hooks, ARRAY_SIZE(fw_lockdown_hooks),
> > +			   "fw_lockdown");
> > +	pr_info("initialized\n");
> > +	return 0;
> > +}
> > +
> > +late_initcall(init_fw_lockdown);
> > +MODULE_LICENSE("GPL");
> > diff --git a/security/security.c b/security/security.c
> > index 4bf0f571b4ef..61a0c95ec687 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -32,7 +32,7 @@
> >  #define MAX_LSM_EVM_XATTR	2
> >  
> >  /* Maximum number of letters for an LSM name string */
> > -#define SECURITY_NAME_MAX	10
> > +#define SECURITY_NAME_MAX	15
> 
> Should this small hunk be a separate atomic patch?

I thought about it, but this is the first and only LSM with a larger
name.

Mimi
