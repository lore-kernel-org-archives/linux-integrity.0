Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:55796 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbeCMTlG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Mar 2018 15:41:06 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 14:40:18 -0500
In-Reply-To: <1520540650-7451-1-git-send-email-zohar@linux.vnet.ibm.com> (Mimi
        Zohar's message of "Thu, 8 Mar 2018 15:24:06 -0500")
Message-ID: <87zi3bwyql.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v3 0/4] unverifiable file signatures
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

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

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Overall ack on the way this is put together.

Eric

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
>   prefers to securely fail safe.
>
>   Enabled based on policy.
>
> Changelog v3:
> - Fix SB_IMA_UNVERIFIABLE_SIGNATURE & SB_I_UNTRUSTED_MOUNTER test.
> - Rename the builtin policy name to "fail_securely".
>
> Mimi
>
> Mimi Zohar (4):
>   ima: fail file signature verification on non-init mounted filesystems
>   ima: re-evaluate files on privileged mounted filesystems
>   ima: fail signature verification based on policy
>   fuse: define the filesystem as untrusted
>
>  Documentation/admin-guide/kernel-parameters.txt |  8 +++++++-
>  fs/fuse/inode.c                                 |  3 +++
>  include/linux/fs.h                              |  2 ++
>  security/integrity/ima/ima_appraise.c           | 16 +++++++++++++++-
>  security/integrity/ima/ima_main.c               | 14 ++++++++++++--
>  security/integrity/ima/ima_policy.c             |  5 +++++
>  security/integrity/integrity.h                  |  1 +
>  7 files changed, 45 insertions(+), 4 deletions(-)
