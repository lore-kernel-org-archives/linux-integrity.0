Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:32292
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751138AbdK0HIx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Nov 2017 02:08:53 -0500
From: Leendert van Doorn <leendert@paramecium.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
CC: "Alexander.Steffen@infineon.com" <Alexander.Steffen@infineon.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "tpmdd@selhorst.net" <tpmdd@selhorst.net>,
        "patrickc@us.ibm.com" <patrickc@us.ibm.com>,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Subject: Re: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
 performance
Date: Mon, 27 Nov 2017 07:08:51 +0000
Message-ID: <694703AB-68E1-4026-937C-61DBBE08DB4B@paramecium.org>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
 <20171017203232.2262-3-nayna@linux.vnet.ibm.com>
 <5ef60315f2254b3b8bcc217a572280e5@infineon.com>
 <e98e85a5-fec1-93fb-8daf-d997d5995993@linux.vnet.ibm.com>
 <3ff12c6536de4379aa61cb09ebc9d105@infineon.com>
 <20171123144742.GC8862@swastik>
 <20171126152218.c5fsr7uhs3ipwwha@linux.intel.com>
 <1511714261.4361.13.camel@linux.vnet.ibm.com>
In-Reply-To: <1511714261.4361.13.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hmm, this is almost 20 years old code (

I think the original code did a burst write and didn't check for error conditions until the very last byte write. I seem to remember that there was some text in the original standard to that effect (this may have gone back as far as IBM's ESS spec).

The current code does check for error conditions after each write byte(s) so I don't think there is any reason for this anymore. Changing the while condition to count < len and setting burstcnt = min_t(int, burstcnt, len - count) and remove the tpm_tis_write8/wait_for_tpm_stat/tpm_tis_status clauses after the while loop should be sufficient.

	Leendert

On 11/26/17, 8:37 AM, "Mimi Zohar" <zohar@linux.vnet.ibm.com> wrote:

    [Cc'ing Dave and Leendeert]
    
    Hi Jarkko,
    
    > > It seems that the last byte was sent from the beginning (27084ef
    > > [PATCH] tpm: driver for next generation TPM chips,), does anyone
    > > remember the reason ?
    > 
    > Sent from the beginning?
    
    I went through the commit logs to see if any of the patch descriptions
    have an explanation for sending the last byte separately. Based on
    commit 27084efee0c3 "[PATCH] tpm: driver for next generation TPM
    chips", it seems it's been there since the beginning.
    
    Dave, Leendert, Do either of you remember the reason for
    tpm_tis_send_data() sending the last byte separately?
    
    thanks,
    
    Mimi
    
    
    
