Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39947 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755369AbdKMUSc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Nov 2017 15:18:32 -0500
Date: Mon, 13 Nov 2017 21:18:30 +0100
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
Message-ID: <20171113201830.GF22894@wotan.suse.de>
References: <1510573414.3404.109.camel@linux.vnet.ibm.com>
 <20171113190505.GC22894@wotan.suse.de>
 <1510601807.3711.16.camel@linux.vnet.ibm.com>
 <20171113195154.GE22894@wotan.suse.de>
 <1510603872.3711.36.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1510603872.3711.36.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, Nov 13, 2017 at 03:11:12PM -0500, Mimi Zohar wrote:
> On Mon, 2017-11-13 at 20:51 +0100, Luis R. Rodriguez wrote:
> > On Mon, Nov 13, 2017 at 02:36:47PM -0500, Mimi Zohar wrote:
> 
> > > Huh, I kind of lost you here.  What does "it" refer to in the above
> > > sentence?  IMA is in the kernel.  So, who does what checks in
> > > userspace?
> > 
> > Sorry I thought some checks were done in userspace, given that is clarified,
> > what I meant is that say a device driver has a signing specification written
> > out in the driver, should/can IMA use that on the LSM to verify the detached
> > signature file for the firmware?
> 
> IMA-appraisal currently supports file signatures as extended
> attributes.  Thiago Bauermann posted patches for including appended
> signature support to IMA-appraisal.  If someone is interested in
> adding detached signature support, they're welcome to do so.

Neat.

> > If it can be all done in kernel, it has me wondering if perhaps one option for
> > IMA might be to do only vetting for these types of checks, where the info and
> > description to appraise files is all in-kernel. IMA would not be required
> > for other files.
> 
> We probably can defer this discussion until it is applicable.

Fair enough :)

  Luis
