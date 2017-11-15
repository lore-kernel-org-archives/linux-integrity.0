Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932626AbdKOMiT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Nov 2017 07:38:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAFCcCPq120650
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2017 07:38:19 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2e8m6c4bv1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2017 07:38:11 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 15 Nov 2017 12:37:25 -0000
Subject: Re: [GIT PULL] Security subsystem: integrity updates for v4.15
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: James Morris <james.l.morris@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Wed, 15 Nov 2017 07:37:20 -0500
In-Reply-To: <alpine.LFD.2.20.1711130901380.28856@localhost>
References: <alpine.LFD.2.20.1711130901380.28856@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1510749440.3711.285.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2017-11-13 at 09:05 +1100, James Morris wrote:
> Hi Linus,
> 
> Please pull these fixes for the Integrity subsystem.
> 
> (From Mimi)
> 
> "There is a mixture of bug fixes, code cleanup, preparatory code for new 
> functionality and new functionality.
> 
> Commit 26ddabfe96bb "evm: enable EVM when X509 certificate is loaded" 
> enabled EVM without loading a symmetric key, but was limited to defining 
> the x509 certificate pathname at build.  Included in this set of patches 
> is the ability of enabling EVM, without loading the EVM symmetric key, 
> from userspace.  New is the ability to prevent the loading of an EVM 
> symmetric key."

James, thank you for keeping the integrity patches separate, as
requested, and sending the extra pull request.  This is extra work for
you, but I really appreciate it.  The pull request seems to have gone
smoothly.

So much of the integrity subsystem is dependent on the other security
subsystems (eg. keys, TPM, LSM hooks).  Having a common security
testing branch is really helpful.  It makes collaboration that much
easier.

Thanks!

Mimi
