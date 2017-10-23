Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:65392 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932191AbdJWN5u (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 09:57:50 -0400
Subject: Re: [PATCH 1/2] xen-tpmfront: Use common error handling code in
 vtpm_send()
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <cf592c7d-8fbc-833b-fa1a-ff9e91c3734c@users.sourceforge.net>
 <9cfcbfd0-75c3-4de5-f735-0ace23d2abcb@users.sourceforge.net>
 <20171023134257.txnpbg5c5z7uaquf@linux.intel.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <f68ee5b6-2da1-e3c8-4d0d-f13a0563385e@users.sourceforge.net>
Date: Mon, 23 Oct 2017 15:57:30 +0200
MIME-Version: 1.0
In-Reply-To: <20171023134257.txnpbg5c5z7uaquf@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

>> @@ -108,11 +106,14 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
>>  	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, duration,
>>  			&priv->read_queue, true) < 0) {
>>  		/* got a signal or timeout, try to cancel */
>> -		vtpm_cancel(chip);
>> -		return -ETIME;
>> +		goto cancel_vtpm;
>>  	}
>>  
>>  	return count;
>> +
>> +cancel_vtpm:
>> +	vtpm_cancel(chip);
>> +	return -ETIME;
>>  }
>>  
>>  static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>> -- 
>> 2.14.2
>>
> 
> NAK

Do you need any more facts to show the influence of the proposed small code reduction?

Regards,
Markus
