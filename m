Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qk1-f171.google.com ([209.85.222.171]:35878 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeJLDSA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Oct 2018 23:18:00 -0400
Received: by mail-qk1-f171.google.com with SMTP id a85-v6so6266801qkg.3
        for <linux-integrity@vger.kernel.org>; Thu, 11 Oct 2018 12:49:16 -0700 (PDT)
Subject: Re: LPC 2018
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
        linux-integrity@vger.kernel.org
References: <9808035C-5AE5-4594-BDBF-A51544231608@oracle.com>
 <dfe11979-1afd-1554-fcaa-ebf39e32397d@gmail.com>
 <20181011154847.GA5978@mail.hallyn.com>
From: Monty Wiseman <montywiseman32@gmail.com>
Message-ID: <3839043b-5541-369e-1179-c3c8c1dbfb07@gmail.com>
Date: Thu, 11 Oct 2018 15:49:13 -0400
MIME-Version: 1.0
In-Reply-To: <20181011154847.GA5978@mail.hallyn.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Sorry, I misread. I'll not be at LPC. I'll be at the Embedded Linux and 
LSS week of Oct 22

Monty


On 10/11/2018 11:48 AM, Serge E. Hallyn wrote:
> Would be awesome if some meeting notes could be sent to this list after
> the fact :)
>
> thanks,
> -serge
>
> Quoting Monty Wiseman (montywiseman32@gmail.com):
>> I'll be there and am interested. I'm co-chair of the TCG Infrastructure
>> working group which is defining
>> an Event log format for firmware and IMA.
>>
>>
>> On 10/09/2018 11:58 AM, Chuck Lever wrote:
>>> I'm planning to attend LPC next month. I'm interested in discussing
>>> IMA on distributed file systems in particular with anyone here who
>>> might also attend. I expect it would be a narrow topic, so a birds
>>> of a feather is probably appropriate, but hallway track could work
>>> too.
>>>
>>> I especially would like to discuss the on-disk format of IMA
>>> metadata, and how the IMA module behaves when it encounters metadata
>>> it does not recognize (or how you do on-disk format versioning).
>>>
>>> I'm still working on an Internet Draft that specifies how to enable
>>> IMA on NFS files. The biggest challenge has been the lack of IMA
>>> spec. The current revision of the Draft describes the requirements
>>> in generic terms, and cites the IMA wiki/white paper only as an
>>> Informative reference. I believe this will be adequate.
>>>
>>> I've also dropped EVM support for now. Two concerns:
>>> - NFS does not expose some file attributes that EVM protects
>>> - The format of some file attributes might not be the same on all
>>>     client OSes.
>>>
>>> More to talk about in person, I hope.
>>>
>>> https://datatracker.ietf.org/doc/draft-ietf-nfsv4-integrity-measurement/
>>>
>>>
>>> --
>>> Chuck Lever
>>>
>>>
>>>
