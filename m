Return-Path: <SRS0=v5+S=5I=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B64C54EEB
	for <linux-integrity@archiver.kernel.org>; Mon, 23 Mar 2020 15:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD6E20714
	for <linux-integrity@archiver.kernel.org>; Mon, 23 Mar 2020 15:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="US/A8C32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgCWPsw (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:48:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38368 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbgCWPsw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Mar 2020 11:48:52 -0400
Received: from [192.168.0.109] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id E55F820B4737;
        Mon, 23 Mar 2020 08:48:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E55F820B4737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1584978531;
        bh=hua0P8STR7JJsHPei1P1PgDLg81VkTX0mtmKEHN/IZ0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=US/A8C32RPPJhhm61yzbPH7GkMc3vAnwrH+d/maF6U2KcjdBPnUtvO+j89GBo1IAT
         wXrEdrMBMYhMbEk9ufmkrteQ3aLqI2JZc6xA0ARRFk1Z5X6hCOEgi3tLkZFfMvdH+r
         3lAVDlz+a8VWpwItJ5fXqug0lU+AKOz3lDfiHdXQ=
Subject: Re: [PATCH v7] ima-evm-utils: Add some tests for evmctl
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190817233348.22349-1-vt@altlinux.org>
 <392fed51-095d-2a6f-5eda-317e3bbc8707@linux.microsoft.com>
 <20200319154957.ijh7tbfp4d7iwcef@altlinux.org>
 <a8b77ade-58bf-88ac-542b-b8fbdd651db4@linux.microsoft.com>
 <62502cc8-c861-0227-cdce-4bbea6b05f3e@linux.microsoft.com>
 <20200322221051.nrbh2nukxenqinwj@altlinux.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <9c75834e-18a7-61e7-5c16-0a207d39efe8@linux.microsoft.com>
Date:   Mon, 23 Mar 2020 08:48:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200322221051.nrbh2nukxenqinwj@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/22/20 3:10 PM, Vitaly Chikunov wrote:

> Please tell what version of ima-evm-utils you are using (what is head
> commit id).

evmctl --version
evmctl 1.2

ima-evm-utils$ git log -1
commit 515c99856ef52bbf680e6dd6c338acfb8d088614 (HEAD -> master, tag: 
v1.2, origin/master, origin/HEAD)
Author: Mimi Zohar <zohar@linux.ibm.com>
Date:   Wed Jul 24 07:24:43 2019 -0400

     ima-evm-utils: Release version 1.2

> 
> Please show me content of your test-rsa1024.key and test-rsa1024.pub,
> and `getfattr -dm. sha1.txt`.
> 

getfattr -dm. sha1.txt
# file: sha1.txt
user.evm=0sAwEwynNeAABQKoPVoXwXHgEEAAmpCSf+2aCO+Wju3CCoc14f43oqquhhgs401WUd39JGdd7kMAWywyrVoz9bRbcTeIXbV0ylfi+snXHJxJwKRpDL07JCvE/XIFiQH0NIgyV85mzkuGZ6i/PGPghPsLAXY1UufCIgPrCAlXvxjUiIF1Vu5Z52UNoXED3zBqQulQqP

cat test-rsa1024.key

-----BEGIN PRIVATE KEY-----
MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMJp/dT5ZOMV1+4j
XmFvutwOIH24kVi+rxG8By10UFM4ESoX1qQFuOMpVWJSHsbHFQRbQy5/JGodDmQ+
s3SlsHoLF60UOzPTmolmNFn31SoTN8yI+0hrlcewH/yv8PbRxVZXJwaRFsiHX9YS
D02xA691B7sIVPxtMUVmMpjiLw4RAgMBAAECgYEAuOmTMoRa/tqB3NDrLgXVVwRg
xvNL23rSjS2oLgWZeO209bJixvNiXT2tJq0w9KPaS6B6D7mCayNj0tkIWwRVCrcr
b8aGZat0Rc/yfQcCf91qd1AFD8SpJ+SbBXJda0qIj21C5zwXg0guwB7m1AB6FS5D
eFg5tWONC8sO2buaobkCQQDfx+UrXqkaEwHp/UrV64qGPwk7dYhR9eZD40GpaCEP
KDSQjYKijjbiLBW+ztgOMm32Q+pVxaGyLyQh8mM43ybfAkEA3meyFe4T3PsAiARg
OKiZXbMqDCWsnB8xQxcpDVcX8oRzF+HaNrzxWpzDf0YhrV8vC6dgYg5f2+UH9Zvu
F7AZDwJAPMMnS85pNiZBF8rp/gn11BvbouR3/mE5g+d6FciraVUuaK2z8fWRm3oC
8YtyiPBSgVLRlzaRgDNiqUEKhg+5mwJBAJH957zVh1xrt7GRjcgjhGkpjtRidqgV
IbU0otIK9cFQiGyI6UE9TgF5HiuR0dGIxc0UlgRIA0zJTyw+q1AJXKkCQEcvowyb
tIjDhgbMb68Euz5RQt6pktASQ7EBquRQ3Pe1MQwWBzF0pJW10f+idzNCHDY554cJ
VD/C7jcQ1twWWNs=
-----END PRIVATE KEY-----

cat test-rsa1024.pub
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDCaf3U+WTjFdfuI15hb7rcDiB9
uJFYvq8RvActdFBTOBEqF9akBbjjKVViUh7GxxUEW0MufyRqHQ5kPrN0pbB6Cxet
FDsz05qJZjRZ99UqEzfMiPtIa5XHsB/8r/D20cVWVycGkRbIh1/WEg9NsQOvdQe7
CFT8bTFFZjKY4i8OEQIDAQAB
-----END PUBLIC KEY-----

thanks,
  -lakshmi
