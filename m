Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755093AbdKMTv5 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Nov 2017 14:51:57 -0500
Date: Mon, 13 Nov 2017 20:51:54 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
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
Subject: Re: [RFC PATCH v2] fw_lockdown: new micro LSM module to prevent
 loading unsigned firmware
Message-ID: <20171113195154.GE22894@wotan.suse.de>
References: <1510573414.3404.109.camel@linux.vnet.ibm.com>
 <20171113190505.GC22894@wotan.suse.de>
 <1510601807.3711.16.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1510601807.3711.16.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Nov 13, 2017 at 02:36:47PM -0500, Mimi Zohar wrote:
> On Mon, 2017-11-13 at 20:05 +0100, Luis R. Rodriguez wrote:
> > > + * fw_lockdown_read_file - prevent loading of unsigned firmware
> > > + * @file: pointer to firmware
> > > + * @read_id: caller identifier
> > > + *
> > > + * Prevent loading of unsigned firmware in lockdown mode.
> > > + */
> > > +static int fw_lockdown_read_file(struct file *file, enum kernel_read_file_id id)
> > > +{
> > > +	if (id == READING_FIRMWARE) {
> > > +		if (!is_ima_appraise_enabled() &&
> > > +		    kernel_is_locked_down("Loading of unsigned firmware"))
> > > +			return -EACCES;
> > > +	}
> > This could let the code
> > grow nicely.
> > 
> > What I meant above is later we may extend this with:
> > 
> > if hash_available()
> > 	if !valid_hash()
> > 		return -EACCES
> > else if default_fw_key_available()
> > 	if !fw_signed_default_key()
> > 		return -EACCES;
> > 
> > That could be the way we support a default system policy for firmware
> > signing, and it would not require any modifications to any firmware
> > API callers.
> > 
> > Notice though that if we later want to extend support for custom requirements
> > the semantics behind kernel_read_file() would not suffice to LSMify them, as
> > such I'd think we'd need another call which lets the security requirements
> > be passed.
> > 
> > Its unclear if IMA may want to ignore that criteria, as it does the checks in
> > userspace.
> 
> Huh, I kind of lost you here.  What does "it" refer to in the above
> sentence?  IMA is in the kernel.  So, who does what checks in
> userspace?

Sorry I thought some checks were done in userspace, given that is clarified,
what I meant is that say a device driver has a signing specification written
out in the driver, should/can IMA use that on the LSM to verify the detached
signature file for the firmware?

If it can be all done in kernel, it has me wondering if perhaps one option for
IMA might be to do only vetting for these types of checks, where the info and
description to appraise files is all in-kernel. IMA would not be required
for other files.

> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -32,7 +32,7 @@
> > >  #define MAX_LSM_EVM_XATTR	2
> > >  
> > >  /* Maximum number of letters for an LSM name string */
> > > -#define SECURITY_NAME_MAX	10
> > > +#define SECURITY_NAME_MAX	15
> > 
> > Should this small hunk be a separate atomic patch?
> 
> I thought about it, but this is the first and only LSM with a larger
> name.

Maybe the commit log should mention that then.

  Luis
