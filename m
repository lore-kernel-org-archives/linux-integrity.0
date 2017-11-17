Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:39720 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdKQBI7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Nov 2017 20:08:59 -0500
Received: by mail-it0-f46.google.com with SMTP id y15so2294190ita.4
        for <linux-integrity@vger.kernel.org>; Thu, 16 Nov 2017 17:08:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <aec4e72a-7f74-43e7-c226-f51077e7c619@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
 <1510061855.3425.113.camel@linux.vnet.ibm.com> <aec4e72a-7f74-43e7-c226-f51077e7c619@huawei.com>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 16 Nov 2017 17:08:57 -0800
Message-ID: <CAGXu5jKjXqn-1j881vYc1F0POPhPJOPZB1w=W_zfgdXTsiyX6A@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] ima: digest list feature
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        silviu.vlasceanu@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, Nov 7, 2017 at 8:45 AM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> On 11/7/2017 2:37 PM, Mimi Zohar wrote:
>> Normally, the protection of kernel memory is out of scope for IMA.
>> This patch set introduces an in kernel white list, which would be a
>> prime target for attackers looking for ways of by-passing IMA-
>> measurement, IMA-appraisal and IMA-audit.  Others might disagree, but
>> from my perspective, this risk is too high.

BTW, which part of the series does the whitelist? I'd agree generally,
though: we don't want to make things writable if they're normally
read-only.

> It would be much easier for an attacker to just set ima_policy_flag to
> zero.

That's a fair point. I wonder if ima_policy_flag could be marked
__ro_after_init? Most of the writes are from __init sections, but I
haven't looked closely at when ima_update_policy() gets called.

-Kees

-- 
Kees Cook
Pixel Security
