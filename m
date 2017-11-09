Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35992 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdKITSG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Nov 2017 14:18:06 -0500
Date: Fri, 10 Nov 2017 06:17:49 +1100 (AEDT)
From: James Morris <james.l.morris@oracle.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH] ima: require secure_boot rules in lockdown mode
In-Reply-To: <1510235213.4484.165.camel@linux.vnet.ibm.com>
Message-ID: <alpine.LFD.2.20.1711100617360.5638@localhost>
References: <1509382827.3583.143.camel@linux.vnet.ibm.com>  <1508774387.3639.128.camel@linux.vnet.ibm.com>  <750.1509378910@warthog.procyon.org.uk>  <3691.1509383138@warthog.procyon.org.uk>  <1509385178.3583.159.camel@linux.vnet.ibm.com>
 <alpine.LFD.2.20.1710311424310.22021@localhost>  <1510173982.4484.30.camel@linux.vnet.ibm.com>  <20171109075334.1809f4cc@canb.auug.org.au>  <1510175047.4484.35.camel@linux.vnet.ibm.com>  <20171109102635.7691281d@canb.auug.org.au>  <1510196818.4484.120.camel@linux.vnet.ibm.com>
  <alpine.LFD.2.20.1711100020240.514@localhost> <1510235213.4484.165.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-663896429-1510255074=:5638"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 9 Nov 2017, Mimi Zohar wrote:

> Thank you for the clarification (and patience).  There are a lot of
> interactions between the integrity subsystem and the other security
> subsystems, especially the TPM.  Assuming it is acceptable, as you
> said, I'd really prefer continuing to have the integrity subsystem
> merged via the security tree.

That's fine, whatever works for you.


-- 
James Morris
<james.l.morris@oracle.com>
