Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:50374 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbeBWEA0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Feb 2018 23:00:26 -0500
Date: Fri, 23 Feb 2018 15:00:23 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ima: unverifiable file signatures
In-Reply-To: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.21.1802231500070.3442@namei.org>
References: <1519335184-17808-1-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 22 Feb 2018, Mimi Zohar wrote:

> For local filesystems, the kernel prevents files being executed from
> being modified.  With IMA-measurement enabled, the kernel also emits
> audit "time of measure, time of use" messages for files opened for
> read, and subsequently opened for write.
> 
> Files on fuse are initially measured, appraised, and audited.  Although
> the file data can change dynamically any time, making re-measuring,
> re-appraising, or re-auditing pointless, this patch set attempts to
> differentiate between unprivileged non-init root and privileged
> mounted fuse filesystems.
> 
> This patch set addresses three different scenarios:
> - Unprivileged non-init root mounted fuse filesystems are untrusted.
>   Signature verification should always fail and re-measuring,
>   re-appraising, re-auditing files makes no sense.
> 
>   Always enabled.
> 
> - For privileged mounted filesystems in a "secure" environment, with a
>   correctly enforced security policy, which is willing to assume the
>   inherent risk of specific fuse filesystems, it is reasonable to
>   re-measure, re-appraise, and re-audit files.
> 
>   Enabled by default to prevent breaking existing systems.
> 
> - Privileged mounted filesystems unwilling to assume the risks and
>   prefers to fail safe.
> 
>   Enabled based on policy.

I like this approach.


-- 
James Morris
<jmorris@namei.org>
