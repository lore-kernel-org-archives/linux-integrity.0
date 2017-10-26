Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50209 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932246AbdJZO5u (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Oct 2017 10:57:50 -0400
Date: Thu, 26 Oct 2017 16:57:48 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@google.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Kari Hiitola <kari@varaani.com>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: Fixing CVE-2017-15361
Message-ID: <20171026165748.265e6dcf@kitsune.suse.cz>
In-Reply-To: <20171026140602.syifqbrgysvq7ciy@linux.intel.com>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
        <CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
        <20171025185349.ocptudim3g35j6im@linux.intel.com>
        <F1DA2BF7-4A3D-4934-9C45-4DAC4FD33659@gmx.de>
        <20171026111632.g6a3bkhe4nxorfbm@linux.intel.com>
        <20171026145902.2e7dbb06@kitsune.suse.cz>
        <20171026140602.syifqbrgysvq7ciy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 26 Oct 2017 16:06:02 +0200
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> On Thu, Oct 26, 2017 at 02:59:02PM +0200, Michal Suchanek wrote:
> > It does not really matter. People ignore the messages unless looking
> > for something specific as you already noticed. Warn seems adequate
> > because the cipher is weaker than expected but not known to
> > be compromised. People who care can look up the message. People who
> > don't care will ignore it even if it's crit.  
> 
> Is it worth of trouble to do any driver changes then (open question to
> everyone)? I'm not sure it is worth of trouble to add cruft to the
> driver code for a warning that will likely be ignored anyway.

If the kernel can reliably detect the affected TPMs it saves the
user the work of figuring out where the firmware revision is accessible
on the running machine and what firmware revisions are affected.

Thanks

Michal
