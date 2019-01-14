Return-Path: <SRS0=QOPP=PW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C11C43387
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Jan 2019 19:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3A1206B7
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Jan 2019 19:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfANTjo (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:39:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42152 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANTjo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jan 2019 14:39:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id 68so130310qke.9
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jan 2019 11:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tzt7soaLdEkDzFReT7bw9s/TgXujfQncxjL2DxsCxww=;
        b=G5BBdxk2fCsunuIOkeEKeMa73LSWh2ZQZ1aBGsBg+uugiQg/CfkC+wFmqks1VTIjXc
         FswYPwIXMFNvBoZorD86alRkRD3HxeEv7ZxY0LWbq4/bGUk9R+4DolOsoXG5RKA/uykk
         37tTsZvGoD8y+npVsonTDsrVnag3E/O1riUSTZyF0Z/t+OZ8pjrEVpaTV85YiVRJETi8
         YsCQFhvZY9Vg0JlHEmSTBGC6BTqJordLajPTakhVSEau8eAUUwqnEzCFOiFSi/kRdXQz
         QgXMyt4I/nq2/qhbIwQgxpCyOT4uZhhUFfACTlmUFgYcCtYeBqB6as7LdMxV2ku5pkm4
         FRIA==
X-Gm-Message-State: AJcUukdfFdG2GFNPry0BAlGh5OUrMPJk9i8c/RQ0Tv/dHkoNTvNVsWk4
        MORrFZQ6ftXCZhh8yLX3RlcXKA==
X-Google-Smtp-Source: ALg8bN4DC+Xnv/9ueKmeYnxYMRhmU7hlLLvK2F33DQfVFPKoFbRMZiYejmgICj0+WYg04aa0sfcFgw==
X-Received: by 2002:a37:9f92:: with SMTP id i140mr52742qke.131.1547494783164;
        Mon, 14 Jan 2019 11:39:43 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id x202sm40964960qka.67.2019.01.14.11.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 11:39:42 -0800 (PST)
Date:   Mon, 14 Jan 2019 12:39:40 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Alexey Klimov <aklimov@redhat.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH REVIEW 2/2] tpm_tis: override durations for STM tpm with
 firmware 1.2.8.28
Message-ID: <20190114193940.mylziev4xhidmazs@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <20181214132115.26223-1-aklimov@redhat.com>
 <20181214132115.26223-2-aklimov@redhat.com>
 <20190103131453.GC10491@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190103131453.GC10491@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu Jan 03 19, Jarkko Sakkinen wrote:
