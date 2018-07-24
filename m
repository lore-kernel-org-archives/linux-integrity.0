Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:40380 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388415AbeGXTy3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jul 2018 15:54:29 -0400
Date: Wed, 25 Jul 2018 04:46:40 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Mimi Zohar <zohar@linux.ibm.com>
cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [GIT PULL]  linux-integrity patches for 4.19
In-Reply-To: <alpine.LRH.2.21.1807250445390.10717@namei.org>
Message-ID: <alpine.LRH.2.21.1807250446280.10717@namei.org>
References: <1532430023.4127.10.camel@linux.ibm.com> <alpine.LRH.2.21.1807250445390.10717@namei.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-553496164-1532458000=:10717"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 25 Jul 2018, James Morris wrote:

> On Tue, 24 Jul 2018, Mimi Zohar wrote:
> 
> > Hi James,
> > 
> > This pull request adds support for EVM signatures based on larger
> > digests, contains a new audit record AUDIT_INTEGRITY_POLICY_RULE to
> > differentiate the IMA policy rules from the IMA-audit messages,
> > addresses two deadlocks due to either loading or searching for crypto
> > algorithms, and cleans up the audit messages.
> > 
> > New to 4.19, but not included in this pull request, is support for a
> > build time IMA policy.  Build time IMA policy rules are automatically
> > enabled on boot and persist after loading a custom policy.
> > 
> 
> merged


-- 
James Morris
<jmorris@namei.org>
