Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:20428 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754364AbeALI2V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Jan 2018 03:28:21 -0500
Subject: Re: [RFC][PATCH 8/9] tpm_tis_spi: add delay between wait state
 retries
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        <jarkko.sakkinen@linux.intel.com>, <nayna@linux.vnet.ibm.com>,
        <kgold@linux.vnet.ibm.com>, <linux-integrity@vger.kernel.org>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171208184658.9588-9-Alexander.Steffen@infineon.com>
 <1515700018.3420.13.camel@linux.vnet.ibm.com>
From: Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <db63c75f-464d-2fbc-3e97-ea3ef162cea5@infineon.com>
Date: Fri, 12 Jan 2018 09:28:19 +0100
MIME-Version: 1.0
In-Reply-To: <1515700018.3420.13.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11.01.2018 20:46, Mimi Zohar wrote:
> Hi Alexander,
> 
> On Fri, 2017-12-08 at 19:46 +0100, Alexander Steffen wrote:
>> There do not seem to be any real limits one the amount/duration of wait
>> states that the TPM is allowed to generate. So at least give the TPM some
>> time to clean up the situation that caused the wait states instead of
>> retrying the transfers as fast as possible.
> 
> Without this patch, the TPM performance on the pi is amazing!  A
> thousand extends takes ~6.5 seconds.  Unfortunately, the same thousand
> extends with this patch takes > 2+ minutes.  TPM_TIMEOUT (5 msecs) is
> a really long time.  Why so long?

My problem is the lack of specification for the wait state 
functionality. How many wait states may be signaled by the TPM? For how 
long may the TPM signal wait states? Do you know any more details?

The current implementation is based on the assumption that wait states 
are the exception rather than the rule, so that longer delays are 
acceptable. And without knowing for how long wait states can happen, I 
chose rather longer delays (with this patch the TPM has several seconds 
to clear wait states) to avoid failing on some unknown TPM 
implementation in some special cases.

What would be a better implementation? No delay and simply retry for 
five seconds?

What TPMs are you using for your tests? At least for the TPMs that I 
have available for my tests (with a FIFO size of ~256 bytes) I would not 
expect any wait states for extend commands.

Alexander

> 
> Mimi
>    
> 
>> Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
>> ---
>>   drivers/char/tpm/tpm_tis_spi.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
>> index 2cc6aa9..e53c9c3 100644
>> --- a/drivers/char/tpm/tpm_tis_spi.c
>> +++ b/drivers/char/tpm/tpm_tis_spi.c
>> @@ -88,7 +88,7 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>>
>>   		if ((phy->iobuf[3] & 0x01) == 0) {
>>   			// handle SPI wait states
>> -			for (i = 0; i < TPM_RETRY; i++) {
>> +			for (i = 1; i <= TPM_RETRY; i++) {
>>   				phy->iobuf[0] = addr;
>>   				spi_xfer.len = 1;
>>   				spi_message_init(&m);
>> @@ -98,9 +98,10 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>>   					goto exit;
>>   				if (phy->iobuf[0] & 0x01)
>>   					break;
>> +				tpm_msleep(i * TPM_TIMEOUT);
>>   			}
>>
>> -			if (i == TPM_RETRY) {
>> +			if (i > TPM_RETRY) {
>>   				spi_xfer.tx_buf = NULL;
>>   				spi_xfer.rx_buf = NULL;
>>   				spi_xfer.len = 0;
> 
>
