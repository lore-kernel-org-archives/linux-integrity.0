Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:51748 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754742AbdJPSNV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Oct 2017 14:13:21 -0400
Received: by mail-it0-f41.google.com with SMTP id o135so2216098itb.0
        for <linux-integrity@vger.kernel.org>; Mon, 16 Oct 2017 11:13:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508076505.3426.139.camel@linux.vnet.ibm.com>
References: <20171011191218.5274-1-mjg59@google.com> <20171011191218.5274-2-mjg59@google.com>
 <1508076505.3426.139.camel@linux.vnet.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Mon, 16 Oct 2017 11:13:20 -0700
Message-ID: <CACdnJutj6rgy6hd1yMDO85ihUoCakRQDTG570Qk=_M-hrzURWA@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] Add a bprm_interpreted security hook and call into
 IMA from it
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>,
        james.l.morris@oracle.com, keescook@chromium.org, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, Oct 15, 2017 at 7:08 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Even with this additional patch, there are still potentially missing measurements/appraisals as search_binary_handler is exported.  The original search_binary_handler is called twice, once for the original file and again for the interpreter.  With these patches, the security hooks are deferred, requiring calls in the specific binary handler.
>
> For your usecase scenario this might be enough, but for the general case the security_bprm_check hooks would still be needed.

Mm. Yeah. Ok let me try tackling this in a different way.
