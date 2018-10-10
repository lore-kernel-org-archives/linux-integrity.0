Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qt1-f175.google.com ([209.85.160.175]:42594 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbeJJIZF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Oct 2018 04:25:05 -0400
Received: by mail-qt1-f175.google.com with SMTP id j46-v6so3909608qtc.9
        for <linux-integrity@vger.kernel.org>; Tue, 09 Oct 2018 18:05:25 -0700 (PDT)
Subject: Re: LPC 2018
To: Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
From: Monty Wiseman <montywiseman32@gmail.com>
Message-ID: <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>
Date: Tue, 9 Oct 2018 21:05:21 -0400
MIME-Version: 1.0
In-Reply-To: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I'll be there and am interested. I'm co-chair of the TCG Infrastructure 
working group which is defining
an Event log format for firmware and IMA.


On 10/09/2018 11:58 AM, Chuck Lever wrote:
> I'm planning to attend LPC next month. I'm interested in discussing
> IMA on distributed file systems in particular with anyone here who
> might also attend. I expect it would be a narrow topic, so a birds
> of a feather is probably appropriate, but hallway track could work
> too.
>
> I especially would like to discuss the on-disk format of IMA
> metadata, and how the IMA module behaves when it encounters metadata
> it does not recognize (or how you do on-disk format versioning).
>
> I'm still working on an Internet Draft that specifies how to enable
> IMA on NFS files. The biggest challenge has been the lack of IMA
> spec. The current revision of the Draft describes the requirements
> in generic terms, and cites the IMA wiki/white paper only as an
> Informative reference. I believe this will be adequate.
>
> I've also dropped EVM support for now. Two concerns:
> - NFS does not expose some file attributes that EVM protects
> - The format of some file attributes might not be the same on all
>    client OSes.
>
> More to talk about in person, I hope.
>
> https://datatracker.ietf.org/doc/draft-ietf-nfsv4-integrity-measurement/
>
>
> --
> Chuck Lever
>
>
>
