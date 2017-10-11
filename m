Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from namei.org ([65.99.196.166]:52691 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752751AbdJKByx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Oct 2017 21:54:53 -0400
Date: Wed, 11 Oct 2017 12:54:26 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
cc: Thiebaud Weksteen <tweek@google.com>, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        peterhuewe@gmx.de,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        tpmdd@selhorst.net
Subject: Re: [PATCH v3 4/5] efi: call get_event_log before ExitBootServices
In-Reply-To: <20171010141419.e4uv4fkmcmpc7sdc@linux.intel.com>
Message-ID: <alpine.LRH.2.21.1710111250260.22885@namei.org>
References: <20170920081340.7413-1-tweek@google.com> <20170920081340.7413-5-tweek@google.com> <20170926114538.r5hsyc5osodpaals@linux.intel.com> <CA+zpnLcYWcO8Gf6b8rAHgcLkAndC0uyPH+Kxa01giVsochP3Ug@mail.gmail.com> <20170929171617.yq4dvn66czvnebns@linux.intel.com>
 <20171004105113.mcho3rlytaxfruyf@linux.intel.com> <CA+zpnLdg4km1vMUUZaYfRg6M68+nSdC+vASULmH-aKu4vYyy4Q@mail.gmail.com> <20171010141419.e4uv4fkmcmpc7sdc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 10 Oct 2017, Jarkko Sakkinen wrote:

> The way I've agreed with James Morris to have my tree is to be rooted to
> security trees next branch.
> 
> James, what actions should we take?

This process has changed recently -- I posted to lsm but forgot to post to 
linux-integrity.

http://kernsec.org/pipermail/linux-security-module-archive/2017-September/003356.html

Summary: please track the next-general branch in my tree for your 
development, it replaces 'next'.


- James
-- 
James Morris
<jmorris@namei.org>
