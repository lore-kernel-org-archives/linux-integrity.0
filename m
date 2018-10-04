Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbeJDHGp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Oct 2018 03:06:45 -0400
Date: Wed, 3 Oct 2018 17:16:02 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: Re: [PATCH] security/integrity: remove unnecessary 'init_keyring'
 variable
Message-ID: <20181004001602.GD58226@gmail.com>
References: <20180907202515.217716-1-ebiggers@kernel.org>
 <1537555358.3830.345.camel@linux.ibm.com>
 <20180921185433.GA255965@gmail.com>
 <1537556534.3830.353.camel@linux.ibm.com>
 <20180921193300.GB255965@gmail.com>
 <1537559733.3830.363.camel@linux.ibm.com>
 <20180921201322.GC255965@gmail.com>
 <1537562546.3830.373.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1537562546.3830.373.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Sep 21, 2018 at 04:42:26PM -0400, Mimi Zohar wrote:
> On Fri, 2018-09-21 at 13:13 -0700, Eric Biggers wrote:
> > On Fri, Sep 21, 2018 at 03:55:33PM -0400, Mimi Zohar wrote:
> > > On Fri, 2018-09-21 at 12:33 -0700, Eric Biggers wrote:
> > > > On Fri, Sep 21, 2018 at 03:02:14PM -0400, Mimi Zohar wrote:
> > > > > On Fri, 2018-09-21 at 11:54 -0700, Eric Biggers wrote:
> > > > > > On Fri, Sep 21, 2018 at 02:42:38PM -0400, Mimi Zohar wrote:
> > > > > > > On Fri, 2018-09-07 at 13:25 -0700, Eric Biggers wrote:
> > > > > > > > From: Eric Biggers <ebiggers@google.com>
> > > > > > > > 
> > > > > > > > The 'init_keyring' variable actually just gave the value of
> > > > > > > > CONFIG_INTEGRITY_TRUSTED_KEYRING.  We should check the config option
> > > > > > > > directly instead.  No change in behavior; this just simplifies the code.
> > > > > > > 
> > > > > > > We try to minimize as much as possible "ifdefs" in C code.  This
> > > > > > > change is moving in the wrong direction.
> > > > > > 
> > > > > > So your preferred approach is to store the values of Kconfig options in
> > > > > > variables?  That defeats much of the point of having Kconfig options...
> > > > > 
> > > > > No, I prefer using "ifdefs" in include files, not C code, and defining
> > > > > stub functions.
> > > > > 
> > > > > Mimi
> > > > > 
> > > > 
> > > > integrity_init_keyring() is already stubbed out in a header.  What are you
> > > > suggesting, exactly?
> > > 
> > > Refer to section "20) Conditional Compilation" of
> > > Documentation/process/coding-style.rst.
> > > 
> > > Mimi
> > > 
> > 
> > I'm already familiar with that.  Unfortunately, you haven't clearly indicated
> > what alternative you prefer, and it's unclear whether you've even read my patch,
> > given that you're apparently saying to define a stub function which actually
> > already exists.  Maybe you want the 'init_keyring' bool replaced
> > IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING)?  That doesn't really make sense
> > though, because integrity_init_keyring() is already stubbed out in some
> > configurations; it makes more sense to fix the condition for stubbing it out...
> 
> I read your patch and commented that "ifdefs" don't belong in .c
> files, as the above referenced doc says.  My comment on using ifdefs
> for defining stubs was simply an example of how to get around using
> ifdefs in C.
> 
> The doc seems to be suggesting to use IS_ENABLED() to set a flag,
> which is what the existing code does.  Replacing the existing code
> with IS_ENABLE() would be fine, but seems unnecessary.
> 
> I don't see a need to change the existing code to add more ifdefs in
> .c files.
> 

There's no need to have a static variable that just holds the value of a
build-time define.  That's common sense.  And no, the coding style doc doesn't
say otherwise.  Anyway, I'll send the version that just replaces it with
IS_ENABLED() since that's still much better than the weird obfuscated thing it's
doing now, though it's still a bit silly since the function is already stubbed
out in some configurations...

- Eric
