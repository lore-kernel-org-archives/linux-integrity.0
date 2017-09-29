Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:45901 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbdI2SJd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Sep 2017 14:09:33 -0400
Received: by mail-it0-f47.google.com with SMTP id x15so742913itb.0
        for <linux-integrity@vger.kernel.org>; Fri, 29 Sep 2017 11:09:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506646397.5691.64.camel@linux.vnet.ibm.com>
References: <20170927221653.11219-1-mjg59@google.com> <1506629560.5691.33.camel@linux.vnet.ibm.com>
 <CACdnJuuveRvCx57ZnYmRWbiwh3XU7AbxZD2W-Gq_dh_h_6L9Mg@mail.gmail.com> <1506646397.5691.64.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Fri, 29 Sep 2017 11:09:30 -0700
Message-ID: <CACdnJuueNfLdDnCsmotGhLC58cJXXh35FeZzipJ_ZshScPM=qA@mail.gmail.com>
Subject: Re: RFC: Make it practical to ship EVM signatures
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        Mikhail Kurinnoi <viewizard@viewizard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Sep 28, 2017 at 5:53 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Without the inode included in the HMAC calculation, the same file
> could exist as a different file name on the same file system.  No need
> for the two files to be on different file systems.

But if I create a hardlink to an existing file then I get the same
file with the same inode number and two different names on the same
filesystem, and so security.evm would still match?


>> One of the reasons we're interested in allowing the use of signatures
>> rather than HMACs is to avoid the case where a machine being
>> compromised would allow an attacker to obtain the symmetric key and
>> drop new appropriately HMACed binaries on the system that would
>> persist even if the kernel was updated to fix the vulnerability.
>
> Assuming you're using a trusted key (TPM based key) to encrypt/decrypt
> the EVM key (trusted key), then such an attack would require root
> privileges with the ability to read kernel memory.  The EVM key is
> never exposed to userspace in the clear.

That's a case that we need to be worried about. Trusted boot means we
can ensure that a system boots an updated kernel, but if the attacker
has been able to drop a modified sshd with a valid hmac onto the
system then we have fewer guarantees about the integrity. We could
continue using signatures for security.ima to avoid that, but then we
lose the performance benefits of the hmac and also don't have the same
level of guarantees around the other security metadata.
