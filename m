Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:53559 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932245AbdJWNrD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 09:47:03 -0400
Subject: Re: [PATCH] tpm_i2c_nuvoton: Use common error handling code in
 i2c_nuvoton_send()
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <6d2dcc64-af7a-fb71-f863-10d30914269e@users.sourceforge.net>
 <20171023133813.3xflw4k2npydp26c@linux.intel.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <65bebe74-587b-eb5f-44f3-2e354fd2b82d@users.sourceforge.net>
Date: Mon, 23 Oct 2017 15:46:52 +0200
MIME-Version: 1.0
In-Reply-To: <20171023133813.3xflw4k2npydp26c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

>> @@ -457,12 +455,15 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
>>  					     &priv->read_queue);
>>  	if (rc) {
>>  		dev_err(dev, "%s() timeout command duration\n", __func__);
>> -		i2c_nuvoton_ready(chip);
>> -		return rc;
>> +		goto write_ready;
>>  	}
>>  
>>  	dev_dbg(dev, "%s() -> %zd\n", __func__, len);
>>  	return len;
>> +
>> +write_ready:
>> +	i2c_nuvoton_ready(chip);
>> +	return rc;
>>  }
>>  
>>  static bool i2c_nuvoton_req_canceled(struct tpm_chip *chip, u8 status)
>> -- 
>> 2.14.2
>>
> 
> Setting the commandReady bit gives means to abort the command.
> Setting the bit is not the end goal.

Does your constructive feedback mean that there are any more implementation details
to consider besides the suggested code layout adjustment?


> Use something like err_cancel instead.

I am unsure about this suggestion. Will a simple replacement be sufficient
at the end?

Regards,
Markus
