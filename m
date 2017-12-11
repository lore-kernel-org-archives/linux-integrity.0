Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:62385 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbdLKTht (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Dec 2017 14:37:49 -0500
To: linux-integrity@vger.kernel.org, azhar.shaikh@intel.com,
        jarkko.sakkinen@linux.intel.com
Cc: linux-kernel@vger.kernel.org, james.l.morris@oracle.com
From: James Ettle <james@ettle.org.uk>
Subject: [BISECTED] tpm CLKRUN breaks PS/2 keyboard and touchpad on Braswell
 system
Message-ID: <57d96314-cc9c-0656-186e-4eb77a132b70@ettle.org.uk>
Date: Mon, 11 Dec 2017 19:37:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello,

[First: Apologies if cross-posting from Kernel.org BZ is bad form; my distro BZ advised I post this to your mailing list as well.]

Situation: enabling TPM on a Clevo W510LU with an Intel N3160 CPU breaks PS/2 keyboard and mouse. They just don't respond until after a suspend/resume cycle, and after that they later stop after a while.

I have confirmed this by blacklisting tpm modules. I noticed this first with kernel 4.13, and have bisected it down to:

5e572cab92f0bb56ca1e6e5ee4d807663a7ccbad is the first bad commit
commit 5e572cab92f0bb56ca1e6e5ee4d807663a7ccbad
Author: Azhar Shaikh <azhar.shaikh@intel.com>
Date:   Sun Jun 18 19:17:59 2017 -0700

    tpm: Enable CLKRUN protocol for Braswell systems
    
    To overcome a hardware limitation on Intel Braswell systems,
    disable CLKRUN protocol during TPM transactions and re-enable
    once the transaction is completed.
    
    Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
    Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
    Signed-off-by: James Morris <james.l.morris@oracle.com>

:040000 040000 5437c91886cb62c497255f2c60dbedd7268ab50d 1863a1738ded35a817aad52f9f2b451bd43623d7 M	drivers

Currently in Kernel.org bugzilla 197287.

Please let me know if you need any further info.

Many thanks,
James.
