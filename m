Return-Path: <SRS0=6KUl=XT=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9E8C432C1
	for <linux-integrity@archiver.kernel.org>; Tue, 24 Sep 2019 22:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530B32146E
	for <linux-integrity@archiver.kernel.org>; Tue, 24 Sep 2019 22:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391727AbfIXWbc (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 24 Sep 2019 18:31:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47472 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389629AbfIXWbb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Sep 2019 18:31:31 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 37B0C2010688;
        Tue, 24 Sep 2019 15:31:27 -0700 (PDT)
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: ima_tpm_chip is queried and saved only at IMA init, but never later
Message-ID: <d9c28fc6-bd5e-95ae-6386-84e87125c41d@linux.microsoft.com>
Date:   Tue, 24 Sep 2019 15:31:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When IMA is initialized the default TPM is queried and saved.
If at this point a TPM wasn't available, but is detected and surfaced 
later by the system, IMA doesn't update the TPM information.

security/integrity/ima/ima_init.c
int __init ima_init(void)
{
	int rc;

	ima_tpm_chip = tpm_default_chip();
	if (!ima_tpm_chip)
		pr_info("No TPM chip found, activating TPM-bypass!\n");
	...
}

TPM PCR update function in IMA is essentially a NOP if TPM wasn't 
detected during IMA init.

security/integrity/ima/ima_queue.c
static int ima_pcr_extend(const u8 *hash, int pcr)
{
	int result = 0;

	if (!ima_tpm_chip)
		return result;
	...
}

In one configuration I am testing, I see the TPM appear post IMA Init. 
Likely this is rare, but I was wondering if there was a reason why TPM 
information is only queried during IMA init, but never updated at a 
later point.

Thanks,
  -lakshmi
