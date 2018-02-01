Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:44325 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeBAWW5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Feb 2018 17:22:57 -0500
Received: by mail-wr0-f169.google.com with SMTP id v31so20666042wrc.11
        for <linux-integrity@vger.kernel.org>; Thu, 01 Feb 2018 14:22:56 -0800 (PST)
Date: Thu, 1 Feb 2018 15:22:51 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mario.Limonciello@dell.com
Cc: Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org,
        regressions@leemhuis.info, James.Bottomley@HansenPartnership.com,
        pmenzel@molgen.mpg.de
Subject: Re: TPM selftest failure in 4.15 (Dell XPS 13, Nuvoton 6xx)
Message-ID: <20180201222251.GB17053@ziepe.ca>
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
 <4384419e-b2c6-7c51-e905-281ddfe68442@molgen.mpg.de>
 <d9c63b11-363a-2007-d7d5-a0112e58cb46@molgen.mpg.de>
 <d95f60f2e375446db3987f7d082d5cdd@ausx13mpc120.AMER.DELL.COM>
 <0d6c700430264d9584426a587b7c056e@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0d6c700430264d9584426a587b7c056e@ausx13mpc120.AMER.DELL.COM>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, Feb 01, 2018 at 09:06:55PM +0000, Mario.Limonciello@dell.com wrote:

> I discussed this with some folks and although it would fix the
> problem it is not accurately characterizing the situation.  What is
> likely happening here is that issuing the self test command in
> succession is causing the TPM to restart the self test and not
> complete.  Instead the selfTestDone bit should be polled.

Oh, I wonder if that is beacuse this was copied from the TPM1 version
where we don't have a bit like that??

Should we check this selfTestDone bit before event sending the self
test?

Jsaon
