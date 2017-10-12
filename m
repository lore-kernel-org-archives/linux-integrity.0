Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:47332 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbdJLPDj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Oct 2017 11:03:39 -0400
Received: by mail-it0-f49.google.com with SMTP id p138so7635838itp.2
        for <linux-integrity@vger.kernel.org>; Thu, 12 Oct 2017 08:03:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171012113844.ptfynppgx3tkwe7g@linux.intel.com>
References: <20170920081340.7413-5-tweek@google.com> <20170926114538.r5hsyc5osodpaals@linux.intel.com>
 <CA+zpnLcYWcO8Gf6b8rAHgcLkAndC0uyPH+Kxa01giVsochP3Ug@mail.gmail.com>
 <20170929171617.yq4dvn66czvnebns@linux.intel.com> <20171004105113.mcho3rlytaxfruyf@linux.intel.com>
 <CA+zpnLdg4km1vMUUZaYfRg6M68+nSdC+vASULmH-aKu4vYyy4Q@mail.gmail.com>
 <20171010141419.e4uv4fkmcmpc7sdc@linux.intel.com> <alpine.LRH.2.21.1710111250260.22885@namei.org>
 <20171011115254.2n4zs77ixyl2mdgm@linux.intel.com> <20171011115318.i342rzq3akqbrovv@linux.intel.com>
 <20171012113844.ptfynppgx3tkwe7g@linux.intel.com>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Thu, 12 Oct 2017 17:03:38 +0200
Message-ID: <CABxcv=neJZjA407pbmNesNbGY9k3VRbhawut6ewofw_UB5U1_w@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] efi: call get_event_log before ExitBootServices
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: James Morris <jmorris@namei.org>,
        Thiebaud Weksteen <tweek@google.com>,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        tpmdd-devel@lists.sourceforge.net,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>, peterhuewe@gmx.de,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        tpmdd@selhorst.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Oct 12, 2017 at 1:38 PM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:

[snip]

>
> Now all Thiebaud's patches have been applied to the master of
>
>   git://git.infradead.org/users/jjs/linux-tpmdd.git
>
> Testing is still pending.
>

I provided my reviewed and tested by tags for the patches but I
noticed that weren't picked. Probably my fault though since I answered
to the cover letter instead of the individual patches.

> /Jarkko

Best regards,
Javier
