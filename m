Return-Path: <SRS0=SOqD=2A=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E3CC43603
	for <linux-integrity@archiver.kernel.org>; Tue, 10 Dec 2019 22:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE6320838
	for <linux-integrity@archiver.kernel.org>; Tue, 10 Dec 2019 22:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E+NaJ35K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbfLJWhU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:37:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54062 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbfLJWhT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Dec 2019 17:37:19 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 94FF320B7187;
        Tue, 10 Dec 2019 14:37:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94FF320B7187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576017438;
        bh=EabcIUSm95ln/x8SaeAaqGu8PxIoseXQ2Xb4iEAC1ic=;
        h=From:To:Subject:Date:From;
        b=E+NaJ35K7Cw8gsBbSSqiZHpYh5Vb1gyQss8dnq3b9nmHZIshg6nTkgFYs6/wy5BdA
         J2Cox6e486yRp5SR3kmqPxC2/BMShgvoZaiO8IXnNZ3LjvF/PiCTKSCGKrscJksK/H
         KCQMSsWEPT5ICivt6UTaCPNtfSVyefFwTDO2qYCE=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        jarkko.sakkinen@linux.intel.com, Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Does IMA support SHA-256 PCR banks?
Message-ID: <62e91411-d38d-8b75-bf0e-849fdd3c447f@linux.microsoft.com>
Date:   Tue, 10 Dec 2019 14:37:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I noticed that even when SHA-256 is selected as the digest algorithm for 
IMA measurement, the PCR hash is still SHA-1.

A net search found the text given below in the following wiki:
    https://wiki.strongswan.org/projects/strongswan/wiki/IMA

**********************************************************************
Since SHA-1 has been "shattered" we recommend to use SHA-256 for the 
file measurement hashes.

IMA implementation does not support SHA-256 PCR banks yet, so the 
SHA-256 file hashes are extended into SHA-1 PCR registers.
**********************************************************************

Is the above still true?

In ima_init_digests() the digest algorithm for PCR extend is set from 
the digest algorithm set in the PCR banks.

Is there a way to configure IMA to use SHA-256 PCR banks?

int __init ima_init_digests(void)
{
...
	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++)
		digests[i].alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
...
	
}

thanks,
  -lakshmi
