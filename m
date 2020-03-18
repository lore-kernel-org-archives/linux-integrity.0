Return-Path: <SRS0=QKG3=5D=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E113C10DCE
	for <linux-integrity@archiver.kernel.org>; Wed, 18 Mar 2020 17:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B45020752
	for <linux-integrity@archiver.kernel.org>; Wed, 18 Mar 2020 17:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b4k7208q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCRRWu (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:22:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48472 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRRWu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Mar 2020 13:22:50 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 25C7C20B9C02;
        Wed, 18 Mar 2020 10:22:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25C7C20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1584552169;
        bh=R2z5utNegpjdpBUp8OL0jZwaYYNpLVfrrycstEKR12g=;
        h=From:Subject:To:Cc:Date:From;
        b=b4k7208q88j4NB5jbIcHZExTB0IQ41jmqpW/Awumd1uhyiVGCP25kr+lG3ql4Tf5/
         /2IpZMZUCnQLWOgkYIAOCKO+dII/DV8e6CwA11Xgd41fzTuI4KGotuhlvcn6hwaixX
         l/bzHc//G8vVvkGlWuTuyebEgNjwLOUOHgxVOMbA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [RFC] IMA: Use Trusted Execution Environment to protect IMA keys and
 operations
To:     zohar@linux.ibm.com, James.Bottomley@HansenPartnership.com,
        dhowells@redhat.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, keyrings@vger.kernel.org,
        James Morris <jamorris@linuxonhyperv.com>,
        balajib@microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <f175c12e-24d8-745e-394d-6c850e01cf6c@linux.microsoft.com>
Date:   Wed, 18 Mar 2020 10:22:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Linux kernel stores keys, secrets, and other such sensitive and high 
value entities in memory. An attacker can exploit a kernel vulnerability 
to modify existing entities or inject new ones to gain access to 
privileged operations.

IMA uses asymmetric keys stored in keyrings such as .ima, .evm to 
validate digital signature of system files, kernel modules, etc. An 
attacker can utilize a kernel exploit to modify or inject keys into 
these system keyrings and hijack integrity operations performed by the 
IMA subsystem.

We can tackle this issue by storing such sensitive kernel data in
a secure environment where they cannot be easily tampered with and
performing the integrity operations in this environment.

For instance, ARM platform supports TrustZone (TZ) and Trusted Execution 
Environment (TEE), Intel provides Software Guard Extensions (SGX), which 
can be leveraged for this purpose.

Proposal
--------

  Loading IMA Keyrings
   => IMA keyrings and the keys in those keyrings will be maintained
      inside TZ.
   => These keyrings will be created and keys populated in the TZ when
      the machine initializes TZ.
   => Write access to these keyrings\keys will be blocked once they
      are initialized.

  Digital Signature Appraisal
   Digital signature stored in security.ima, security.evm, or appended to
   the module are verified by functions integrity_digsig_verify() or
   integrity_modsig_verify().

  The move to TZ\TEE can be done in phases:

   Phase #1:
    Maintain the keyrings\keys in TZ. Integrity functions execute in
    the "Normal World" (Untrusted environment). They query the key
    from TZ and validate signature.

   Phase #2:
    The integrity functions and their dependencies that validate
    signature are executed in TEE.

   Phase #3:
    Integrity measurement, appraisal, and logging are executed in TEE.

  Key Queries
   KEYS subsystem need to be updated to route the calls to TZ
   for queries for IMA keyrings such that callers (such as, user mode
   utilities such as KEYCTL, EVMCTL, etc.) work seamlessly.

Please provide comments\feedback on the proposal.

Thanks,
  -lakshmi
