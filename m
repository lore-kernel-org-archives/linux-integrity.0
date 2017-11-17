Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from lhrrgout.huawei.com ([194.213.3.17]:44580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751322AbdKQIzr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Nov 2017 03:55:47 -0500
Subject: Re: [PATCH v2 00/15] ima: digest list feature
To: Kees Cook <keescook@chromium.org>
CC: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <silviu.vlasceanu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
 <1510061855.3425.113.camel@linux.vnet.ibm.com>
 <aec4e72a-7f74-43e7-c226-f51077e7c619@huawei.com>
 <CAGXu5jKjXqn-1j881vYc1F0POPhPJOPZB1w=W_zfgdXTsiyX6A@mail.gmail.com>
From: Roberto Sassu <roberto.sassu@huawei.com>
Message-ID: <ddad05d7-1e74-e7b4-d59c-f2e217aa92b5@huawei.com>
Date: Fri, 17 Nov 2017 09:55:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKjXqn-1j881vYc1F0POPhPJOPZB1w=W_zfgdXTsiyX6A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/17/2017 2:08 AM, Kees Cook wrote:
> On Tue, Nov 7, 2017 at 8:45 AM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
>> On 11/7/2017 2:37 PM, Mimi Zohar wrote:
>>> Normally, the protection of kernel memory is out of scope for IMA.
>>> This patch set introduces an in kernel white list, which would be a
>>> prime target for attackers looking for ways of by-passing IMA-
>>> measurement, IMA-appraisal and IMA-audit.  Others might disagree, but
>>> from my perspective, this risk is too high.
> 
> BTW, which part of the series does the whitelist? I'd agree generally,
> though: we don't want to make things writable if they're normally
> read-only.

Patch 5/15 introduces the hash table ima_digests_htable and the
functions to add/search file digests

Patches 6-7-8/15 add file digests to ima_digests_htable

Patch 10/15 searches file digests in ima_digests_htable


Original files containing digest lists are discarded after being parsed.


>> It would be much easier for an attacker to just set ima_policy_flag to
>> zero.
> 
> That's a fair point. I wonder if ima_policy_flag could be marked
> __ro_after_init? Most of the writes are from __init sections, but I
> haven't looked closely at when ima_update_policy() gets called.

Unfortunately not. New policies can be loaded by writing to a file in
the securityfs filesystem. They could enable different actions
(measurement/appraisal/audit).

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
