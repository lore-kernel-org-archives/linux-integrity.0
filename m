Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8525 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756886AbdJRDg6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 23:36:58 -0400
Subject: Re: [Linux-ima-devel] [PATCH] ima: fix ineffective default hash
 algorithm due to invalid hash algorithm boot argument
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
CC: linux-integrity <linux-integrity@vger.kernel.org>
References: <3aaaf65f-d3b0-f770-f074-11e8f9796685@huawei.com>
 <1508277513.4513.63.camel@linux.vnet.ibm.com>
From: Boshi Wang <wangboshi@huawei.com>
Message-ID: <dd38b9cb-dad9-5c91-d039-dd13862a1aa4@huawei.com>
Date: Wed, 18 Oct 2017 11:36:41 +0800
MIME-Version: 1.0
In-Reply-To: <1508277513.4513.63.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


On 2017/10/18 5:58, Mimi Zohar wrote:
> This patch does not apply properly.  To see the problem, save the
> patch as an mbox file and then apply it using git am <filename.mbox>.
I'm sorry. That's my fault. The corrected patch has committed. And thank you.
