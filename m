Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38700 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdKUT1L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Nov 2017 14:27:11 -0500
Received: by mail-wm0-f43.google.com with SMTP id 128so5686652wmo.3
        for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2017 11:27:10 -0800 (PST)
Date: Tue, 21 Nov 2017 12:27:06 -0700
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc: "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH RFC v3 1/2] tpm: Keep CLKRUN enabled throughout the
 duration of transmit_cmd()
Message-ID: <20171121192706.GI18272@ziepe.ca>
References: <1510783632-55866-1-git-send-email-azhar.shaikh@intel.com>
 <1510783632-55866-2-git-send-email-azhar.shaikh@intel.com>
 <20171120183441.GC29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E937@ORSMSX109.amr.corp.intel.com>
 <20171120192117.GJ29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896E9A7@ORSMSX109.amr.corp.intel.com>
 <20171120193829.GM29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896EA2E@ORSMSX109.amr.corp.intel.com>
 <20171120232604.GS29075@ziepe.ca>
 <5FFFAD06ADE1CA4381B3F0F7C6AF582896EE30@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5FFFAD06ADE1CA4381B3F0F7C6AF582896EE30@ORSMSX109.amr.corp.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 21, 2017 at 07:18:25PM +0000, Shaikh, Azhar wrote:

> Having a wider range would mean clocks running for a bit longer
> duration than current implementation, which might have power
> implications, minimal though, would be good if we could avoid it
> from here :-) Also since this patch has already passed rigorous
> testing as mentioned earlier, hence would be good if we have the
> current implementation as it is.

I'll leave it to you then!

Jason
