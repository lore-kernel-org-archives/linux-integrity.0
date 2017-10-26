Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:58730 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932334AbdJZS66 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Oct 2017 14:58:58 -0400
Date: Thu, 26 Oct 2017 20:58:53 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Thiebaud Weksteen <tweek@google.com>
Cc: linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        peterhuewe@gmx.de,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        tpmdd@selhorst.net
Subject: Re: [PATCH v3 4/5] efi: call get_event_log before ExitBootServices
Message-ID: <20171026185853.bfh7jidixrxb6ozj@linux.intel.com>
References: <CA+zpnLcYWcO8Gf6b8rAHgcLkAndC0uyPH+Kxa01giVsochP3Ug@mail.gmail.com>
 <20170929171617.yq4dvn66czvnebns@linux.intel.com>
 <20171004105113.mcho3rlytaxfruyf@linux.intel.com>
 <CA+zpnLdg4km1vMUUZaYfRg6M68+nSdC+vASULmH-aKu4vYyy4Q@mail.gmail.com>
 <20171010141419.e4uv4fkmcmpc7sdc@linux.intel.com>
 <alpine.LRH.2.21.1710111250260.22885@namei.org>
 <20171011115254.2n4zs77ixyl2mdgm@linux.intel.com>
 <20171016112833.txbg2sm5tjocp6qh@linux.intel.com>
 <20171016114946.phj3n6vyjdbpj2sj@linux.intel.com>
 <CA+zpnLc038dv-WAE7fdD8i6DpGV3zCLEieg-KPTAvaW7yt-tLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+zpnLc038dv-WAE7fdD8i6DpGV3zCLEieg-KPTAvaW7yt-tLA@mail.gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Oct 17, 2017 at 10:00:15AM +0200, Thiebaud Weksteen wrote:
> This patch was mainly developed and tested on Kabylake with PTT as well.
> 
> It could be a few things. Are you booting with the EFI stub? Is the
> TPM enabled within the BIOS? Does tpm_tis get loaded? Does it produce
> any log?

Nope, and it should not get loaded anyway as I'm using PTT. With PTT you
use tpm_crb. TPM is working just fine.

> If the logs are recovered (but not parsed), you should already see an
> entry in the logs like:
> 
> efi:  SMBIOS=0x7fed6000  ACPI=0x7ff00000  TPMEventLog=0x.....
> 
> Can you see the TPMEventLog part?

I can check this when I'm back in Finland. Still in Prague. Tried to
test this with my work laptop (XPS13 with dTPM) now but the USB stick I
have with seems to be broken :-(

This is anyway almost guaranteed to go to 4.16  and I don't want to push
this to 4.15 so there is no rush right now (already sent my PR).

> The issue with extra logging is that the log recovery happens within
> the EFI stub phase where limited logging is available (which I think
> has been limited to error and fatal message only).
> For now, it cannot be a version mismatch as the stub will only request
> the version 1.2 format.

Right, I see.

/Jarkko
