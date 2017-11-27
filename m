Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752213AbdK0NWh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Nov 2017 08:22:37 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vARDK1he034464
        for <linux-integrity@vger.kernel.org>; Mon, 27 Nov 2017 08:22:37 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eghrmnu0r-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 27 Nov 2017 08:22:37 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 27 Nov 2017 13:22:33 -0000
Subject: Re: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
 performance
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Leendert van Doorn <leendert@paramecium.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: "Alexander.Steffen@infineon.com" <Alexander.Steffen@infineon.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "tpmdd@selhorst.net" <tpmdd@selhorst.net>,
        "patrickc@us.ibm.com" <patrickc@us.ibm.com>,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Date: Mon, 27 Nov 2017 08:22:28 -0500
In-Reply-To: <694703AB-68E1-4026-937C-61DBBE08DB4B@paramecium.org>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
         <20171017203232.2262-3-nayna@linux.vnet.ibm.com>
         <5ef60315f2254b3b8bcc217a572280e5@infineon.com>
         <e98e85a5-fec1-93fb-8daf-d997d5995993@linux.vnet.ibm.com>
         <3ff12c6536de4379aa61cb09ebc9d105@infineon.com>
         <20171123144742.GC8862@swastik>
         <20171126152218.c5fsr7uhs3ipwwha@linux.intel.com>
         <1511714261.4361.13.camel@linux.vnet.ibm.com>
         <694703AB-68E1-4026-937C-61DBBE08DB4B@paramecium.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1511788948.4361.39.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi, Leendert!

On Mon, 2017-11-27 at 07:08 +0000, Leendert van Doorn wrote:
> Hmm, this is almost 20 years old code (
> 
> I think the original code did a burst write and didn't check for
> error conditions until the very last byte write. I seem to remember
> that there was some text in the original standard to that effect
> (this may have gone back as far as IBM's ESS spec).

I really appreciate your responding with your recollections.

> The current code does check for error conditions after each write
> byte(s) so I don't think there is any reason for this anymore.
> Changing the while condition to count < len and setting burstcnt =
> min_t(int, burstcnt, len - count) and remove the
> tpm_tis_write8/wait_for_tpm_stat/tpm_tis_status clauses after the
> while loop should be sufficient.

The context for my question was about removing the while loop and
sending all of the data at once, relying on the bus wait states.
 Before making the change, I wanted to make sure there wasn't anything
special about the last byte.

thanks,

Mimi
