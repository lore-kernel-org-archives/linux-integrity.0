Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:19509 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752513AbdKMU7v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Nov 2017 15:59:51 -0500
Date: Tue, 14 Nov 2017 07:58:45 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
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
In-Reply-To: <20171113195154.GE22894@wotan.suse.de>
Message-ID: <alpine.LFD.2.20.1711140758110.6276@localhost>
References: <1510573414.3404.109.camel@linux.vnet.ibm.com> <20171113190505.GC22894@wotan.suse.de> <1510601807.3711.16.camel@linux.vnet.ibm.com> <20171113195154.GE22894@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 13 Nov 2017, Luis R. Rodriguez wrote:

> > > > -#define SECURITY_NAME_MAX	10
> > > > +#define SECURITY_NAME_MAX	15
> > > 
> > > Should this small hunk be a separate atomic patch?
> > 
> > I thought about it, but this is the first and only LSM with a larger
> > name.
> 
> Maybe the commit log should mention that then.

Actually, make it a separate patch, so we can easily pinpoint the commit.

-- 
James Morris
<james.l.morris@oracle.com>
