Return-Path: <SRS0=87pL=ZN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F6BC432C0
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Nov 2019 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F5620643
	for <linux-integrity@archiver.kernel.org>; Thu, 21 Nov 2019 16:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A1wFisUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfKUQRM (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:17:12 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41360 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUQRM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Nov 2019 11:17:12 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0A02320B7185;
        Thu, 21 Nov 2019 08:17:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A02320B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574353032;
        bh=0NGwDic+CWZB9bud1PRLutHtUsmXVrkpBUEVqMzsVAQ=;
        h=From:Subject:To:Cc:Date:From;
        b=A1wFisUrfB9OEk6PIKwUhzWIV9IIDSY4uoJzNDiCeJ78Leu6bD7rQxaw8Ont4njLq
         iuAfG8rn2elfBXeCX4VBLupVrYwQPMuCsUY09W3OhnctBcuGVfY2oHj8xJmIZpkcwZ
         U1dHGFiPP7t5kZLNEztfWTwSw+z1Y6E89iYVjE/E=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: IMA: Data included in the key measurement
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     James Morris <jamorris@linuxonhyperv.com>
Message-ID: <19242774-688e-58ff-40f8-e346d6ba4339@linux.microsoft.com>
Date:   Thu, 21 Nov 2019 08:17:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

 >>> everything needed for verifying a signature is included in
 >>> the key measurement.

Regarding the requirement you had stated above, I would like some 
clarification.

When I started this change to measure keys through IMA, the use case we 
had in mind was enabling an attestation service, for instance, to verify 
if the client has only known good (trusted) keys - for example, in 
keyrings such as ".builtin_trusted_keys", ".ima", etc.

On the client IMA verifies the signature of system binaries using keys 
in the IMA keyring. And, if the config namely 
CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled, 
only keys signed by a built-in trusted key can be added to the IMA keyring.

An attestation service can keep a list of public keys of "known good 
(trusted)" keys for various keyrings, and verify against the measurement 
data provided by the client.

To achieve the above we decided to include only the public key in the 
key measurement buffer.

I would like to know what benefit we'd get by including "everything 
needed for verifying a signature in the key measurement"?

 From testing point of view, if we have the certificate (like the .DER 
file), we can validate the key measurement data in the IMA log.

Do you see a need to include more data or the entire cert for the 
product code?

thanks,
  -lakshmi
