Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22882 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751009AbdLXUh4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Dec 2017 15:37:56 -0500
Date: Sun, 24 Dec 2017 22:37:51 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Alexander.Steffen@infineon.com
Cc: chiu@endlessm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
Subject: Re: TPM driver breaks S3 suspend
Message-ID: <20171224203751.2cyemyq7ugy3uquy@linux.intel.com>
References: <CAB4CAwfSCvj1cudi+MWaB5g2Z67d9DwY1o475YOZD64ma23UiQ@mail.gmail.com>
 <5dbce6c25e7e499aaac05269ba3c0f73@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5dbce6c25e7e499aaac05269ba3c0f73@infineon.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> The correct solution should be something like tpm2_auto_startup
> (execute selftests, if they fail because of the missing startup
> command, execute that and retry the selftests). Interestingly,
> tpm1_auto_startup (same purpose as tpm2_auto_startup, but for TPM 1.2
> instead) does not use the same sequence, the startup-retry part is
> missing. Is there any reason this is done differently for TPM 1.2?
> Otherwise I'd propose to make tpm1_auto_startup follow the same
> sequence as tpm2_auto_startup and then call both from tpm_tis_resume,
> similar to what tpm_chip_register does.

I think the reason for that is that such regression has never reported
on TPM 1.2 platform. No other reason.

/Jarkko
