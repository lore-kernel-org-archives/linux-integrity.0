Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:39252 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753282AbeEAR3B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 13:29:01 -0400
Received: by mail-it0-f46.google.com with SMTP id c3-v6so13891073itj.4
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 10:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <26787.1519902415@warthog.procyon.org.uk>
In-Reply-To: <26787.1519902415@warthog.procyon.org.uk>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 01 May 2018 17:28:49 +0000
Message-ID: <CACdnJuui_ASxmKCK2Bi_Fq+Esf7gMrSRrC8UHwzyQ=N+ULHVYw@mail.gmail.com>
Subject: Re: linux-next: UEFI Secure boot lockdown patchset
To: David Howells <dhowells@redhat.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Mar 1, 2018 at 3:06 AM David Howells <dhowells@redhat.com> wrote:

>   - Requring IMA to use secure boot rules

On systems that have IMA enabled, this appears to enforce a policy that
requires that IMA signatures be present for kexec and modules.
Distributions are already shipping signed modules and kernel images, so
this policy appears to enforce that

(a) they be signed twice, and
(b) distributions have a mechanism for shipping extended attributes in
packages

(a) seems unnecessary, and (b) isn't possible in most distributions
(there's ongoing work in Debian, but it's not merged yet). I can see cases
where you'd want to enforce this via IMA, but I don't think it's
appropriate for all cases. Should the use of the IMA secure_boot policy be
gated behind a config option?
