Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756678AbeEATAt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 15:00:49 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CACdnJuui_ASxmKCK2Bi_Fq+Esf7gMrSRrC8UHwzyQ=N+ULHVYw@mail.gmail.com>
References: <CACdnJuui_ASxmKCK2Bi_Fq+Esf7gMrSRrC8UHwzyQ=N+ULHVYw@mail.gmail.com> <26787.1519902415@warthog.procyon.org.uk>
To: Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: dhowells@redhat.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: linux-next: UEFI Secure boot lockdown patchset
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 01 May 2018 20:00:47 +0100
Message-ID: <8106.1525201247@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Matthew Garrett <mjg59@google.com> wrote:

> (a) seems unnecessary, and (b) isn't possible in most distributions
> (there's ongoing work in Debian, but it's not merged yet). I can see cases
> where you'd want to enforce this via IMA, but I don't think it's
> appropriate for all cases. Should the use of the IMA secure_boot policy be
> gated behind a config option?

Quite probably.  Mimi?

David
