Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41786 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbdJaDZi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Oct 2017 23:25:38 -0400
Date: Tue, 31 Oct 2017 14:25:26 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <1509385178.3583.159.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LFD.2.20.1710311424310.22021@localhost>
References: <1509382827.3583.143.camel@linux.vnet.ibm.com>         <1508774387.3639.128.camel@linux.vnet.ibm.com>         <750.1509378910@warthog.procyon.org.uk>         <3691.1509383138@warthog.procyon.org.uk>
 <1509385178.3583.159.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-984484137-1509420330=:22021"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 30 Oct 2017, Mimi Zohar wrote:

> James is staging the subsystem patches independently of each other, in
> case of a similar problem, so that they can be pulled separately.
>  There's a new "next-general" branch.

If you send me a pull request, I'm combining branches into next-testing, 
too, which is pulled into -next.


-- 
James Morris
<james.l.morris@oracle.com>
