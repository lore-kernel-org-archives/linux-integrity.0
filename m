Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41497 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754829AbdKIN3E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Nov 2017 08:29:04 -0500
Date: Fri, 10 Nov 2017 00:28:40 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <1510196818.4484.120.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LFD.2.20.1711100020240.514@localhost>
References: <1509382827.3583.143.camel@linux.vnet.ibm.com>         <1508774387.3639.128.camel@linux.vnet.ibm.com>         <750.1509378910@warthog.procyon.org.uk>         <3691.1509383138@warthog.procyon.org.uk>         <1509385178.3583.159.camel@linux.vnet.ibm.com>
         <alpine.LFD.2.20.1710311424310.22021@localhost>         <1510173982.4484.30.camel@linux.vnet.ibm.com>         <20171109075334.1809f4cc@canb.auug.org.au>         <1510175047.4484.35.camel@linux.vnet.ibm.com>         <20171109102635.7691281d@canb.auug.org.au>
 <1510196818.4484.120.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 8 Nov 2017, Mimi Zohar wrote:

> > So since those patches are now in James tree, you should drop them from
> > the integrity tree.
> 
> Ok, I had been planning on sending an independent pull request to
> Linus, as requested.

That was not requested.  Linus wants separate branches to pull from, but 
this does not mean separate trees.  The x86 and some other subsystems use 
separate branches in the same tree, which is the model we're now using 
generally with the security subsystem.

It's _also_ possible to send pull requests independently (which is what 
the SELinux and AppArmor maintainers decided to do), although that was not 
what Linus was asking for.

It's up to you if you want to send pull requests directly to Linus or 
continue to merge via the security tree.


- James
-- 
James Morris
<james.l.morris@oracle.com>