>On Fri, Dec 14, 2018 at 01:21:15PM +0000, Alexey Klimov wrote:
>> There was revealed a bug in the STM TPM chipset used in Dell R415s.
>> Bug is observed so far only on chipset firmware 1.2.8.28
>> (1.2 TPM, device-id 0x0, rev-id 78). After some number of
>> operations chipset hangs and stays in inconsistent state:
>>
>> tpm_tis 00:09: Operation Timed out
>> tpm_tis 00:09: tpm_transmit: tpm_send: error -5
>>
>> Durations returned by the chip are the same like on other
>> firmware revisions but apparently with specifically 1.2.8.28 fw
>> durations should be reset to 2 minutes to enable tpm chip work
>> properly. No working way of updating firmware was found.
>>
>> This patch adds implementation of ->update_durations method
>> that matches only STM devices with specific firmware version.
>>
>> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
>> Signed-off-by: Alexey Klimov <aklimov@redhat.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 90 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 90 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index d2345d9fd7b5..e0bdca647460 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -514,6 +514,95 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>>  	return rc;
>>  }
>>
>> +struct tis_vendor_durations_override {
>> +	u32 did_vid;
>> +	struct tpm_version_t tpm_version;
>> +	unsigned long durs[3];
>
>I would rather have just "unsigned long durations[3];".
>
>> +};
>> +
>> +static
>> +const struct tis_vendor_durations_override vendor_dur_overrides[] = {
>> +	/* STMicroelectronics 0x104a */
>> +	{ 0x0000104A,
>> +	{ 1, 2, 8, 28 },
>> +	{ (2 * 60 * HZ), (2 * 60 * HZ), (2 * 60 * HZ) } },
>> +};
>> +
>> +static bool tpm_tis_update_durations(struct tpm_chip *chip,
>> +					unsigned long *duration_cap)
>> +{
>> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> +	u32 did_vid;
>> +	int i, rc;
>> +	cap_t cap;
>> +
>> +	if (chip->ops->clk_enable != NULL)
>> +		chip->ops->clk_enable(chip, true);
>> +
>> +	rc = tpm_tis_read32(priv, TPM_DID_VID(0), &did_vid);
>> +	if (rc < 0)
>> +		goto out;
>> +
>> +	for (i = 0; i != ARRAY_SIZE(vendor_dur_overrides); i++) {
>> +		if (vendor_dur_overrides[i].did_vid != did_vid)
>> +			continue;
>> +
>> +		/* Try to get a TPM version 1.2 TPM_CAP_VERSION_INFO */
>> +		rc = tpm_getcap(chip, TPM_CAP_VERSION_1_2, &cap,
>> +			"attempting to determine the 1.2 version",
>> +			sizeof(cap.tpm_version_1_2));
>
>Not properly aligned.
>
>> +		if (!rc) {
>> +			if ((cap.tpm_version_1_2.Major ==
>> +				vendor_dur_overrides[i].tpm_version.Major) &&
>> +				(cap.tpm_version_1_2.Minor ==
>> +				vendor_dur_overrides[i].tpm_version.Minor) &&
>> +				(cap.tpm_version_1_2.revMajor ==
>> +				vendor_dur_overrides[i].tpm_version.revMajor) &&
>> +				(cap.tpm_version_1_2.revMinor ==
>> +				vendor_dur_overrides[i].tpm_version.revMinor)) {
>
>Same.
>
>> +
>> +				memcpy(duration_cap,
>> +					vendor_dur_overrides[i].durs,
>> +					sizeof(vendor_dur_overrides[i].durs));
>
>Same.
>
>> +				rc = true;
>> +				goto out;
>> +			}
>> +		} else {
>> +			rc = tpm_getcap(chip, TPM_CAP_VERSION_1_1, &cap,
>> +				"attempting to determine the 1.1 version",
>> +				sizeof(cap.tpm_version));
>
>Same.
>
>> +			if (rc) {
>> +				rc = false;
>> +				goto out;
>> +			}
>> +			if ((cap.tpm_version.Major ==
>> +				vendor_dur_overrides[i].tpm_version.Major) &&
>> +				(cap.tpm_version.Minor ==
>> +				vendor_dur_overrides[i].tpm_version.Minor) &&
>> +				(cap.tpm_version.revMajor ==
>> +				vendor_dur_overrides[i].tpm_version.revMajor) &&
>> +				(cap.tpm_version.revMinor ==
>> +				vendor_dur_overrides[i].tpm_version.revMinor)) {
>
>Same.
>
>> +
>> +				memcpy(duration_cap,
>> +					vendor_dur_overrides[i].durs,
>> +					sizeof(vendor_dur_overrides[i].durs));
>
>Same.
>
>> +				rc = true;
>> +				goto out;
>> +			}
>> +		}
>> +	}
>> +
>> +	rc = false;
>
>Shoud return proper rc instead of bool.
>

Alexey was following the example of tpm_tis_update_timeouts() which
returns true if the timeouts were updated, and otherwise returns
false. The bool here makes sense to me, but what rc would you suggest
in this case?

Regards,
Jerry

>> +
>> +out:
>> +	if (chip->ops->clk_enable != NULL)
>> +		chip->ops->clk_enable(chip, false);
>> +
>> +	return rc;
>> +}
>> +
>> +
>>  struct tis_vendor_timeout_override {
>>  	u32 did_vid;
>>  	unsigned long timeout_us[4];
>> @@ -847,6 +936,7 @@ static const struct tpm_class_ops tpm_tis = {
>>  	.send = tpm_tis_send,
>>  	.cancel = tpm_tis_ready,
>>  	.update_timeouts = tpm_tis_update_timeouts,
>> +	.update_durations = tpm_tis_update_durations,
>>  	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>>  	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>>  	.req_canceled = tpm_tis_req_canceled,
>> --
>> 2.14.4
>>
>
>/Jarkko
