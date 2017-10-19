Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:61159 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752507AbdJSMgw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 08:36:52 -0400
Subject: Re: [PATCH 4/4] char/tpm: Less checks in tpm_ibmvtpm_probe() after
 error detection
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Kenneth Goldman <kgold@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <09a2c3a1-1b10-507d-a866-258b570f6da1@users.sourceforge.net>
 <20171019135632.4af42743@kitsune.suse.cz>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <9327cc83-448e-8404-af00-73f6409e269e@users.sourceforge.net>
Date: Thu, 19 Oct 2017 14:36:09 +0200
MIME-Version: 1.0
In-Reply-To: <20171019135632.4af42743@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

>> @@ -683,13 +683,10 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>> reg_crq_cleanup:
>>  	dma_unmap_single(dev, ibmvtpm->crq_dma_handle,
>> CRQ_RES_BUF_SIZE, DMA_BIDIRECTIONAL);
>> -cleanup:
>> -	if (ibmvtpm) {
>> -		if (crq_q->crq_addr)
>> -			free_page((unsigned long)crq_q->crq_addr);
>> -		kfree(ibmvtpm);
>> -	}
>> -
> 
> I think a single cleanup section is better than many labels that just
> avoid a single null check.

I proposed to delete two unnecessary condition checks together with
an adjustment of jump targets.

Regards,
Markus
