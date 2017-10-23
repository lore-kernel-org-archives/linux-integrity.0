Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:63724 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932191AbdJWNvT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 09:51:19 -0400
Subject: Re: [PATCH] tpm_tis_core: Use common error handling code in
 tpm_tis_send_data()
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <fb0a6fbb-db2f-ce3f-f1c2-02f934accc4e@users.sourceforge.net>
 <20171023134202.d6td6vvhd7pfv5ue@linux.intel.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <455e93f6-c419-8318-6129-80e99fc8552f@users.sourceforge.net>
Date: Mon, 23 Oct 2017 15:51:09 +0200
MIME-Version: 1.0
In-Reply-To: <20171023134202.d6td6vvhd7pfv5ue@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

>> @@ -315,6 +311,8 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>>  
>>  	return 0;
>>  
>> +report_timeout:
>> +	rc = -ETIME;
>>  out_err:
>>  	tpm_tis_ready(chip);
>>  	return rc;
>> -- 
>> 2.14.2
>>
> 
> NAK. wait_for_tpm_stat() should give that error code.

This is a pity that you reject another bit of code reduction.

Regards,
Markus
