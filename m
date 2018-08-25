Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:11605 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726110AbeHYHjY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 25 Aug 2018 03:39:24 -0400
Subject: Re: [f2fs-dev] [RFC PATCH 02/10] fs-verity: add data verification
 hooks for ->readpages()
To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Michael Halcrow <mhalcrow@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Victor Hsieh <victorhsieh@google.com>
References: <20180824161642.1144-1-ebiggers@kernel.org>
 <20180824161642.1144-3-ebiggers@kernel.org>
 <2f2382c3-e5e9-f0da-dc89-42dfc7b2b636@huawei.com>
 <20180825034544.GA5281@thunk.org>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <cb646950-94ea-9b28-80f1-3c840ad85581@huawei.com>
Date: Sat, 25 Aug 2018 12:00:04 +0800
MIME-Version: 1.0
In-Reply-To: <20180825034544.GA5281@thunk.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Ted,

On 2018/8/25 11:45, Theodore Y. Ts'o wrote:
> On Sat, Aug 25, 2018 at 10:29:26AM +0800, Gao Xiang wrote:
>> My first question is that 'Is there any way to skip to verify pages in a bio?'
>> I am thinking about
>> If metadata and data page are mixed in a filesystem of such kind, they could submit together in a bio, but metadata could be unsuitable for such kind of verification.
>>
>> The second question is related to the first question --- 'Is there any way to verify a partial page?'
>> Take scalability into consideration, some files could be totally inlined or partially inlined in metadata.
>> Is there any way to deal with them in per-file approach? at least --- support for the interface?
> A requirement of both fscrypt and fsverity is that is that block size
> == page size, and that all data is stored in blocks.  Inline data is
> not supported.
> 
> The files that are intended for use with fsverity are large files
> (such as APK files), so optimizing for files smaller than a block was
> not a design goal.

Thanks for your quickly reply. :)

I had seen the background of why Google/Android introduces fs-verity before.

> 

But I have some consideration than the current implementation.... (if it is suitable to discuss, thanks...)

1) Since it is the libfs-like library, I think bio-strict is too strict for its future fs users.

bios could be already organized in filesystem-specific way, which could include some other pages that is unnecessary to be verified.

I could give some example, if some filesystem organizes its bios for decompression, and some data exist in metadata.
It could be hard to use this libfs-like fsverity interface.

2) My last question
"At last, I hope filesystems could select the on-disk position of hash tree and 'struct fsverity_descriptor'
rather than fixed in the end of verity files...I think if fs-verity preparing such support and interfaces could be better....."

is also for some files partially or totally encoded (eg. compressed, or whatever ...)

I think the hash tree is unnecessary to be compressed...so I think it could be better that it can be selected by users (filesystems of course).

Thanks,
Gao Xiang.

> 					- Ted
