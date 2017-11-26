Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33846 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751900AbdKZQhu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Nov 2017 11:37:50 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAQGZ4EA096824
        for <linux-integrity@vger.kernel.org>; Sun, 26 Nov 2017 11:37:50 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2efp7x1e85-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 26 Nov 2017 11:37:50 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 26 Nov 2017 16:37:47 -0000
Subject: Re: [PATCH v4 2/4] tpm: ignore burstcount to improve tpm_tis send()
 performance
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: Alexander.Steffen@infineon.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, patrickc@us.ibm.com,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>,
        leendert@paramecium.org
Date: Sun, 26 Nov 2017 11:37:41 -0500
In-Reply-To: <20171126152218.c5fsr7uhs3ipwwha@linux.intel.com>
References: <20171017203232.2262-1-nayna@linux.vnet.ibm.com>
         <20171017203232.2262-3-nayna@linux.vnet.ibm.com>
         <5ef60315f2254b3b8bcc217a572280e5@infineon.com>
         <e98e85a5-fec1-93fb-8daf-d997d5995993@linux.vnet.ibm.com>
         <3ff12c6536de4379aa61cb09ebc9d105@infineon.com>
         <20171123144742.GC8862@swastik>
         <20171126152218.c5fsr7uhs3ipwwha@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1511714261.4361.13.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

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
